/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package panels;

import barcode.BarCodableImpl;
import dao.ProductoDAO;
import dao.ProveedorDAO;
import dao.UbicacionesDAO;
import dao.UsuariosDAO;
import java.awt.Component;
import java.awt.KeyboardFocusManager;
import java.awt.event.KeyEvent;
import java.math.BigDecimal;
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
import javax.swing.plaf.basic.BasicOptionPaneUI;
import javax.swing.table.DefaultTableModel;
import keydispatchers.BarCodeScannerKeyDispatcher;
import mapping.OrdenesCompra;
import mapping.Procesos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import table.custom.NoEditableTableModel;
import utilities.UsuarioFirmado;

/**
 *
 * @author Administrador
 */
public class ReciboProductoBC extends BarCodableImpl {

    private UsuariosDAO usuariosDao = new UsuariosDAO();
    ProductoDAO productoDAO = new ProductoDAO();
    ProveedorDAO proveedorDAO = new ProveedorDAO();
    UbicacionesDAO ubicacionesDAO = new UbicacionesDAO();
    DefaultTableModel model = new NoEditableTableModel();
    List<ProductosInventario> nuevosProductos = new ArrayList<ProductosInventario>();
    public List<Component> exceptions = new ArrayList<>();
    Object[] ultimoProducto = null;
    ProductosInventario ultimoProductoInventario = null;
    JOptionPane dialog = new JOptionPane();

    /**
     * Creates new form ReciboProducto
     */
    public ReciboProductoBC() {
        initComponents();
        setManager(KeyboardFocusManager.getCurrentKeyboardFocusManager());
        exceptions.add(proveedorTxt);
        exceptions.add(numeroCajasTxt);
        setDispacher(new BarCodeScannerKeyDispatcher(codigoBarrasTxt, getManager(), exceptions) {
            @Override
            public boolean dispatchKeyEvent(KeyEvent e) {

                if(e.getKeyCode() == KeyEvent.VK_F5){
                    cajasDialog.show();
                }
                for (Component exception : exceptions) {
                    if (exception.equals(e.getSource())) {
                        getManager().redispatchEvent(exception, e);
                        return true;
                    }
                }
                getManager().redispatchEvent(codigoBarrasTxt, e);
                return true;
            }
        });
        getManager().addKeyEventDispatcher(getDispacher());
    }
    
    public void multiplicarUltimaCaja(){
        if(ultimoProductoInventario == null){
            JOptionPane.showMessageDialog(null, "No ha ingresado ningun producto");
        }
        String texto = numeroCajasTxt.getText();
        int cajas = 0;
        try{
            cajas = Integer.parseInt(texto);
        }catch (Exception e){
            JOptionPane.showMessageDialog(null, "Ingrese un número entero.");
            return;
        }
        for(int x = 1; x < cajas; x++){
            
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
        jSplitPane1 = new javax.swing.JSplitPane();
        jPanel1 = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        proveedorTxt = new javax.swing.JTextField();
        proveedorLOV = new javax.swing.JComboBox();
        jLabel1 = new javax.swing.JLabel();
        codigoBarrasTxt = new javax.swing.JTextField();
        jPanel2 = new javax.swing.JPanel();
        jSplitPane2 = new javax.swing.JSplitPane();
        jPanel3 = new javax.swing.JPanel();
        agregarBtn = new javax.swing.JButton();
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

        setPreferredSize(new java.awt.Dimension(1558, 755));
        setRequestFocusEnabled(false);
        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane1.setDividerLocation(300);
        jSplitPane1.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);

        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder("Proveedor y codigo de barras"));

        jLabel4.setText("Proveedor:");

        proveedorTxt.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                proveedorTxtActionPerformed(evt);
            }
        });
        proveedorTxt.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                proveedorTxtKeyReleased(evt);
            }
            public void keyTyped(java.awt.event.KeyEvent evt) {
                proveedorTxtKeyTyped(evt);
            }
        });

        proveedorLOV.setModel(new DefaultComboBoxModel(getProveedoresArray()));
        proveedorLOV.setSelectedItem(proveedorLOV.getSelectedItem());
        proveedorLOV.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                proveedorLOVActionPerformed(evt);
            }
        });

        jLabel1.setText("Código de barras:");

        codigoBarrasTxt.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                codigoBarrasTxtActionPerformed(evt);
            }
        });
        codigoBarrasTxt.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                codigoBarrasTxtKeyPressed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel4)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(proveedorLOV, javax.swing.GroupLayout.PREFERRED_SIZE, 135, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(proveedorTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 135, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(70, 70, 70)
                        .addComponent(jLabel1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(codigoBarrasTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 253, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(728, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(34, 34, 34)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel4)
                    .addComponent(proveedorTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel1)
                    .addComponent(codigoBarrasTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(proveedorLOV, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(196, Short.MAX_VALUE))
        );

        jSplitPane1.setTopComponent(jPanel1);

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder("Productos a ingresar"));
        jPanel2.setLayout(new javax.swing.BoxLayout(jPanel2, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane2.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);

        agregarBtn.setText("Agregar");
        agregarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                agregarBtnActionPerformed(evt);
            }
        });
        jPanel3.add(agregarBtn);

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

    private void agregarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_agregarBtnActionPerformed
        try {
            agregarProducto();
            codigoBarrasTxt.setText("");
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage());
        }
    }//GEN-LAST:event_agregarBtnActionPerformed

    private void limpiarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_limpiarBtnActionPerformed
        model.setRowCount(0);
    }//GEN-LAST:event_limpiarBtnActionPerformed

    private void finalizarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_finalizarBtnActionPerformed
        OrdenesCompra orden = new OrdenesCompra();
        orden.setEstatus("ACTIVO");
        orden.setFecha(new Date());
        orden.setProveedores((Proveedores) proveedorLOV.getSelectedItem());
        BigDecimal total = BigDecimal.ZERO;
        for (ProductosInventario producto : nuevosProductos) {
            total = total.add(producto.getCosto().multiply(producto.getPeso()));
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

    private void proveedorTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_proveedorTxtActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_proveedorTxtActionPerformed

    private void proveedorTxtKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_proveedorTxtKeyReleased
        try {

            if (!proveedorTxt.getText().equals("")) {
                Proveedores proveedor = proveedorDAO.getProveedoresXCodigo(proveedorTxt.getText());
                if (proveedor != null) {
                    proveedorLOV.setSelectedItem(proveedor);
                    proveedorLOV.repaint();
                }
            }

        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurriò un error al consultar el proveedor", "Error", ERROR_MESSAGE);
        }
    }//GEN-LAST:event_proveedorTxtKeyReleased

    private void proveedorTxtKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_proveedorTxtKeyTyped

    }//GEN-LAST:event_proveedorTxtKeyTyped

    private void proveedorLOVActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_proveedorLOVActionPerformed


    }//GEN-LAST:event_proveedorLOVActionPerformed

    private void codigoBarrasTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_codigoBarrasTxtActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_codigoBarrasTxtActionPerformed

    private void codigoBarrasTxtKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_codigoBarrasTxtKeyPressed
        if (evt.getKeyChar() == KeyEvent.VK_ENTER) {
            try {
                agregarProducto();
                codigoBarrasTxt.setText("");
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex.getMessage());
            }
        }
    }//GEN-LAST:event_codigoBarrasTxtKeyPressed

    private void recibirNumCajasBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_recibirNumCajasBtnActionPerformed
        multiplicarUltimaCaja();
    }//GEN-LAST:event_recibirNumCajasBtnActionPerformed

    private void eliminarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_eliminarBtnActionPerformed
        String barCode = (String) model.getValueAt(tablaCanales.getSelectedRow(), 4);
        model.removeRow(tablaCanales.getSelectedRow());
        for(ProductosInventario producto : nuevosProductos){
            if(producto.getCodigoBarras().equals(barCode)){
                try{
                nuevosProductos.remove(producto);
                }catch(Exception e){
                    JOptionPane.showMessageDialog(null, e.getMessage());
                }
                return;
            }
        }
    }//GEN-LAST:event_eliminarBtnActionPerformed

    private void numeroCajasTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_numeroCajasTxtActionPerformed
       multiplicarUltimaCaja();
       numeroCajasTxt.setText("");
       cajasDialog.dispose();
    }//GEN-LAST:event_numeroCajasTxtActionPerformed

    private Object[] getProveedoresArray() {
        Object[] proveedores = null;
        try {
            proveedores = proveedorDAO.getProveedores().toArray();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurriò un error al consultar los proveedores", "Error", ERROR_MESSAGE);
            return null;
        }
        return proveedores;
    }

    public void agregarProducto() throws Exception {
        int barCodeSize = 0;
        
        if(codigoBarrasTxt.getText().length() < getProveedorSeleccionado().getPosicionCodigoFinal()){
            return;
        }

        ProductosHasProveedores productoHasProveedores = null;
        barCodeSize= codigoBarrasTxt.getText().length();
        if(barCodeSize< getProveedorSeleccionado().getPosicionCodigoInicial() || 
                barCodeSize< getProveedorSeleccionado().getPosicionCodigoFinal() ||
                barCodeSize < getProveedorSeleccionado().getPosicionPesoInicial() ||
                barCodeSize< getProveedorSeleccionado().getPosicionPesoFinal()){
            return;
        }

        String codigoProducto
                = codigoBarrasTxt.getText().substring(getProveedorSeleccionado().getPosicionCodigoInicial(),
                        getProveedorSeleccionado().getPosicionCodigoFinal());
        String peso
                = codigoBarrasTxt.getText().substring(getProveedorSeleccionado().getPosicionPesoInicial(),
                        getProveedorSeleccionado().getPosicionPesoFinal());
        peso= new StringBuilder(peso).insert(peso.length()-2, ".").toString();
        try {
            productoHasProveedores
                    = productoDAO.getProductoXProveYCodigo(getProveedorSeleccionado(), codigoProducto);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurrió un error al consultar el producto.");
        }

        if (productoHasProveedores == null) {
            JOptionPane.showMessageDialog(null, "No se encontro un producto con el código especificado");
        } else {
            ProductosInventario productoNuevo = new ProductosInventario();
            productoNuevo.setPeso(new BigDecimal(peso));
            productoNuevo.setCodigoBarras(codigoBarrasTxt.getText());
            productoNuevo.setProductosHasProveedores(productoHasProveedores);
            productoNuevo.setCosto(productoHasProveedores.getPrecioSugerido());
            productoNuevo.setPrecio(productoHasProveedores.getProductos().getPrecioSugerido());
            productoNuevo.setUbicaciones(UsuarioFirmado.getUsuarioFirmado().getUbicaciones());
            productoNuevo.setEstatus("ACTIVO");
            ultimoProductoInventario = productoNuevo;
            nuevosProductos.add(productoNuevo);

            Object[] canal = new Object[5];

            canal[0] = peso;
            canal[1] = proveedorLOV.getSelectedItem().toString();
            canal[2] = productoHasProveedores.getProductos().getDescripcion();
            canal[3] = UsuarioFirmado.getUsuarioFirmado().getUbicaciones();
            canal[4] = codigoBarrasTxt.getText();
            ultimoProducto = canal;
            
            model.addRow(canal);
        }
    }

    private Proveedores getProveedorSeleccionado() {
        return (Proveedores) proveedorLOV.getSelectedItem();
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton agregarBtn;
    private javax.swing.JDialog cajasDialog;
    private javax.swing.JTextField codigoBarrasTxt;
    private javax.swing.JButton eliminarBtn;
    private javax.swing.JButton finalizarBtn;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JSplitPane jSplitPane2;
    private javax.swing.JButton limpiarBtn;
    private javax.swing.JTextField numeroCajasTxt;
    private javax.swing.JComboBox proveedorLOV;
    private javax.swing.JTextField proveedorTxt;
    private javax.swing.JButton recibirNumCajasBtn;
    private javax.swing.JTable tablaCanales;
    // End of variables declaration//GEN-END:variables
}
