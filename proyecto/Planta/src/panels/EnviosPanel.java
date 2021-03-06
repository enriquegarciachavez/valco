/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package panels;

import dao.ProductoDAO;
import dao.TransferenciasDAO;
import dao.UbicacionesDAO;
import java.awt.Component;
import java.awt.ComponentOrientation;
import java.awt.KeyboardFocusManager;
import java.awt.event.KeyEvent;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.AbstractButton;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.table.DefaultTableModel;
import keydispatchers.BarCodeScannerKeyDispatcher;
import listeners.NumericKeyListener;
import mapping.Mermas;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import mapping.Tranferencias;
import mapping.Ubicaciones;
import pesable.PesableBarCodeable;
import table.custom.NoEditableTableModel;
import threads.PesoThread;
import utilities.UsuarioFirmado;

/**
 *
 * @author Karla
 */
public class EnviosPanel extends PesableBarCodeable {

    ProductoDAO productoDAO = new ProductoDAO();
    UbicacionesDAO ubicacionesDAO = new UbicacionesDAO();
    DefaultTableModel model = new NoEditableTableModel();
    List<ProductosInventario> productosList = new ArrayList<ProductosInventario>();
    public List<Component> exceptions = new ArrayList<>();
    private TransferenciasDAO transferenciasDao = new TransferenciasDAO();
    private String modoOperacion;
    private Tranferencias transferenciaSeleccionada;

    public EnviosPanel(String modoOperacion) {
        this.modoOperacion = modoOperacion;
        initComponents();
        setManager(KeyboardFocusManager.getCurrentKeyboardFocusManager());
        exceptions.add(pesoManualLbl);
        exceptions.add(productoCodigoArea);
        setDispacher(new BarCodeScannerKeyDispatcher(barCodeTxt, getManager(), exceptions));
        getManager().addKeyEventDispatcher(getDispacher());
        try {
            setPesoThread(new PesoThread());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurrio un error al leer el peso de la bascula", "Error", ERROR_MESSAGE);
            pesoManualChk.setSelected(true);
            pesoManualChk.setEnabled(false);
            pesoBasculaLbl.setEnabled(false);
            pesoManualLbl.setEnabled(true);
            return;
        }
        getPesoThread().setPesoLbl(pesoBasculaLbl);
        Thread thread = new Thread(getPesoThread());
        thread.start();
    }

    public EnviosPanel() {
        modoOperacion = "ENVIO";
        initComponents();
        setManager(KeyboardFocusManager.getCurrentKeyboardFocusManager());
        exceptions.add(pesoManualLbl);
        exceptions.add(productoCodigoArea);
        setDispacher(new BarCodeScannerKeyDispatcher(barCodeTxt, getManager(), exceptions));
        getManager().addKeyEventDispatcher(getDispacher());
        try {
            setPesoThread(new PesoThread());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurrio un error al leer el peso de la bascula", "Error", ERROR_MESSAGE);
            pesoManualChk.setSelected(true);
            pesoManualChk.setEnabled(false);
            pesoBasculaLbl.setEnabled(false);
            pesoManualLbl.setEnabled(true);
            return;
        }
        getPesoThread().setPesoLbl(pesoBasculaLbl);
        Thread thread = new Thread(getPesoThread());
        thread.start();
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
        jSplitPane2 = new javax.swing.JSplitPane();
        jPanel3 = new javax.swing.JPanel();
        barCodeTxt = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        jButton1 = new javax.swing.JButton();
        jPanel4 = new javax.swing.JPanel();
        jScrollPane2 = new javax.swing.JScrollPane();
        productoCodigoArea = new javax.swing.JTextArea();
        pesoBasculaLbl = new javax.swing.JLabel();
        productosLov = new javax.swing.JComboBox();
        pesoManualChk = new javax.swing.JCheckBox();
        pesoManualLbl = new javax.swing.JTextField();
        jButton2 = new javax.swing.JButton();
        jPanel2 = new javax.swing.JPanel();
        jSplitPane3 = new javax.swing.JSplitPane();
        jPanel5 = new javax.swing.JPanel();
        almacenLOV = new javax.swing.JComboBox();
        jLabel5 = new javax.swing.JLabel();
        enviarBtn = new javax.swing.JButton();
        quitarBtn = new javax.swing.JButton();
        jPanel6 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        tablaCanales = new javax.swing.JTable();

        setPreferredSize(new java.awt.Dimension(1394, 654));
        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane1.setDividerLocation(250);
        jSplitPane1.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);

        jPanel1.setLayout(new javax.swing.BoxLayout(jPanel1, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane2.setDividerLocation(650);

        jPanel3.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        barCodeTxt.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                barCodeTxtActionPerformed(evt);
            }
        });
        barCodeTxt.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyTyped(java.awt.event.KeyEvent evt) {
                barCodeTxtKeyTyped(evt);
            }
        });
        jPanel3.add(barCodeTxt, new org.netbeans.lib.awtextra.AbsoluteConstraints(106, 27, 269, -1));

        jLabel1.setText("Codigo de Barras:");
        jPanel3.add(jLabel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 27, -1, 20));

        jButton1.setText("Agregar");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });
        jPanel3.add(jButton1, new org.netbeans.lib.awtextra.AbsoluteConstraints(190, 110, -1, -1));

        jSplitPane2.setLeftComponent(jPanel3);

        jScrollPane2.setHorizontalScrollBar(null);

        productoCodigoArea.setColumns(20);
        productoCodigoArea.setRows(5);
        productoCodigoArea.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                productoCodigoAreaKeyReleased(evt);
            }
            public void keyTyped(java.awt.event.KeyEvent evt) {
                productoCodigoAreaKeyTyped(evt);
            }
        });
        jScrollPane2.setViewportView(productoCodigoArea);

        pesoBasculaLbl.setBackground(new java.awt.Color(0, 0, 0));
        pesoBasculaLbl.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        pesoBasculaLbl.setForeground(new java.awt.Color(0, 255, 0));
        pesoBasculaLbl.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        pesoBasculaLbl.setText("XXX.XX");
        pesoBasculaLbl.setOpaque(true);

        productosLov.setModel(new DefaultComboBoxModel(getProducts()));
        productosLov.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                productosLovActionPerformed(evt);
            }
        });

        pesoManualChk.setText("Pesaje Manual");
        pesoManualChk.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                pesoManualChkActionPerformed(evt);
            }
        });

        pesoManualLbl.setBackground(new java.awt.Color(0, 0, 0));
        pesoManualLbl.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        pesoManualLbl.setForeground(new java.awt.Color(0, 204, 51));
        pesoManualLbl.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        pesoManualLbl.addKeyListener(new NumericKeyListener());

        jButton2.setText("Agregar");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addContainerGap(522, Short.MAX_VALUE)
                .addComponent(jButton2)
                .addGap(126, 126, 126))
            .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jPanel4Layout.createSequentialGroup()
                    .addContainerGap()
                    .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(jPanel4Layout.createSequentialGroup()
                            .addComponent(pesoBasculaLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 373, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                            .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                                .addComponent(productosLov, javax.swing.GroupLayout.Alignment.LEADING, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 226, Short.MAX_VALUE)))
                        .addGroup(jPanel4Layout.createSequentialGroup()
                            .addComponent(pesoManualLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 266, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGap(18, 18, 18)
                            .addComponent(pesoManualChk, javax.swing.GroupLayout.DEFAULT_SIZE, 419, Short.MAX_VALUE)))
                    .addContainerGap()))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                .addContainerGap(196, Short.MAX_VALUE)
                .addComponent(jButton2)
                .addGap(28, 28, 28))
            .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                .addGroup(jPanel4Layout.createSequentialGroup()
                    .addGap(28, 28, 28)
                    .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(pesoBasculaLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 101, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGroup(jPanel4Layout.createSequentialGroup()
                            .addGap(5, 5, 5)
                            .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 54, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                            .addComponent(productosLov, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGap(18, 18, 18)
                    .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(pesoManualLbl, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGroup(jPanel4Layout.createSequentialGroup()
                            .addComponent(pesoManualChk)
                            .addGap(49, 49, 49)))
                    .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
        );

        jSplitPane2.setRightComponent(jPanel4);

        jPanel1.add(jSplitPane2);

        jSplitPane1.setTopComponent(jPanel1);

        jPanel2.setLayout(new javax.swing.BoxLayout(jPanel2, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane3.setDividerLocation(50);
        jSplitPane3.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);

        almacenLOV.setModel(new DefaultComboBoxModel(getUbicacionesArray()));

        jLabel5.setText("Almacen:");

        enviarBtn.setText("Transferir");
        enviarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                enviarBtnActionPerformed(evt);
            }
        });

        quitarBtn.setText("Quitar producto");
        quitarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                quitarBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel5)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(almacenLOV, javax.swing.GroupLayout.PREFERRED_SIZE, 133, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(40, 40, 40)
                .addComponent(quitarBtn)
                .addGap(156, 156, 156)
                .addComponent(enviarBtn)
                .addContainerGap(792, Short.MAX_VALUE))
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel5)
                    .addComponent(almacenLOV, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(enviarBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(quitarBtn))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jSplitPane3.setTopComponent(jPanel5);

        jPanel6.setLayout(new javax.swing.BoxLayout(jPanel6, javax.swing.BoxLayout.LINE_AXIS));

        tablaCanales.setModel(model);
        if(modoOperacion.equals("RECIBO")){       
            String[] columnNames = {
                "Peso",
                "Proveedor",
                "Producto",
                "Almacen",
                "Estatus",
                "Merma"};
            model.setColumnIdentifiers(columnNames); 
        }else{
            String[] columnNames = {
                "Peso",
                "Proveedor",
                "Producto",
                "Almacen"};
            model.setColumnIdentifiers(columnNames); 
        }

        jScrollPane1.setViewportView(tablaCanales);

        jPanel6.add(jScrollPane1);

        jSplitPane3.setRightComponent(jPanel6);

        jPanel2.add(jSplitPane3);

        jSplitPane1.setRightComponent(jPanel2);

        add(jSplitPane1);
    }// </editor-fold>//GEN-END:initComponents

    private Object[] getProducts() {
        Object[] productosArray = new Object[0];
        try {
            Proveedores proveedor = new Proveedores();
            proveedor.setCodigo(1);
            productosArray = productoDAO.getProductosXProveedor(proveedor).toArray();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error", ERROR_MESSAGE);
        }
        return productosArray;
    }

    private Object[] getUbicacionesArray() {
        Object[] ubicaciones = null;
        try {
            ubicaciones = ubicacionesDAO.getUbicaciones().toArray();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurriò un error al consultar los Productos", "Error", ERROR_MESSAGE);
        }
        return ubicaciones;
    }
    private void barCodeTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_barCodeTxtActionPerformed
        // TODO add your handling code here:

    }//GEN-LAST:event_barCodeTxtActionPerformed

    private void barCodeTxtKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_barCodeTxtKeyTyped
        if (evt.getKeyChar() == KeyEvent.VK_ENTER) {
            changeScanned(barCodeTxt.getText());
        }
    }//GEN-LAST:event_barCodeTxtKeyTyped

    private void changeScanned(String barCode) {
        if (modoOperacion.equals("RECIBO")) {
            for (int row = 0; row < model.getRowCount(); row++) {
                ProductosInventario productoRow = (ProductosInventario) model.getValueAt(row, 2);
                if (productoRow.getCodigoBarras() != null && productoRow.getCodigoBarras().equals(barCode)) {
                    productoRow.setEstatus("ACTIVO");
                    model.setValueAt("ACTIVO", row, 4);
                    model.setValueAt(productoRow.getTranferencias().getUbicacionesByDestino(), row, 3);
                    productoRow.setUbicaciones(productoRow.getTranferencias().getUbicacionesByDestino());
                    try {
                        transferenciasDao.actualizarTransferencias(productoRow.getTranferencias(),null);
                    } catch (Exception ex) {
                        JOptionPane.showMessageDialog(null, ex.getMessage());
                    }
                }
            }
        } else {
            ProductosInventario productoNuevo = new ProductosInventario();
            try {
                productoNuevo = productoDAO.getProductosXCodigoBarras(barCode);
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex.getMessage());
            }
            if (isProductoRepetido(model, productoNuevo)) {
                return;
            }
            Object[] canal = new Object[5];

            canal[0] = productoNuevo.getPeso();
            canal[1] = productoNuevo.getProductosHasProveedores().getProveedores().getRazonSocial();
            canal[2] = productoNuevo;
            canal[3] = productoNuevo.getUbicaciones();

            model.addRow(canal);
            barCodeTxt.setText("");

        }
    }

    private boolean isProductoRepetido(DefaultTableModel model, ProductosInventario producto) {
        for (int count = 0; count < model.getRowCount(); count++) {
            if (producto.equals((ProductosInventario) model.getValueAt(count, 2))) {
                return true;
            }
        }
        return false;

    }
    private void productoCodigoAreaKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productoCodigoAreaKeyReleased
        char c = evt.getKeyChar();

        if (!productoCodigoArea.getText().equals("")) {
            ProductosHasProveedores productoProveedor = new ProductosHasProveedores();
            Productos producto = new Productos();
            try {
                producto = productoDAO.getProductosXDescripcionOCodigo(productoCodigoArea.getText());
            } catch (Exception ex) {
                Logger.getLogger(EnviosPanel.class.getName()).log(Level.SEVERE, null, ex);
            }
            productoProveedor.setProductos(producto);
            Proveedores prov = new Proveedores();
            prov.setCodigo(1);
            productoProveedor.setProveedores(prov);
            productosLov.setSelectedItem(productoProveedor);
            productosLov.repaint();
        }

    }//GEN-LAST:event_productoCodigoAreaKeyReleased

    private void productoCodigoAreaKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productoCodigoAreaKeyTyped

    }//GEN-LAST:event_productoCodigoAreaKeyTyped

    private void productosLovActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_productosLovActionPerformed

        productoCodigoArea.setText(((ProductosHasProveedores) productosLov.getSelectedItem()).getCodigo().toString());
    }//GEN-LAST:event_productosLovActionPerformed

    private void pesoManualChkActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_pesoManualChkActionPerformed
        AbstractButton abstractButton = (AbstractButton) evt.getSource();
        boolean selected = abstractButton.getModel().isSelected();
        if (selected) {
            this.pesoBasculaLbl.setEnabled(false);
            this.pesoManualLbl.setEnabled(true);
        } else {
            this.pesoBasculaLbl.setEnabled(true);
            this.pesoManualLbl.setEnabled(false);
        }
    }//GEN-LAST:event_pesoManualChkActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed

        changeScanned(barCodeTxt.getText());

    }//GEN-LAST:event_jButton1ActionPerformed

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        ProductosInventario productoNuevo = new ProductosInventario();
        String peso = "";
        if (pesoManualChk.isSelected()) {
            peso = pesoManualLbl.getText();
        } else {
            peso = pesoBasculaLbl.getText();
        }
        if (modoOperacion.equals("RECIBO")) {
try {
                productoNuevo = productoDAO.getProductoPesado(peso, ((ProductosHasProveedores) productosLov.getSelectedItem()).getProductos(), transferenciaSeleccionada);
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex.getMessage());
                return;
            }

            for (int row = 0; row < model.getRowCount(); row++) {
                ProductosInventario productoRow = (ProductosInventario) model.getValueAt(row, 2);
                if (productoRow.equals(productoNuevo)) {
                    Mermas merma = null;
                    productoNuevo.setPeso(new BigDecimal(peso));
                    productoRow.setEstatus("ACTIVO");
                    if(productoNuevo.getPeso().compareTo(productoRow.getPeso())==-1){
                        merma = new Mermas();
                        merma.setFecha(new Date());
                        merma.setProductosInventario(productoRow);
                        merma.setTranferencias(transferenciaSeleccionada);
                        merma.setPeso(productoNuevo.getPeso().subtract(productoRow.getPeso()).abs());
                        model.setValueAt(merma.getPeso(), row, 5);
                    }
                    model.setValueAt("ACTIVO", row, 4);
                    model.setValueAt(productoRow.getTranferencias().getUbicacionesByDestino(), row, 3);
                    productoRow.setUbicaciones(productoRow.getTranferencias().getUbicacionesByDestino());
                    try {
                        transferenciasDao.actualizarTransferencias(productoRow.getTranferencias(),merma);
                        return;
                    } catch (Exception ex) {
                        JOptionPane.showMessageDialog(null, ex.getMessage());
                        return;
                    }
                }
            }
        } else {
            try {
                productoNuevo = productoDAO.getProductoPesadoByEstatus(peso, 
                        ((ProductosHasProveedores) productosLov.getSelectedItem()).getProductos(),
                        productosList,"ACTIVO");
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex.getMessage());
            }
            if (isProductoRepetido(model, productoNuevo)) {
                return;
            }
            Object[] canal = new Object[5];

            canal[0] = productoNuevo.getPeso();
            canal[1] = productoNuevo.getProductosHasProveedores().getProveedores().getRazonSocial();
            canal[2] = productoNuevo;
            canal[3] = productoNuevo.getUbicaciones();

            model.addRow(canal);
        }
    }//GEN-LAST:event_jButton2ActionPerformed

    private void enviarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_enviarBtnActionPerformed
        List<ProductosInventario> productos = new ArrayList<>();
        for (int row = 0; row < model.getRowCount(); row++) {
            productos.add((ProductosInventario) model.getValueAt(row, 2));
        }
        if (productos == null || productos.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Debe seleccionar almenos un producto para transferir");
            return;
        }
        Tranferencias transferencia = new Tranferencias();
        transferencia.setEstatus("EN PROCESO");
        transferencia.setFechaEnvio(new Date());
        transferencia.setUbicacionesByDestino((Ubicaciones) almacenLOV.getSelectedItem());
        transferencia.setUbicacionesBySalida(productos.get(0).getUbicaciones());
        transferencia.setUsuarios(UsuarioFirmado.getUsuarioFirmado());
        if (Objects.equals(transferencia.getUbicacionesBySalida().getCodigo(), transferencia.getUbicacionesByDestino().getCodigo())) {
            JOptionPane.showMessageDialog(null, "Debe seleccionar una ubicación de destino diferente a la ubicación de salida.");
            return;
        }
        for (ProductosInventario producto : productos) {
            producto.setEstatus("EN TRANSFERENCIA");
            producto.setTranferencias(transferencia);
        }
        try {
            transferenciasDao.Transferir(transferencia, productos);
            model.setRowCount(0);
            JOptionPane.showMessageDialog(null, "El producto se envió correctamente");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Ocurrió un error al transferir los productos.");
        }
    }//GEN-LAST:event_enviarBtnActionPerformed

    private void quitarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_quitarBtnActionPerformed
        model.removeRow(tablaCanales.getSelectedRow());
    }//GEN-LAST:event_quitarBtnActionPerformed

    public Tranferencias getTransferenciaSeleccionada() {
        return transferenciaSeleccionada;
    }

    public void setTransferenciaSeleccionada(Tranferencias transferenciaSeleccionada) {
        this.transferenciaSeleccionada = transferenciaSeleccionada;
    }

    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox almacenLOV;
    public javax.swing.JTextField barCodeTxt;
    private javax.swing.JButton enviarBtn;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JSplitPane jSplitPane2;
    private javax.swing.JSplitPane jSplitPane3;
    private javax.swing.JLabel pesoBasculaLbl;
    private javax.swing.JCheckBox pesoManualChk;
    public javax.swing.JTextField pesoManualLbl;
    public javax.swing.JTextArea productoCodigoArea;
    private javax.swing.JComboBox productosLov;
    private javax.swing.JButton quitarBtn;
    private javax.swing.JTable tablaCanales;
    // End of variables declaration//GEN-END:variables
}
