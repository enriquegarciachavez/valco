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
import dao.ProveedorDAO;
import dao.ProveedoresDAO;
import dao.ProveedoresKiloDAO;
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
import mapping.ProveedoresCodigo;
import observables.BarCodeTxtObservable;
import observers.BarCodeAreaObserver;
import observers.BarCodeTxtObserver;
import table.custom.NoEditableTableModel;
import utilities.UsuarioFirmado;

/**
 *
 * @author Administrador
 */
public class ReciboProductoBC extends BarCodableImpl implements BarCodeTxtObserver,
        BarCodeAreaObserver {

    private UsuariosDAO usuariosDao = new UsuariosDAO();
    ProductoDAO productoDAO = new ProductoDAO();
    ProveedoresDAO proveedoresDao = new ProveedoresKiloDAO();
    UbicacionesDAO ubicacionesDAO = new UbicacionesDAO();
    DefaultTableModel model = new NoEditableTableModel();
    List<ProductosInventario> nuevosProductos = new ArrayList<ProductosInventario>();
    public List<Component> exceptions = new ArrayList<>();
    Object[] ultimoProducto = null;
    ProductosInventario ultimoProductoInventario = null;
    JOptionPane dialog = new JOptionPane();
    private CustomDropDown proveedoresDropDown = new CustomDropDown();
    private BarCodeTxt barCode = new BarCodeTxt();
    private BarCodeArea barCodeArea = new BarCodeArea();

    /**
     * Creates new form ReciboProducto
     */
    public ReciboProductoBC() {
        initComponents();
        proveedoresDropDown.setDao(proveedoresDao);
        proveedoresDropDown.setEtiqueta("Proveedor");
        proveedoresDropDown.init();
        panelBusqueda.add(proveedoresDropDown);
        proveedoresDropDown.setBounds(50, 50, 500, 65);
        panelBusqueda.add(barCode);
        panelBusqueda.add(barCodeArea);
        barCode.setModoOperacion("ENTRADA");
        barCode.setProveedoresDropDown(proveedoresDropDown);
        barCode.setBounds(600, 50, 400, 40);
        barCode.registerObserver(this);
        barCodeArea.setModoOperacion("ENTRADA");
        barCodeArea.setProveedoresDropDown(proveedoresDropDown);
        barCodeArea.setBounds(600, 100, 700, 300);
        barCodeArea.registerObserver(this);
        setManager(KeyboardFocusManager.getCurrentKeyboardFocusManager());
        exceptions.add(proveedoresDropDown.getTxt());
        exceptions.add(numeroCajasTxt);
        exceptions.add(barCodeArea.getBarCodeArea());
        setDispacher(new BarCodeScannerKeyDispatcher(barCode.getBarCodeTxt(), getManager(), exceptions));
        getManager().addKeyEventDispatcher(getDispacher());
        eliminarBtn.setFocusTraversalKeysEnabled(false);
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
        panelBusqueda = new javax.swing.JPanel();
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

        javax.swing.GroupLayout panelBusquedaLayout = new javax.swing.GroupLayout(panelBusqueda);
        panelBusqueda.setLayout(panelBusquedaLayout);
        panelBusquedaLayout.setHorizontalGroup(
            panelBusquedaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 1350, Short.MAX_VALUE)
        );
        panelBusquedaLayout.setVerticalGroup(
            panelBusquedaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 276, Short.MAX_VALUE)
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

    private void recibirNumCajasBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_recibirNumCajasBtnActionPerformed
        multiplicarUltimaCaja();
    }//GEN-LAST:event_recibirNumCajasBtnActionPerformed

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

    private void numeroCajasTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_numeroCajasTxtActionPerformed
        multiplicarUltimaCaja();
        numeroCajasTxt.setText("");
        cajasDialog.dispose();
    }//GEN-LAST:event_numeroCajasTxtActionPerformed

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

    private Object[] getProveedoresArray() {
        Object[] proveedores = null;
        try {
            proveedores = proveedoresDao.getElementsArray();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurriò un error al consultar los proveedores", "Error", ERROR_MESSAGE);
            return null;
        }
        return proveedores;
    }

    @Override
    public void updateBarCodeTxtObserver() {
        ProductosInventario productoNuevo = new ProductosInventario();
        productoNuevo.setPeso(new BigDecimal(barCode.getPeso()));
        productoNuevo.setCodigoBarras(barCode.getBarCode());
        productoNuevo.setProductosHasProveedores(barCode.getProducto());
        productoNuevo.setCosto(barCode.getProducto().getPrecioSugerido());
        productoNuevo.setPrecio(barCode.getProducto().getProductos().getPrecioSugerido());
        productoNuevo.setUbicaciones(UsuarioFirmado.getUsuarioFirmado().getUbicaciones());
        productoNuevo.setEstatus("ACTIVO");
        ultimoProductoInventario = productoNuevo;
        nuevosProductos.add(productoNuevo);

        Object[] canal = new Object[5];

        canal[0] = barCode.getPeso();
        canal[1] = proveedoresDropDown.getSelectedItem().toString();
        canal[2] = barCode.getProducto().getProductos().getDescripcion();
        canal[3] = UsuarioFirmado.getUsuarioFirmado().getUbicaciones();
        canal[4] = barCode.getBarCode();
        ultimoProducto = canal;

        model.addRow(canal);
    }

    @Override
    public void updateBarCodeAreaObserver() {
        for (ProductosInventario producto : barCodeArea.getProductosInventario()) {
            nuevosProductos.add(producto);

            Object[] canal = new Object[5];

            canal[0] = producto.getPeso();
            canal[1] = proveedoresDropDown.getSelectedItem().toString();
            canal[2] = producto.getProductosHasProveedores().getProductos().getDescripcion();
            canal[3] = UsuarioFirmado.getUsuarioFirmado().getUbicaciones();
            canal[4] = producto.getCodigoBarras();

            model.addRow(canal);
        }
        barCodeArea.getProductosInventario().clear();

    }

    private Proveedores getProveedorSeleccionado() {
        return (Proveedores) proveedoresDropDown.getSelectedItem();
    }


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JDialog cajasDialog;
    private javax.swing.JButton eliminarBtn;
    private javax.swing.JButton finalizarBtn;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JSplitPane jSplitPane2;
    private javax.swing.JButton limpiarBtn;
    private javax.swing.JTextField numeroCajasTxt;
    private javax.swing.JPanel panelBusqueda;
    private javax.swing.JButton recibirNumCajasBtn;
    private javax.swing.JTable tablaCanales;
    // End of variables declaration//GEN-END:variables

}
