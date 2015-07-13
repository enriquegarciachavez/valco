package panels;

import dao.ProcesosDAO;
import dao.ProductoDAO;
import java.awt.event.KeyEvent;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.AbstractButton;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.table.DefaultTableModel;
import javax.swing.text.DefaultFormatterFactory;
import javax.swing.text.MaskFormatter;
import mapping.Procesos;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import mapping.Ubicaciones;
import threads.PesoThread;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Administrador
 */
public class EtiquetadoPanel extends javax.swing.JPanel {
    ProcesosDAO procesosDAO = new ProcesosDAO();
    ProductoDAO productoDAO = new ProductoDAO();
    DefaultTableModel model = new DefaultTableModel();
    /**
     * Creates new form EtiquetadoPanel
     */
    public EtiquetadoPanel() {
   
            initComponents();
            this.setTableModel();
        try {
            consecutivoLbl.setText(procesosDAO.getConsecutivo(((Procesos)procesosLov.getSelectedItem()).getCodigo()).toString());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
            PesoThread pesoThread = null;
            try {
                pesoThread = new PesoThread();
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, "Ocurrio un error al leer el peso de la bascula", "Error", ERROR_MESSAGE);
                pesoManualChk.setSelected(true);
                pesoManualChk.setEnabled(false);
                pesoBasculaLbl.setEnabled(false);
                pesoManualLbl.setEnabled(true);
                return;
            }
            pesoThread.setPesoLbl(pesoBasculaLbl);
            Thread thread = new Thread(pesoThread);
            thread.start();

    }
    
    private Object[] getProducts(){
        Object[] productosArray = new Object[0];
        try{
            Proveedores proveedor = new Proveedores();
            proveedor.setCodigo(1);
            productosArray = productoDAO.getProductosXProveedor(proveedor).toArray();
        }catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(),"Error" ,ERROR_MESSAGE);
        }
        return productosArray;
    }
    
    private Object[] getProcesosActivosArray(){
        Object[] procesosActivosArray = new Object[0];
        try{
            procesosActivosArray = procesosDAO.getProcesosActivos().toArray();
        }catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(),"Error" ,ERROR_MESSAGE);
        }
        return procesosActivosArray;
    }
    
    private Object[] getProcesosActivosEInactivosArray(){
        Object[] procesosActivosEInactivosArray = new Object[0];
        try{
            procesosActivosEInactivosArray = procesosDAO.getProcesosActivosEInactivos().toArray();
        }catch(Exception ex){
            JOptionPane.showMessageDialog(null, ex.getMessage(),"Error" ,ERROR_MESSAGE);
        }
        return procesosActivosEInactivosArray;
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel2 = new javax.swing.JPanel();
        jScrollPane3 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        String[] columnNames = {"Nombre",
            "Peso",
            "Etiqueta",
            "Consecutivo"};

        model.setColumnIdentifiers(columnNames);
        jPanel1 = new javax.swing.JPanel();
        procesosCerradosChk = new javax.swing.JCheckBox();
        procesosLov = new javax.swing.JComboBox();
        jLabel2 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        descripcionArea = new javax.swing.JTextArea();
        pesoBasculaLbl = new javax.swing.JLabel();
        pesoManualChk = new javax.swing.JCheckBox();
        toneladasChk = new javax.swing.JCheckBox();
        jScrollPane2 = new javax.swing.JScrollPane();
        productoCodigoArea = new javax.swing.JTextArea();
        productosLov = new javax.swing.JComboBox();
        fechaElaboracionEtiquetaChk = new javax.swing.JCheckBox();
        fechaCaducidadEtiquetaChk = new javax.swing.JCheckBox();
        diasCaducidadTxt = new javax.swing.JTextField();
        jLabel6 = new javax.swing.JLabel();
        reimprimirEtiquetaBtn = new javax.swing.JButton();
        jLabel8 = new javax.swing.JLabel();
        imprimirEtiquetaBtn = new javax.swing.JButton();
        jLabel9 = new javax.swing.JLabel();
        productoLbl = new javax.swing.JLabel();
        eliminarCajaBtn = new javax.swing.JButton();
        jLabel11 = new javax.swing.JLabel();
        jLabel12 = new javax.swing.JLabel();
        jLabel13 = new javax.swing.JLabel();
        consecutivoLbl = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jFormattedTextField1 = new javax.swing.JFormattedTextField();
        pesoManualLbl = new javax.swing.JFormattedTextField();
        procesoLbl = new javax.swing.JLabel();

        jPanel2.setLayout(new javax.swing.BoxLayout(jPanel2, javax.swing.BoxLayout.LINE_AXIS));

        jTable1.setModel(model);
        jScrollPane3.setViewportView(jTable1);

        jPanel2.add(jScrollPane3);

        procesosCerradosChk.setText("Mostrar procesos cerrados");
        procesosCerradosChk.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                procesosCerradosChkActionPerformed(evt);
            }
        });

        procesosLov.setModel(new DefaultComboBoxModel(getProcesosActivosArray()));
        procesosLov.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                procesosLovActionPerformed(evt);
            }
        });

        jLabel2.setText("ID del proceso:");

        descripcionArea.setColumns(20);
        descripcionArea.setRows(5);
        jScrollPane1.setViewportView(descripcionArea);

        pesoBasculaLbl.setBackground(new java.awt.Color(0, 0, 0));
        pesoBasculaLbl.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        pesoBasculaLbl.setForeground(new java.awt.Color(0, 255, 0));
        pesoBasculaLbl.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        pesoBasculaLbl.setText("XXX.XX");
        pesoBasculaLbl.setOpaque(true);

        pesoManualChk.setText("Pesaje Manual");
        pesoManualChk.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                pesoManualChkActionPerformed(evt);
            }
        });

        toneladasChk.setText("Toneladas");
        toneladasChk.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                toneladasChkActionPerformed(evt);
            }
        });

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

        productosLov.setModel(new DefaultComboBoxModel(getProducts()));
        productosLov.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                productosLovActionPerformed(evt);
            }
        });

        fechaElaboracionEtiquetaChk.setLabel("Fecha de elaboración en etiqueta");

        fechaCaducidadEtiquetaChk.setText("Fecha de caducidad en etiqueta");

        jLabel6.setText("Días más fecha actual");

        reimprimirEtiquetaBtn.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        reimprimirEtiquetaBtn.setText("<html><center>Reimprimir<br>Etiqueta<html>");

        jLabel8.setFont(new java.awt.Font("Tahoma", 0, 12)); // NOI18N
        jLabel8.setText("Piezas por empaque");

        imprimirEtiquetaBtn.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        imprimirEtiquetaBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/Print-48.png"))); // NOI18N
        imprimirEtiquetaBtn.setText("<html><center>Imprimir<br>Etiqueta<html>");
        imprimirEtiquetaBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                imprimirEtiquetaBtnActionPerformed(evt);
            }
        });

        jLabel9.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel9.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        jLabel9.setText("Producto:");

        productoLbl.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N
        productoLbl.setText(productosLov.getSelectedItem().toString());

        eliminarCajaBtn.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        eliminarCajaBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/button_cancel-48.png"))); // NOI18N
        eliminarCajaBtn.setText("<html><center>Eliminar<br>Caja<html>");

        jLabel11.setText("Cajas:");

        jLabel12.setText("000000");

        jLabel13.setText("Consecutivo:");

        consecutivoLbl.setText("00000");

        jLabel4.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N
        jLabel4.setText("Descripción:");

        jFormattedTextField1.setForeground(new java.awt.Color(0, 255, 0));
        try {
            jFormattedTextField1.setFormatterFactory(new javax.swing.text.DefaultFormatterFactory(new javax.swing.text.MaskFormatter("####.##")));
        } catch (java.text.ParseException ex) {
            ex.printStackTrace();
        }
        jFormattedTextField1.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
        jFormattedTextField1.setCursor(new java.awt.Cursor(java.awt.Cursor.TEXT_CURSOR));
        jFormattedTextField1.setDoubleBuffered(true);
        jFormattedTextField1.setDragEnabled(true);
        jFormattedTextField1.setFocusCycleRoot(true);
        jFormattedTextField1.setFocusTraversalPolicyProvider(true);
        jFormattedTextField1.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N

        pesoManualLbl.setBackground(new java.awt.Color(0, 0, 0));
        pesoManualLbl.setForeground(new java.awt.Color(0, 204, 0));
        try {
            pesoManualLbl.setFormatterFactory(new javax.swing.text.DefaultFormatterFactory(new javax.swing.text.MaskFormatter("###.##")));
        } catch (java.text.ParseException ex) {
            ex.printStackTrace();
        }
        pesoManualLbl.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
        pesoManualLbl.setEnabled(false);
        pesoManualLbl.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N

        procesoLbl.setText(procesosLov.getSelectedItem().toString());

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(14, 14, 14)
                        .addComponent(procesosCerradosChk)
                        .addGap(31, 31, 31)
                        .addComponent(procesosLov, javax.swing.GroupLayout.PREFERRED_SIZE, 191, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 85, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(procesoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 95, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel13)
                    .addComponent(jLabel11))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel12)
                    .addComponent(consecutivoLbl))
                .addGap(173, 173, 173))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(pesoBasculaLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 373, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(10, 10, 10)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(fechaElaboracionEtiquetaChk)
                            .addComponent(fechaCaducidadEtiquetaChk)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(diasCaducidadTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 69, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(18, 18, 18)
                                .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 135, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                                .addComponent(productosLov, javax.swing.GroupLayout.Alignment.LEADING, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 226, Short.MAX_VALUE))))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 213, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(14, 14, 14)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(reimprimirEtiquetaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 153, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(28, 28, 28)
                                .addComponent(imprimirEtiquetaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 146, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(49, 49, 49)
                                .addComponent(eliminarCajaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 185, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(jFormattedTextField1, javax.swing.GroupLayout.DEFAULT_SIZE, 266, Short.MAX_VALUE)
                                    .addComponent(pesoManualLbl))
                                .addGap(18, 18, 18)
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(toneladasChk, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(pesoManualChk, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(jLabel8, javax.swing.GroupLayout.PREFERRED_SIZE, 112, javax.swing.GroupLayout.PREFERRED_SIZE)))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 88, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(productoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 375, javax.swing.GroupLayout.PREFERRED_SIZE))))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 609, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(procesosCerradosChk)
                            .addComponent(procesosLov, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel11)
                            .addComponent(jLabel12))
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGap(2, 2, 2)
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                    .addComponent(jLabel13)
                                    .addComponent(consecutivoLbl)))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                    .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(procesoLbl))))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(21, 21, 21)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(pesoBasculaLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 101, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 54, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(productosLov, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(18, 18, 18)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(pesoManualChk)
                            .addComponent(fechaElaboracionEtiquetaChk))
                        .addGap(6, 6, 6)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(toneladasChk)
                            .addComponent(fechaCaducidadEtiquetaChk)))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(pesoManualLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(2, 2, 2)))
                .addGap(4, 4, 4)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(diasCaducidadTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jFormattedTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, 49, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel8))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(reimprimirEtiquetaBtn)
                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(imprimirEtiquetaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(eliminarCajaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(productoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 46, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(121, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, 635, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, 821, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
    }// </editor-fold>//GEN-END:initComponents

    private void procesosCerradosChkActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_procesosCerradosChkActionPerformed
        AbstractButton abstractButton = (AbstractButton) evt.getSource();
        boolean selected = abstractButton.getModel().isSelected();
        if(selected){
            this.procesosLov.setModel(new DefaultComboBoxModel(getProcesosActivosEInactivosArray()));
        }else{
            this.procesosLov.setModel(new DefaultComboBoxModel(getProcesosActivosArray()));
        }
        procesoLbl.setText(procesosLov.getSelectedItem().toString());
    }//GEN-LAST:event_procesosCerradosChkActionPerformed

    private void procesosLovActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_procesosLovActionPerformed
        procesoLbl.setText(procesosLov.getSelectedItem().toString());
        try {
            consecutivoLbl.setText(procesosDAO.getConsecutivo(((Procesos)procesosLov.getSelectedItem()).getCodigo()).toString());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
        this.setTableModel();
    }//GEN-LAST:event_procesosLovActionPerformed

    private void productoCodigoAreaKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productoCodigoAreaKeyReleased
        char c = evt.getKeyChar();
        if (!(Character.isDigit(c) || c == KeyEvent.VK_BACK_SPACE || c == KeyEvent.VK_DELETE)) {
            evt.consume();
        } else {
            if(!productoCodigoArea.getText().equals("")){
                Productos producto = new Productos();
                producto.setCodigo(new Integer(productoCodigoArea.getText()));
                productosLov.setSelectedItem(producto);
                productosLov.repaint();
            }
        }
    }//GEN-LAST:event_productoCodigoAreaKeyReleased

    private void productoCodigoAreaKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productoCodigoAreaKeyTyped
        char c = evt.getKeyChar();
        if (!(Character.isDigit(c) || c == KeyEvent.VK_BACK_SPACE || c == KeyEvent.VK_DELETE)) {
            evt.consume();
        }
    }//GEN-LAST:event_productoCodigoAreaKeyTyped

    private void pesoManualChkActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_pesoManualChkActionPerformed
        AbstractButton abstractButton = (AbstractButton) evt.getSource();
        boolean selected = abstractButton.getModel().isSelected();
        if(selected){
            this.pesoBasculaLbl.setEnabled(false);
            this.pesoManualLbl.setEnabled(true);
        }else{
            this.pesoBasculaLbl.setEnabled(true);
            this.pesoManualLbl.setEnabled(false);
        }
    }//GEN-LAST:event_pesoManualChkActionPerformed

    private void toneladasChkActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_toneladasChkActionPerformed
        AbstractButton abstractButton = (AbstractButton) evt.getSource();
        boolean selected = abstractButton.getModel().isSelected();
        if(selected){
            try {
                pesoManualLbl.setFormatterFactory(null);
                pesoManualLbl.setText("");
                pesoManualLbl.setFormatterFactory(new javax.swing.text.DefaultFormatterFactory(new javax.swing.text.MaskFormatter("####.##")));
            } catch (ParseException ex) {
                JOptionPane.showMessageDialog(null, "Ocurrio un error al dar formato al peso", "Errr", ERROR_MESSAGE);
            }
        }else{
            try {
                pesoManualLbl.setFormatterFactory(null);
                pesoManualLbl.setText("");
                pesoManualLbl.setFormatterFactory(new javax.swing.text.DefaultFormatterFactory(new javax.swing.text.MaskFormatter("###.##")));
            } catch (ParseException ex) {
                JOptionPane.showMessageDialog(null, "Ocurrio un error al dar formato al peso", "Errr", ERROR_MESSAGE);
            }
        }
    }//GEN-LAST:event_toneladasChkActionPerformed

    private void productosLovActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_productosLovActionPerformed
        productoLbl.setText(productosLov.getSelectedItem().toString());
        productoCodigoArea.setText(((Productos)productosLov.getSelectedItem()).getCodigo().toString());
    }//GEN-LAST:event_productosLovActionPerformed

    private void imprimirEtiquetaBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_imprimirEtiquetaBtnActionPerformed
        ProductosInventario productoInventario = new ProductosInventario();
        Ubicaciones ubicacion = new Ubicaciones();
        ubicacion.setCodigo(1);
        productoInventario.setProductosHasProveedores((ProductosHasProveedores) productosLov.getSelectedItem());
        productoInventario.setUbicaciones(ubicacion);
        if(pesoManualChk.isSelected()){
            productoInventario.setPeso(new BigDecimal(pesoManualLbl.getText()));
        }else{
            productoInventario.setPeso(new BigDecimal(pesoBasculaLbl.getText()));
        }
        productoInventario.setProcesosCodigoPadre(((Procesos)procesosLov.getSelectedItem()).getCodigo());
        productoInventario.setPrecio(BigDecimal.ZERO);
        productoInventario.setEstatus("ACTIVO");
        productoInventario.setConsecutivoProceso(new Integer(consecutivoLbl.getText()));
        try {
            productoDAO.insertarProducto(productoInventario);
            JOptionPane.showMessageDialog(null, "Se creo el producto correctamente");
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex, "Errot", ERROR_MESSAGE);
        }
        this.setTableModel();
    }//GEN-LAST:event_imprimirEtiquetaBtnActionPerformed

    private void setTableModel(){
        int rowCount = model.getRowCount();
        //Remove rows one by one from the end of the table
        for (int i = rowCount - 1; i >= 0; i--) {
            model.removeRow(i);
        }
        List<ProductosInventario> productos = new ArrayList<>();  
        try {
             productos = procesosDAO.getCajasPorProceso(((Procesos)procesosLov.getSelectedItem()).getCodigo());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex, "Error",ERROR_MESSAGE);
        }
        for(ProductosInventario producto : productos){
            Object[] row = new Object[4];
            row[0] = producto.toString();
            row[1] = producto.getPeso();
            row[2] = producto.getCodigoBarras();
            row[3] = producto.getConsecutivoProceso();
            model.addRow(row);
        }
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel consecutivoLbl;
    private javax.swing.JTextArea descripcionArea;
    private javax.swing.JTextField diasCaducidadTxt;
    private javax.swing.JButton eliminarCajaBtn;
    private javax.swing.JCheckBox fechaCaducidadEtiquetaChk;
    private javax.swing.JCheckBox fechaElaboracionEtiquetaChk;
    private javax.swing.JButton imprimirEtiquetaBtn;
    private javax.swing.JFormattedTextField jFormattedTextField1;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JTable jTable1;
    private javax.swing.JLabel pesoBasculaLbl;
    private javax.swing.JCheckBox pesoManualChk;
    private javax.swing.JFormattedTextField pesoManualLbl;
    private javax.swing.JLabel procesoLbl;
    private javax.swing.JCheckBox procesosCerradosChk;
    private javax.swing.JComboBox procesosLov;
    private javax.swing.JTextArea productoCodigoArea;
    private javax.swing.JLabel productoLbl;
    private javax.swing.JComboBox productosLov;
    private javax.swing.JButton reimprimirEtiquetaBtn;
    private javax.swing.JCheckBox toneladasChk;
    // End of variables declaration//GEN-END:variables
}
