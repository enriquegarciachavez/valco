/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package panels;

import barcode.BarCodableImpl;
import components.BarCodeArea;
import components.BarCodeTxt;
import components.CustomDropDown;
import dao.ProductoDAO;
import dao.ProductosHasProveedoresDao;
import dao.ProveedorDAO;
import dao.ProveedoresDAO;
import dao.ProveedoresKiloDAO;
import dao.UbicacionesDAO;
import dao.UsuariosDAO;
import java.awt.Component;
import java.awt.KeyboardFocusManager;
import java.awt.event.KeyEvent;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.plaf.basic.BasicOptionPaneUI;
import javax.swing.table.DefaultTableModel;
import keydispatchers.BarCodeScannerKeyDispatcher;
import mapping.OrdenesCompra;
import mapping.Procesos;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import mapping.ProveedoresCodigo;
import observables.BarCodeTxtObservable;
import observables.Observable;
import observers.BarCodeAreaObserver;
import observers.BarCodeTxtObserver;
import observers.Observer;
import org.apache.commons.lang.math.NumberUtils;
import table.custom.ColumnEditableTableModel;
import table.custom.NoEditableTableModel;
import utilities.UsuarioFirmado;

/**
 *
 * @author Administrador
 */
public class ReciboProductoBC extends BarCodableImpl implements BarCodeAreaObserver,
        Observer{

    private UsuariosDAO usuariosDao = new UsuariosDAO();
    ProductoDAO productoDAO = new ProductoDAO();
    ProductosHasProveedoresDao prodHasProvDao = new ProductosHasProveedoresDao();
    ProveedoresDAO proveedoresDao = new ProveedoresKiloDAO();
    UbicacionesDAO ubicacionesDAO = new UbicacionesDAO();
    DefaultTableModel model = new ColumnEditableTableModel();
    List<ProductosInventario> nuevosProductos = new ArrayList<ProductosInventario>();
    Object[] ultimoProducto = null;
    ProductosInventario ultimoProductoInventario = null;
    JOptionPane dialog = new JOptionPane();
    private CustomDropDown proveedoresDropDown = new CustomDropDown();
    private CustomDropDown productosDropDown = new CustomDropDown();
    private BarCodeArea barCodeArea = new BarCodeArea();
    private int row = 0;
    private String pesoAnterior;

    /**
     * Creates new form ReciboProducto
     */
    public ReciboProductoBC() {
        initComponents();
        proveedoresDropDown.setDao(proveedoresDao);
        proveedoresDropDown.setEtiqueta("Proveedor");
        proveedoresDropDown.init();
        proveedoresDropDown.registerObserver(this);
        panelBusqueda.add(proveedoresDropDown);
        proveedoresDropDown.setBounds(50, 50, 500, 65);
        productosDropDown.setDao(productoDAO);
        productosDropDown.setEtiqueta("Producto");
        productosDropDown.init();
        capturarProductoDialog.add(productosDropDown);
        productosDropDown.setBounds(50, 150, 500, 65);
        barCodeArea.init();
        panelBusqueda.add(barCodeArea);
        barCodeArea.setModoOperacion("ENTRADA");
        barCodeArea.setProveedoresDropDown(proveedoresDropDown);
        barCodeArea.setBounds(600, 20, 700, 200);
        barCodeArea.registerObserver(this);
        eliminarBtn.setFocusTraversalKeysEnabled(false);
        List<Integer> columnasEditables = new ArrayList<>();
        columnasEditables.add(0);
        columnasEditables.add(2);
        ((ColumnEditableTableModel) model).setColumns(columnasEditables);
        model.addTableModelListener(new TableModelListener() {

            @Override
            public void tableChanged(TableModelEvent e) {
                if (tablaCanales.isEditing() && tablaCanales.getSelectedRow() < tablaCanales.getRowCount()-1
                        && !model.getValueAt(tablaCanales.getSelectedRow(), tablaCanales.getSelectedColumn()).equals("")) {
                    tablaCanales.changeSelection(tablaCanales.getSelectedRow()+1, 0, false, false);
                    //model.setValueAt("", tablaCanales.getSelectedRow(), tablaCanales.getSelectedColumn());
                }
            }
        });
    }

    public void multiplicarUltimaCaja() {
        if (ultimoProductoInventario == null) {
            JOptionPane.showMessageDialog(null, "No ha ingresado ningun producto");
        }
        String texto = numeroCajasTxt.getText();
        int cajas = 0;
        try {
            cajas = Integer.parseInt(texto);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Ingrese un número entero.");
            return;
        }
        for (int x = 1; x < cajas; x++) {

            ProductosInventario productoNuevo = new ProductosInventario();
            productoNuevo.setPeso(ultimoProductoInventario.getPeso());
            productoNuevo.setCodigoBarras(ultimoProductoInventario.getCodigoBarras());
            productoNuevo.setProductosHasProveedores(ultimoProductoInventario.getProductosHasProveedores());
            productoNuevo.setPrecio(ultimoProductoInventario.getPrecio());
            productoNuevo.setUbicaciones(ultimoProductoInventario.getUbicaciones());
            productoNuevo.setEstatus(ultimoProductoInventario.getEstatus());
            nuevosProductos.add(productoNuevo);

            Object[] producto = new Object[5];
            producto[0] = ultimoProducto[0];
            producto[1] = ultimoProducto[1];
            producto[2] = ultimoProducto[2];
            producto[3] = ultimoProducto[3];
            producto[4] = ultimoProducto[4];
            model.addRow(producto);
        }
    }
    
        @Override
    public void updateBarCodeAreaObserver() {
        for (ProductosInventario producto : barCodeArea.getProductosInventario()) {
            nuevosProductos.add(producto);

            Object[] canal = new Object[5];

            canal[0] = producto.getPeso().toString();
            canal[1] = proveedoresDropDown.getSelectedItem().toString();
            canal[2] = producto.getProductosHasProveedores().getProductos().getDescripcion();
            canal[3] = UsuarioFirmado.getUsuarioFirmado().getUbicaciones();
            canal[4] = producto.getCodigoBarras();

            model.addRow(canal);
        }
        barCodeArea.getProductosInventario().clear();

    }
    
    @Override
    public void Update(Observable observable) {
        if(observable.equals(proveedoresDropDown)){
            pesoCheckBox.setSelected(false);
            productoCheckBox.setSelected(false);
            for(ProveedoresCodigo codigo : ((Proveedores)(proveedoresDropDown.getSelectedItem())).getProveedoresCodigos()){
                if(codigo.getPosicionCodigoFinal() > 0){
                    productoCheckBox.setSelected(true);
                }
                if(codigo.getPosicionPesoFinal() > 0){
                    pesoCheckBox.setSelected(true);
                }
                puntoDecimalCheckBox.setSelected(codigo.getPuntoDecimal());
                librasCheckBox.setSelected(codigo.getPesoEnLibras());
            }
        }
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        cajasDialog = new javax.swing.JDialog();
        numeroCajasTxt = new javax.swing.JTextField();
        recibirNumCajasBtn = new javax.swing.JButton();
        capturarProductoDialog = new javax.swing.JDialog();
        barCodeLabel = new javax.swing.JLabel();
        pesoLbl = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();
        siguienteBtn = new javax.swing.JButton();
        jLabel3 = new javax.swing.JLabel();
        productoLbl = new javax.swing.JLabel();
        jSplitPane1 = new javax.swing.JSplitPane();
        panelBusqueda = new javax.swing.JPanel();
        productoCheckBox = new javax.swing.JCheckBox();
        pesoCheckBox = new javax.swing.JCheckBox();
        puntoDecimalCheckBox = new javax.swing.JCheckBox();
        librasCheckBox = new javax.swing.JCheckBox();
        pendientesButton = new javax.swing.JButton();
        jPanel2 = new javax.swing.JPanel();
        jSplitPane2 = new javax.swing.JSplitPane();
        jPanel3 = new javax.swing.JPanel();
        limpiarBtn = new javax.swing.JButton();
        finalizarBtn = new javax.swing.JButton();
        eliminarBtn = new javax.swing.JButton();
        jPanel5 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        tablaCanales = new javax.swing.JTable();

        cajasDialog.setBounds(new java.awt.Rectangle(200, 200, 300, 300));
        cajasDialog.setModal(true);

        numeroCajasTxt.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                numeroCajasTxtActionPerformed(evt);
            }
        });

        recibirNumCajasBtn.setText("Recibir cajas");
        recibirNumCajasBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                recibirNumCajasBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout cajasDialogLayout = new javax.swing.GroupLayout(cajasDialog.getContentPane());
        cajasDialog.getContentPane().setLayout(cajasDialogLayout);
        cajasDialogLayout.setHorizontalGroup(
            cajasDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(cajasDialogLayout.createSequentialGroup()
                .addGap(123, 123, 123)
                .addGroup(cajasDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(recibirNumCajasBtn)
                    .addComponent(numeroCajasTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 106, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(171, Short.MAX_VALUE))
        );
        cajasDialogLayout.setVerticalGroup(
            cajasDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(cajasDialogLayout.createSequentialGroup()
                .addGap(106, 106, 106)
                .addComponent(numeroCajasTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(47, 47, 47)
                .addComponent(recibirNumCajasBtn)
                .addContainerGap(104, Short.MAX_VALUE))
        );

        capturarProductoDialog.setMinimumSize(new java.awt.Dimension(600, 300));

        barCodeLabel.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        barCodeLabel.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        barCodeLabel.setText("Codigo de barras");
        barCodeLabel.setToolTipText("");

        pesoLbl.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        pesoLbl.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        pesoLbl.setText("Peso");

        jLabel1.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel1.setText("KG");

        siguienteBtn.setText("Siguiente Caja");
        siguienteBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                siguienteBtnActionPerformed(evt);
            }
        });

        jLabel3.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel3.setText("Producto actual:");

        productoLbl.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        productoLbl.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        productoLbl.setText("Producto");

        javax.swing.GroupLayout capturarProductoDialogLayout = new javax.swing.GroupLayout(capturarProductoDialog.getContentPane());
        capturarProductoDialog.getContentPane().setLayout(capturarProductoDialogLayout);
        capturarProductoDialogLayout.setHorizontalGroup(
            capturarProductoDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(capturarProductoDialogLayout.createSequentialGroup()
                .addGap(23, 23, 23)
                .addGroup(capturarProductoDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(capturarProductoDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(barCodeLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 346, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, capturarProductoDialogLayout.createSequentialGroup()
                            .addComponent(pesoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 158, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                            .addComponent(jLabel1)))
                    .addGroup(capturarProductoDialogLayout.createSequentialGroup()
                        .addComponent(jLabel3)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(capturarProductoDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(siguienteBtn)
                            .addComponent(productoLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
                .addContainerGap(31, Short.MAX_VALUE))
        );
        capturarProductoDialogLayout.setVerticalGroup(
            capturarProductoDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(capturarProductoDialogLayout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addComponent(barCodeLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(capturarProductoDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(pesoLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addGroup(capturarProductoDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jLabel3, javax.swing.GroupLayout.DEFAULT_SIZE, 26, Short.MAX_VALUE)
                    .addComponent(productoLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(89, 89, 89)
                .addComponent(siguienteBtn)
                .addGap(48, 48, 48))
        );

        setPreferredSize(new java.awt.Dimension(1558, 755));
        setRequestFocusEnabled(false);
        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane1.setDividerLocation(300);
        jSplitPane1.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);

        panelBusqueda.setBorder(javax.swing.BorderFactory.createTitledBorder("Proveedor y codigo de barras"));
        panelBusqueda.addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentResized(java.awt.event.ComponentEvent evt) {
                panelBusquedaComponentResized(evt);
            }
        });

        productoCheckBox.setText("El codigo de barras contiene el producto");
        productoCheckBox.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                productoCheckBoxItemStateChanged(evt);
            }
        });

        pesoCheckBox.setText("El codigo de barras contiene el peso");
        pesoCheckBox.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                pesoCheckBoxItemStateChanged(evt);
            }
        });

        puntoDecimalCheckBox.setText("El codigo de barras incluye punto decimal");
        puntoDecimalCheckBox.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                puntoDecimalCheckBoxItemStateChanged(evt);
            }
        });

        librasCheckBox.setText("El peso esta en libras");
        librasCheckBox.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                librasCheckBoxItemStateChanged(evt);
            }
        });

        pendientesButton.setText("Capturar productos pendientes");
        pendientesButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                pendientesButtonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout panelBusquedaLayout = new javax.swing.GroupLayout(panelBusqueda);
        panelBusqueda.setLayout(panelBusquedaLayout);
        panelBusquedaLayout.setHorizontalGroup(
            panelBusquedaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(panelBusquedaLayout.createSequentialGroup()
                .addGap(69, 69, 69)
                .addGroup(panelBusquedaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(productoCheckBox, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(pesoCheckBox, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(puntoDecimalCheckBox, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(librasCheckBox, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(228, 228, 228)
                .addComponent(pendientesButton)
                .addContainerGap(649, Short.MAX_VALUE))
        );
        panelBusquedaLayout.setVerticalGroup(
            panelBusquedaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, panelBusquedaLayout.createSequentialGroup()
                .addContainerGap(155, Short.MAX_VALUE)
                .addComponent(productoCheckBox)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(pesoCheckBox)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(puntoDecimalCheckBox)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(panelBusquedaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(librasCheckBox)
                    .addComponent(pendientesButton))
                .addGap(16, 16, 16))
        );

        jSplitPane1.setTopComponent(panelBusqueda);

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder("Productos a ingresar"));
        jPanel2.setLayout(new javax.swing.BoxLayout(jPanel2, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane2.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);

        limpiarBtn.setText("Limpiar");
        limpiarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                limpiarBtnActionPerformed(evt);
            }
        });
        jPanel3.add(limpiarBtn);

        finalizarBtn.setText("Finalizar");
        finalizarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                finalizarBtnActionPerformed(evt);
            }
        });
        jPanel3.add(finalizarBtn);

        eliminarBtn.setText("Eliminar selección");
        eliminarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                eliminarBtnActionPerformed(evt);
            }
        });
        eliminarBtn.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                eliminarBtnKeyPressed(evt);
            }
        });
        jPanel3.add(eliminarBtn);

        jSplitPane2.setLeftComponent(jPanel3);

        jPanel5.setLayout(new javax.swing.BoxLayout(jPanel5, javax.swing.BoxLayout.LINE_AXIS));

        tablaCanales.setModel(model);
        String[] columnNames = {
            "Peso",
            "Proveedor",
            "Producto",
            "Almacen",
            "Codigo Barras"};
        model.setColumnIdentifiers(columnNames); 
        jScrollPane1.setViewportView(tablaCanales);

        jPanel5.add(jScrollPane1);

        jSplitPane2.setRightComponent(jPanel5);

        jPanel2.add(jSplitPane2);

        jSplitPane1.setRightComponent(jPanel2);

        add(jSplitPane1);
    }// </editor-fold>//GEN-END:initComponents

    private void limpiarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_limpiarBtnActionPerformed
        model.setRowCount(0);
    }//GEN-LAST:event_limpiarBtnActionPerformed

    private void finalizarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_finalizarBtnActionPerformed
        OrdenesCompra orden = new OrdenesCompra();
        orden.setEstatus("ACTIVO");
        orden.setFecha(new Date());
        orden.setProveedores((Proveedores) proveedoresDropDown.getSelectedItem());
        BigDecimal total = BigDecimal.ZERO;
        int iterador = 0;
        if(hayProductosPendientes()){
            JOptionPane.showMessageDialog(this, "Tiene productos pendientes de capturar");
            return;
        }
        for (ProductosInventario producto : nuevosProductos) {
            total = total.add(producto.getCosto().multiply(producto.getPeso()));
            producto.setPeso(new BigDecimal((String) model.getValueAt(iterador, 0)));
            iterador++;
        }
        orden.setTotal(total);
        try {
            orden.setUsuarios(usuariosDao.getUsuarios().get(0));
        } catch (Exception ex) {
            Logger.getLogger(ReciboDeProducto.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            productoDAO.recibirProductos(nuevosProductos, orden);
            nuevosProductos.clear();
            JOptionPane.showMessageDialog(null, "Se recibieron los canales correctamente");
            model.setRowCount(0);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Ocurrió un error al recibir los canales");
        }
    }//GEN-LAST:event_finalizarBtnActionPerformed

    public boolean hayProductosPendientes(){
        for(int x = 0; x < tablaCanales.getRowCount(); x++){
            if(model.getValueAt(x, 2).equals("PENDIENTE")){
                return true;
            }
        }
        return false;
    }
    private void eliminarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_eliminarBtnActionPerformed
        String barCode = (String) model.getValueAt(tablaCanales.getSelectedRow(), 4);
        model.removeRow(tablaCanales.getSelectedRow());
        for (ProductosInventario producto : nuevosProductos) {
            if (producto.getCodigoBarras().equals(barCode)) {
                try {
                    nuevosProductos.remove(producto);
                } catch (Exception e) {
                    JOptionPane.showMessageDialog(null, e.getMessage());
                }
                return;
            }
        }
    }//GEN-LAST:event_eliminarBtnActionPerformed

    private void panelBusquedaComponentResized(java.awt.event.ComponentEvent evt) {//GEN-FIRST:event_panelBusquedaComponentResized
        proveedoresDropDown.getTxt().requestFocusInWindow();
    }//GEN-LAST:event_panelBusquedaComponentResized

    private void eliminarBtnKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_eliminarBtnKeyPressed
        if (evt.getKeyCode() == KeyEvent.VK_TAB) {
            System.out.println(evt.getModifiers());
            if (evt.getModifiers() > 0) {
                eliminarBtn.transferFocusBackward();
            } else {
                proveedoresDropDown.getTxt().requestFocusInWindow();
            }
            evt.consume();
        }
    }//GEN-LAST:event_eliminarBtnKeyPressed

    private void productoCheckBoxItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_productoCheckBoxItemStateChanged
        System.out.println("primero "+productoCheckBox.isSelected());
        barCodeArea.setProductoEnCodigo(productoCheckBox.isSelected());
    }//GEN-LAST:event_productoCheckBoxItemStateChanged

    private void pesoCheckBoxItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_pesoCheckBoxItemStateChanged
        barCodeArea.setPesoEnCodigo(pesoCheckBox.isSelected());
    }//GEN-LAST:event_pesoCheckBoxItemStateChanged

    private void puntoDecimalCheckBoxItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_puntoDecimalCheckBoxItemStateChanged
        barCodeArea.setPuntoDecimal(puntoDecimalCheckBox.isSelected());
    }//GEN-LAST:event_puntoDecimalCheckBoxItemStateChanged

    private void librasCheckBoxItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_librasCheckBoxItemStateChanged
        barCodeArea.setPesoEnLibras(librasCheckBox.isSelected());
    }//GEN-LAST:event_librasCheckBoxItemStateChanged

    private void recibirNumCajasBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_recibirNumCajasBtnActionPerformed
        multiplicarUltimaCaja();
    }//GEN-LAST:event_recibirNumCajasBtnActionPerformed

    private void numeroCajasTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_numeroCajasTxtActionPerformed
        multiplicarUltimaCaja();
        numeroCajasTxt.setText("");
        cajasDialog.dispose();
    }//GEN-LAST:event_numeroCajasTxtActionPerformed

    private void pendientesButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_pendientesButtonActionPerformed
        if(tablaCanales.getRowCount()==0){
            JOptionPane.showMessageDialog(this, "No hay cajas seleccionadas");
            return;
        }
        row = tablaCanales.getSelectedRow();
        setPopUpValues();
        tablaCanales.changeSelection(row, 2, false, false);
        siguienteBtn.setText("Siguiente caja");
        capturarProductoDialog.setVisible(true);
    }//GEN-LAST:event_pendientesButtonActionPerformed

    private void setPopUpValues(){
        row = (row == -1 || row == tablaCanales.getRowCount()) ? 0 : row;
        barCodeLabel.setText((String) model.getValueAt(row, 4));
        pesoLbl.setText((model.getValueAt(row, 0)).toString());
        productoLbl.setText((String) model.getValueAt(row, 1));
    }
    private void siguienteBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_siguienteBtnActionPerformed
        ProductosHasProveedores producto = new ProductosHasProveedores();
        if(row == tablaCanales.getRowCount()){
            capturarProductoDialog.setVisible(false);
            tablaCanales.clearSelection();
            return;
        }
        if(row == tablaCanales.getRowCount()-1){
            siguienteBtn.setText("Terminar");
        }
        try {
            producto = productoDAO.getProductosXProveedorYProducto((Proveedores) proveedoresDropDown.getSelectedItem(),
                    ((Productos)productosDropDown.getSelectedItem()).getCodigo());
        } catch (Exception ex) {
            producto = null;
        }
        if(producto == null){
            producto = new ProductosHasProveedores();
            producto.setProveedores((Proveedores) proveedoresDropDown.getSelectedItem());
            producto.setProductos((Productos) productosDropDown.getSelectedItem());
            producto.setCodigoProveedor("");
            try {
                prodHasProvDao.insertarProductosHasProveedores(producto);
            } catch (Exception ex1) {
                System.out.println("Ocurrio un error al guardar el producto");
                return;
            }
        }
        nuevosProductos.get(row).setProductosHasProveedores(producto);
        model.setValueAt(producto.getProductos().getDescripcion(), row, 2);
        row++;
        if(row == tablaCanales.getRowCount()){
            return;
        }
        tablaCanales.changeSelection(row, 2, false, false);
        setPopUpValues();
    }//GEN-LAST:event_siguienteBtnActionPerformed



    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel barCodeLabel;
    private javax.swing.JDialog cajasDialog;
    private javax.swing.JDialog capturarProductoDialog;
    private javax.swing.JButton eliminarBtn;
    private javax.swing.JButton finalizarBtn;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JSplitPane jSplitPane2;
    private javax.swing.JCheckBox librasCheckBox;
    private javax.swing.JButton limpiarBtn;
    private javax.swing.JTextField numeroCajasTxt;
    private javax.swing.JPanel panelBusqueda;
    private javax.swing.JButton pendientesButton;
    private javax.swing.JCheckBox pesoCheckBox;
    private javax.swing.JLabel pesoLbl;
    private javax.swing.JCheckBox productoCheckBox;
    private javax.swing.JLabel productoLbl;
    private javax.swing.JCheckBox puntoDecimalCheckBox;
    private javax.swing.JButton recibirNumCajasBtn;
    private javax.swing.JButton siguienteBtn;
    private javax.swing.JTable tablaCanales;
    // End of variables declaration//GEN-END:variables

}
