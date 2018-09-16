/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package panels;

import components.BasculaPanel;
import components.CustomCellRendered;
import components.CustomDropDown;
import components.ProductosTableModel;
import dao.ProductoDAO;
import dao.ProductosDAO;
import dao.ProductosHasProveedoresDao;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableModel;
import mapping.OrdenesCompra;
import mapping.Procesos;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import utilities.UsuarioFirmado;

/**
 *
 * @author Karla
 */
public class ReciboDeProductoSinBC extends javax.swing.JPanel {

    private BasculaPanel bascula;
    private CustomDropDown productosDropDown;
    private CustomDropDown proveedoresDropdown;
    private ProductosTableModel model ;
    private CustomCellRendered cellRendered;
    private ProductoDAO productosDao;
    private ProductosHasProveedoresDao pHasPro = new ProductosHasProveedoresDao();
    
    /**
     * Creates new form ReciboDeProductoSinBC
     */
    public ReciboDeProductoSinBC() {
    }
    
    public void init(){
        initComponents();
        panelIzquierdo.add(proveedoresDropdown);
        proveedoresDropdown.setBounds(10, 90, 400, 70);
        panelIzquierdo.add(productosDropDown);
        productosDropDown.setBounds(10, 170, 400, 70);
        panelIzquierdo.add(bascula);
        bascula.setBounds(30, 260, 400, 400);
        tablaProductos.setDefaultRenderer(Object.class, (TableCellRenderer) cellRendered);
        tablaProductos.setModel((TableModel) model);
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
        panelDerecho = new javax.swing.JPanel();
        scrollPanel = new javax.swing.JScrollPane();
        tablaProductos = new javax.swing.JTable();
        panelIzquierdo = new javax.swing.JPanel();
        btnAgregar = new javax.swing.JButton();
        btnFinalizar = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        consecutivoLbl = new javax.swing.JLabel();
        eliminarCajaBtn = new javax.swing.JButton();

        setPreferredSize(new java.awt.Dimension(1558, 767));
        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane1.setDividerLocation(500);
        jSplitPane1.setPreferredSize(new java.awt.Dimension(1136, 739));

        panelDerecho.setLayout(new javax.swing.BoxLayout(panelDerecho, javax.swing.BoxLayout.LINE_AXIS));

        tablaProductos.setModel((TableModel)model);
        scrollPanel.setViewportView(tablaProductos);

        panelDerecho.add(scrollPanel);

        jSplitPane1.setRightComponent(panelDerecho);

        btnAgregar.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        btnAgregar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/add.png"))); // NOI18N
        btnAgregar.setText("Agregar");
        btnAgregar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnAgregarActionPerformed(evt);
            }
        });

        btnFinalizar.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        btnFinalizar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/finalizar.png"))); // NOI18N
        btnFinalizar.setText("<html><center>Terminar<html>");
        btnFinalizar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnFinalizarActionPerformed(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N
        jLabel1.setText("Total de cajas:");

        consecutivoLbl.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N
        consecutivoLbl.setText("0");

        eliminarCajaBtn.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        eliminarCajaBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/button_cancel-48.png"))); // NOI18N
        eliminarCajaBtn.setText("<html><center>Eliminar<br>Caja<html>");
        eliminarCajaBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                eliminarCajaBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout panelIzquierdoLayout = new javax.swing.GroupLayout(panelIzquierdo);
        panelIzquierdo.setLayout(panelIzquierdoLayout);
        panelIzquierdoLayout.setHorizontalGroup(
            panelIzquierdoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, panelIzquierdoLayout.createSequentialGroup()
                .addContainerGap(192, Short.MAX_VALUE)
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(consecutivoLbl)
                .addGap(111, 111, 111))
            .addGroup(panelIzquierdoLayout.createSequentialGroup()
                .addGroup(panelIzquierdoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(panelIzquierdoLayout.createSequentialGroup()
                        .addGap(40, 40, 40)
                        .addComponent(btnAgregar, javax.swing.GroupLayout.PREFERRED_SIZE, 170, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(59, 59, 59)
                        .addComponent(eliminarCajaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 185, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(panelIzquierdoLayout.createSequentialGroup()
                        .addGap(142, 142, 142)
                        .addComponent(btnFinalizar, javax.swing.GroupLayout.PREFERRED_SIZE, 182, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        panelIzquierdoLayout.setVerticalGroup(
            panelIzquierdoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, panelIzquierdoLayout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addGroup(panelIzquierdoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(consecutivoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 504, Short.MAX_VALUE)
                .addGroup(panelIzquierdoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(btnAgregar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(eliminarCajaBtn))
                .addGap(31, 31, 31)
                .addComponent(btnFinalizar, javax.swing.GroupLayout.PREFERRED_SIZE, 63, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(40, 40, 40))
        );

        jSplitPane1.setLeftComponent(panelIzquierdo);

        add(jSplitPane1);
    }// </editor-fold>//GEN-END:initComponents

    private void btnAgregarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnAgregarActionPerformed
        ProductosInventario productoInventario = new ProductosInventario();
        Proveedores proveedor = (Proveedores) proveedoresDropdown.getSelectedItem();
        Productos producto = (Productos) productosDropDown.getSelectedItem();
        ProductosHasProveedores productoHasProveedor = null;
        try {
            productoHasProveedor = productosDao.getProductosXProveedorYProducto(proveedor, producto.getCodigo());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        if(productoHasProveedor == null){
            productoHasProveedor = new ProductosHasProveedores();
            productoHasProveedor.setProveedores(proveedor);
            productoHasProveedor.setProductos(producto);
            productoHasProveedor.setPrecioSugerido(producto.getPrecioSugerido());
            productoHasProveedor.setCodigoProveedor(producto.getCodigo().toString());
            try {
                pHasPro.insertarProductosHasProveedores(productoHasProveedor);
            } catch (Exception ex1) {
                JOptionPane.showMessageDialog(null, ex1);
            }
        }
        productoInventario.setProductosHasProveedores(productoHasProveedor);
        productoInventario.setUbicaciones(UsuarioFirmado.getUsuarioFirmado().getUbicaciones());
        productoInventario.setPeso(bascula.getPeso());
        productoInventario.setPrecio(producto.getPrecioSugerido());
        productoInventario.setCosto(producto.getPrecioSugerido());
        productoInventario.setEstatus("ACTIVO");
        productoInventario.setConsecutivoProceso(new Integer(consecutivoLbl.getText()));
        productoInventario.setCodigoBarras(getCodigoBarras());
        productoInventario.setFechaCreacion(new Date());
        model.agregarProducto(productoInventario);
        this.imprimirCodigo(productoInventario);
        consecutivoLbl.setText(String.valueOf(tablaProductos.getRowCount()));
        if(bascula.getPesoManualChk().isSelected()){
            bascula.getPesoManualTxt().requestFocus();
        }
    }//GEN-LAST:event_btnAgregarActionPerformed

    private void btnFinalizarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnFinalizarActionPerformed
        OrdenesCompra orden = new OrdenesCompra();
        orden.setEstatus("ACTIVO");
        orden.setFecha(new Date());
        orden.setProveedores((Proveedores) proveedoresDropdown.getSelectedItem());
        BigDecimal total = BigDecimal.ZERO;
        for (ProductosInventario producto : model.getProductos()) {
            total = total.add(producto.getCosto().multiply(producto.getPeso()));
        }
        orden.setTotal(total);
        try {
            orden.setUsuarios(UsuarioFirmado.getUsuarioFirmado());
        } catch (Exception ex) {
            Logger.getLogger(ReciboDeProducto.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            productosDao.recibirProductos(new ArrayList(model.getProductos()), orden);
            JOptionPane.showMessageDialog(null, "Se recibieron los canales correctamente");
            model.limpiar();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Ocurrió un error al recibir los canales");
        }
        consecutivoLbl.setText(String.valueOf(tablaProductos.getRowCount()));
    }//GEN-LAST:event_btnFinalizarActionPerformed

    private void eliminarCajaBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_eliminarCajaBtnActionPerformed
        int[] selectedRows = tablaProductos.getSelectedRows();
        model.eliminarProductos(selectedRows);
        consecutivoLbl.setText(String.valueOf(tablaProductos.getRowCount()));
    }//GEN-LAST:event_eliminarCajaBtnActionPerformed

    private String getCodigoBarras() {
        return "N1"
                + new SimpleDateFormat("yyyyMMdd").format(new Date())
                + String.format("%05d", ((Productos) this.productosDropDown.getSelectedItem()).getCodigo())
                + String.format("%06d", Integer.parseInt(bascula.getPeso().toString().replaceAll("\\.", "")))
                + String.format("%04d", Integer.parseInt(consecutivoLbl.getText()));
    }
    
    private void imprimirCodigo(ProductosInventario producto) {
        // aca obtenemos la printer default  

        String label = "";
        try (BufferedReader br = new BufferedReader(new FileReader("C:\\valco_installation\\conf\\CodigoBarras.txt"))){
            StringBuilder sb = new StringBuilder();
            String line = br.readLine();

            while (line != null) {
                sb.append(line);
                sb.append(System.lineSeparator());
                line = br.readLine();
            }
            label = sb.toString();
            br.close();
        } catch (IOException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        } 
        PrintService printService = PrintServiceLookup.lookupDefaultPrintService();
        label = label.replace("PRODUCTO", this.productosDropDown.getSelectedItem().toString());
        label = label.replace("PESO", producto.getPeso().toString());
        label = label.replace("CODIGO_BARRAS", producto.getCodigoBarras());
        
       /* String zplCommand = "^XA"
                + "^FO230,50^ARN,16,9^FD " + this.productosLov.getSelectedItem() + "^FS"
                + "^FO300,100^ARN,16,9^FD " + producto.getPeso() + " KG^BY1,3.0^FS"
                + "^FO230,180^BCN, 80, Y, N, N^FD" + producto.getCodigoBarras() + "^FS "
                + "^XZ";
        
        
               
        */
        

// convertimos el comando a bytes  
        byte[] by = label.getBytes();
        DocFlavor flavor = DocFlavor.BYTE_ARRAY.AUTOSENSE;
        Doc doc = new SimpleDoc(by, flavor, null);

// creamos el printjob  
        DocPrintJob job = printService.createPrintJob();

        try {
            // imprimimos
            job.print(doc, null);
        } catch (PrintException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    public BasculaPanel getBascula() {
        return bascula;
    }

    public void setBascula(BasculaPanel bascula) {
        this.bascula = bascula;
    }

    public CustomDropDown getProductosDropDown() {
        return productosDropDown;
    }

    public void setProductosDropDown(CustomDropDown productosDropDown) {
        this.productosDropDown = productosDropDown;
    }

    public CustomDropDown getProveedoresDropdown() {
        return proveedoresDropdown;
    }

    public void setProveedoresDropdown(CustomDropDown proveedoresDropdown) {
        this.proveedoresDropdown = proveedoresDropdown;
    }

    public ProductosTableModel getModel() {
        return model;
    }

    public void setModel(ProductosTableModel model) {
        this.model = model;
    }

    public CustomCellRendered getCellRendered() {
        return cellRendered;
    }

    public void setCellRendered(CustomCellRendered cellRendered) {
        this.cellRendered = cellRendered;
    }

    public ProductoDAO getProductosDao() {
        return productosDao;
    }

    public void setProductosDao(ProductoDAO productosDao) {
        this.productosDao = productosDao;
    }

    
    
    
    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnAgregar;
    private javax.swing.JButton btnFinalizar;
    private javax.swing.JLabel consecutivoLbl;
    private javax.swing.JButton eliminarCajaBtn;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JPanel panelDerecho;
    private javax.swing.JPanel panelIzquierdo;
    private javax.swing.JScrollPane scrollPanel;
    private javax.swing.JTable tablaProductos;
    // End of variables declaration//GEN-END:variables
}
