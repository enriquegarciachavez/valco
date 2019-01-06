/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package panels;

import components.BarCodeTxt;
import components.BasculaPanel;
import components.CustomCellRendered;
import components.ProductosTableModel;
import dao.ProductoDAO;
import java.awt.Point;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableModel;
import mapping.ProductosInventario;
import observables.AbrirCajaObservable;
import observers.AbrirCajaObserver;
import observers.BarCodeTxtObserver;
import observers.BasculaPanelObserver;
import service.BasculaService;

/**
 *
 * @author Karla
 */
public class AbrirCajaPanel extends javax.swing.JPanel implements AbrirCajaObservable,
        BarCodeTxtObserver, BasculaPanelObserver {

    private BarCodeTxt barCode;
    private BasculaPanel bascula;
    private ProductosInventario productoSeleccionado;
    private List<AbrirCajaObserver> observers = new ArrayList<>();
    private CustomCellRendered cellRendered;
    private ProductosTableModel model;
    private BasculaService basculaService;
    private ProductoDAO productosDAO;
    private int row;

    /**
     * Creates new form AbrirCajaPanel
     */
    public AbrirCajaPanel() {
    }

    public void init() {
        try {
            initComponents();
            List<ProductosInventario> productos = productosDAO.getProductosMenudeo();
            for (ProductosInventario producto : productos) {
                model.agregarProducto(producto);
            }
            bascula.registerObserver(this);
            barCode.registerObserver(this);
            basculaPanel.add(bascula);
            bascula.setBounds(20, 25, 380, 120);
            codigoBarrasPanel.add(barCode);
            barCode.setBounds(20, 40, 380, 60);
            tablaProductos.setModel((TableModel) model);
            tablaProductos.setDefaultRenderer(Object.class, (TableCellRenderer) cellRendered);
            tablaProductos.getColumn("Nombre").setPreferredWidth(350);
            tablaProductos.getColumn("Peso").setPreferredWidth(100);
            tablaProductos.getColumn("Etiqueta").setPreferredWidth(320);
            tablaProductos.getColumn("Estatus").setPreferredWidth(100);
            tablaProductos.addMouseListener(new MouseAdapter() {
                public void mousePressed(MouseEvent mouseEvent) {
                    JTable table = (JTable) mouseEvent.getSource();
                    Point point = mouseEvent.getPoint();
                    row = table.rowAtPoint(point);
                    if (mouseEvent.getClickCount() == 2 && table.getSelectedRow() != -1) {
                        productoSeleccionado = (ProductosInventario) tablaProductos.getValueAt(row, 0);
                        productoLabel.setText(productoSeleccionado.toString());
                        kilosLbl.setText(productoSeleccionado.getPeso().toString() + " KG");
                    }
                }
            });
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, ex, "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void segregarProducto() throws Exception {
        if(productoSeleccionado==null){
            JOptionPane.showMessageDialog(this, "Debe seleccionar un producto");
            return;
        }
        if (productoSeleccionado.getMenudeo()) {
            restarKilos();
        } else {
            abrirCaja();
        }
        ProductosInventario productoNuevo = productoSeleccionado.getBasicClone();
        Integer codigo = productoNuevo.getProductosHasProveedores().getProductos().getCodigo();
        productoNuevo.setMenudeo(false);
        productoNuevo.setPeso(bascula.getPeso());
        productoNuevo.setOrdenesCompra(null);
        productoNuevo.setCodigoBarras(basculaService.armarCodigoBarras("S1",
                codigo,
                Integer.parseInt(productoNuevo.getPeso().toString().replaceAll("\\.", "")),
                productosDAO.getNextNumberByType(productoNuevo.getProductosHasProveedores(),
                        false)));
        try {
            productosDAO.insertarProducto(productoNuevo);
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, ex, "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        try {
            basculaService.imprimitCodigoBarrasPDF(productoLabel.getText(),
                    productoNuevo.getPeso().toString(),
                    productoNuevo.getCodigoBarras(),
                    codigo.toString());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        notifyObservers(productoNuevo);
        kilosLbl.setText(productoSeleccionado.getPeso().toString() + " KG");
    }

    private void abrirCaja() throws Exception {
        //SI YA HABIA PRODUCTO PARA MENUDEO ABRIMOS LA CAJA Y SUMAMOS LO QUE
        //SOBRA DE LA CAJA AL MENUDEO QUE YA EXISTIA
        for (ProductosInventario producto : model.getProductos()) {
            if (productoSeleccionado.getProductosHasProveedores().equals(producto.getProductosHasProveedores())) {
                producto.setPeso(producto.getPeso().
                        add(productoSeleccionado.getPeso().subtract(bascula.getPeso())));
                tablaProductos.setValueAt(producto.getPeso().toString(), row, 1);
                productoSeleccionado.setPeso(BigDecimal.ZERO);
                productoSeleccionado.setEstatus("ABIERTA");
                productosDAO.actualizarProductoInventario(productoSeleccionado);
                productosDAO.actualizarProductoInventario(producto);
                productoSeleccionado = producto;
                return;
            }
        }
        //SI NO HAY PRODUCTO PARA MENUDEO ABRIMOS LA CAJA Y PONEMOS LOS KILOS
        //EN MENUDEO
        ProductosInventario productoMenudeoNuevo = productoSeleccionado.getBasicClone();
        productoMenudeoNuevo.setMenudeo(true);
        productoMenudeoNuevo.setCodigoBarras(null);
        productoMenudeoNuevo.setPeso(productoSeleccionado.getPeso().subtract(bascula.getPeso()));
        productoSeleccionado.setPeso(BigDecimal.ZERO);
        productoSeleccionado.setEstatus("ACTIVO");
        productosDAO.insertarProducto(productoMenudeoNuevo);
        model.agregarProducto(productoMenudeoNuevo);
        productosDAO.actualizarProductoInventario(productoSeleccionado);
        productoSeleccionado = productoMenudeoNuevo;
    }

    private void restarKilos() throws Exception {
        //RESTAMOS LOS KILOS A LA CANTIDAD QUE TENEMOS PARA MENUDEO
        productoSeleccionado.setPeso(productoSeleccionado.getPeso().subtract(
                bascula.getPeso()));
        productosDAO.actualizarProductoInventario(productoSeleccionado);
        tablaProductos.setValueAt(productoSeleccionado.getPeso().toString(), row, 1);
    }

    @Override
    public void updateBarCodeTxtObserver() {
        productoSeleccionado = barCode.getProductoInventario();
        productoLabel.setText(productoSeleccionado.toString());
        kilosLbl.setText(productoSeleccionado.getPeso().toString() + " KG");
    }

    @Override
    public void updateBasculaPanelObserver() {
        try {
            segregarProducto();
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, ex, "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    @Override
    public void registerObserver(AbrirCajaObserver observer) {
        observers.add(observer);
    }

    @Override
    public void removeObserver(AbrirCajaObserver observer) {
        observers.remove(observer);
    }

    @Override
    public void notifyObservers(ProductosInventario producto) {
        for (AbrirCajaObserver observer : observers) {
            observer.updateAbrirCajaObserver(producto);
        }
    }

    public BarCodeTxt getBarCode() {
        return barCode;
    }

    public void setBarCode(BarCodeTxt barCode) {
        this.barCode = barCode;
    }

    public BasculaPanel getBascula() {
        return bascula;
    }

    public void setBascula(BasculaPanel bascula) {
        this.bascula = bascula;
    }

    public CustomCellRendered getCellRendered() {
        return cellRendered;
    }

    public void setCellRendered(CustomCellRendered cellRendered) {
        this.cellRendered = cellRendered;
    }

    public ProductosTableModel getModel() {
        return model;
    }

    public void setModel(ProductosTableModel model) {
        this.model = model;
    }

    public BasculaService getBasculaService() {
        return basculaService;
    }

    public void setBasculaService(BasculaService basculaService) {
        this.basculaService = basculaService;
    }

    public ProductoDAO getProductosDAO() {
        return productosDAO;
    }

    public void setProductosDAO(ProductoDAO productosDAO) {
        this.productosDAO = productosDAO;
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jSplitPane1 = new javax.swing.JSplitPane();
        jPanel1 = new javax.swing.JPanel();
        codigoBarrasPanel = new javax.swing.JPanel();
        basculaPanel = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        productoLabel = new javax.swing.JLabel();
        kilosLbl = new javax.swing.JLabel();
        agregar = new javax.swing.JButton();
        jPanel2 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        tablaProductos = new javax.swing.JTable();

        setPreferredSize(new java.awt.Dimension(1558, 455));
        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane1.setDividerLocation(520);

        codigoBarrasPanel.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Ingrese el codigo de barras de la caja por abrir", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 1, 14))); // NOI18N

        javax.swing.GroupLayout codigoBarrasPanelLayout = new javax.swing.GroupLayout(codigoBarrasPanel);
        codigoBarrasPanel.setLayout(codigoBarrasPanelLayout);
        codigoBarrasPanelLayout.setHorizontalGroup(
            codigoBarrasPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 0, Short.MAX_VALUE)
        );
        codigoBarrasPanelLayout.setVerticalGroup(
            codigoBarrasPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 65, Short.MAX_VALUE)
        );

        basculaPanel.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Ingrese el peso", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 1, 14))); // NOI18N

        javax.swing.GroupLayout basculaPanelLayout = new javax.swing.GroupLayout(basculaPanel);
        basculaPanel.setLayout(basculaPanelLayout);
        basculaPanelLayout.setHorizontalGroup(
            basculaPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 493, Short.MAX_VALUE)
        );
        basculaPanelLayout.setVerticalGroup(
            basculaPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 120, Short.MAX_VALUE)
        );

        jLabel1.setFont(new java.awt.Font("Agency FB", 1, 22)); // NOI18N
        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        jLabel1.setText("Producto Seleccionado: ");

        productoLabel.setFont(new java.awt.Font("Agency FB", 1, 22)); // NOI18N
        productoLabel.setText("Sin producto seleccionado");

        kilosLbl.setFont(new java.awt.Font("Agency FB", 1, 22)); // NOI18N
        kilosLbl.setText("0.00 KG");

        agregar.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N
        agregar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/Print-48.png"))); // NOI18N
        agregar.setText("Imprimir");
        agregar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                agregarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(179, 179, 179)
                        .addComponent(agregar)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 139, Short.MAX_VALUE))
                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(jPanel1Layout.createSequentialGroup()
                            .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                .addComponent(basculaPanel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(codigoBarrasPanel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                            .addGap(0, 0, Short.MAX_VALUE))
                        .addGroup(jPanel1Layout.createSequentialGroup()
                            .addComponent(jLabel1)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                            .addComponent(productoLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 243, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                            .addComponent(kilosLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addComponent(codigoBarrasPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(basculaPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(kilosLbl)
                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                        .addComponent(jLabel1, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(productoLabel, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(agregar, javax.swing.GroupLayout.PREFERRED_SIZE, 61, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(85, Short.MAX_VALUE))
        );

        jSplitPane1.setLeftComponent(jPanel1);

        jPanel2.setLayout(new javax.swing.BoxLayout(jPanel2, javax.swing.BoxLayout.LINE_AXIS));

        tablaProductos.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {

            }
        ));
        jScrollPane1.setViewportView(tablaProductos);

        jPanel2.add(jScrollPane1);

        jSplitPane1.setRightComponent(jPanel2);

        add(jSplitPane1);
    }// </editor-fold>//GEN-END:initComponents

    private void agregarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_agregarActionPerformed
        try {
            segregarProducto();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(this, ex, "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }//GEN-LAST:event_agregarActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton agregar;
    private javax.swing.JPanel basculaPanel;
    private javax.swing.JPanel codigoBarrasPanel;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JLabel kilosLbl;
    private javax.swing.JLabel productoLabel;
    private javax.swing.JTable tablaProductos;
    // End of variables declaration//GEN-END:variables
}
