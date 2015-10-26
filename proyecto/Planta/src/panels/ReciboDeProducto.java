package panels;

import com.sun.media.sound.ModelOscillator;
import dao.ProductoDAO;
import dao.ProveedorDAO;
import dao.UbicacionesDAO;
import dao.UsuariosDAO;
import java.awt.ComponentOrientation;
import java.awt.event.ActionEvent;
import java.awt.event.ItemEvent;
import java.awt.event.KeyEvent;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.table.DefaultTableModel;
import listeners.NumericKeyListener;
import mapping.OrdenesCompra;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import mapping.Ubicaciones;
import table.custom.NoEditableTableModel;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Karla
 */
public class ReciboDeProducto extends javax.swing.JPanel {

    ProductoDAO productoDAO = new ProductoDAO();
    ProveedorDAO proveedorDAO = new ProveedorDAO();
    UbicacionesDAO ubicacionesDAO = new UbicacionesDAO();
    DefaultTableModel model = new NoEditableTableModel();
    List<ProductosInventario> nuevosCanales = new ArrayList<ProductosInventario>();
    UsuariosDAO usuariosDao = new UsuariosDAO();
    String modoOperacion= "CANAL DE RES";
    ProductosHasProveedores productoAnterior = new ProductosHasProveedores();

    /**
     * Creates new form ReciboDeProducto
     */
    public ReciboDeProducto() {
        initComponents();

    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane2 = new javax.swing.JScrollPane();
        jPanel4 = new javax.swing.JPanel();
        jPanel1 = new javax.swing.JPanel();
        proveedorLOV = new javax.swing.JComboBox();
        jLabel4 = new javax.swing.JLabel();
        productoTxt = new javax.swing.JTextField();
        productoLov = new javax.swing.JComboBox();
        jLabel3 = new javax.swing.JLabel();
        proveedorTxt = new javax.swing.JTextField();
        jPanel2 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        matanzaTxt = new javax.swing.JTextField();
        almacenLOV = new javax.swing.JComboBox();
        jLabel5 = new javax.swing.JLabel();
        jPanel3 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        pesoTxt1 = new javax.swing.JTextField();
        jLabel6 = new javax.swing.JLabel();
        numeroCanalTxt = new javax.swing.JTextField();
        pesoTxt2 = new javax.swing.JTextField();
        pesoTxt3 = new javax.swing.JTextField();
        pesoTxt4 = new javax.swing.JTextField();
        jScrollPane1 = new javax.swing.JScrollPane();
        tablaCanales = new javax.swing.JTable();
        finalizarBtn = new javax.swing.JButton();
        agregarBtn = new javax.swing.JButton();
        limpiarBtn = new javax.swing.JButton();

        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder("Tipo de Canal"));

        proveedorLOV.setModel(new DefaultComboBoxModel(getProveedoresArray()));
        proveedorLOV.setSelectedItem(proveedorLOV.getSelectedItem());
        productoLov.setModel(new DefaultComboBoxModel(getProductosArray()));
        proveedorLOV.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                proveedorLOVActionPerformed(evt);
            }
        });

        jLabel4.setText("Proveedor:");

        productoTxt.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                productoTxtActionPerformed(evt);
            }
        });
        productoTxt.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                productoTxtKeyReleased(evt);
            }
            public void keyTyped(java.awt.event.KeyEvent evt) {
                productoTxtKeyTyped(evt);
            }
        });

        productoLov.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                productoLovItemStateChanged(evt);
            }
        });
        productoLov.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                productoLovActionPerformed(evt);
            }
        });

        jLabel3.setText("Producto:");

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

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jLabel4)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(proveedorLOV, javax.swing.GroupLayout.PREFERRED_SIZE, 135, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(proveedorTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 135, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel3)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(productoTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 141, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(productoLov, javax.swing.GroupLayout.PREFERRED_SIZE, 141, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(0, 35, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3)
                            .addComponent(productoTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(productoLov, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel4)
                            .addComponent(proveedorTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(proveedorLOV, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(0, 42, Short.MAX_VALUE))
        );

        if(this.productoLov.getSelectedItem() != null){
            this.modoOperacion= this.productoLov.getSelectedItem().toString();

        }

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder("Almacen y Número de Matanza"));

        jLabel1.setText("Nùmero de matanza:");

        almacenLOV.setModel(new DefaultComboBoxModel(getUbicacionesArray()));

        jLabel5.setText("Almacen:");

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel1)
                    .addComponent(jLabel5))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(almacenLOV, javax.swing.GroupLayout.PREFERRED_SIZE, 133, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(matanzaTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 91, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(27, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(matanzaTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(almacenLOV, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel5))
                .addGap(0, 37, Short.MAX_VALUE))
        );

        jPanel3.setBorder(javax.swing.BorderFactory.createTitledBorder("Peso y Número de Canal"));

        jLabel2.setText("Peso:");

        pesoTxt1.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        pesoTxt1.addKeyListener(new NumericKeyListener());
        pesoTxt1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                pesoTxt1ActionPerformed(evt);
            }
        });

        jLabel6.setText("Número de Canal:");

        this.pesoTxt2.setVisible(modoOperacion.equals("CANAL DE EQUINO")
            ||modoOperacion.equals("CANAL DE RES"));
        pesoTxt2.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        pesoTxt2.addKeyListener(new NumericKeyListener());
        pesoTxt2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                pesoTxt2ActionPerformed(evt);
            }
        });

        this.pesoTxt3.setVisible(modoOperacion.equals("CANAL DE RES"));
        pesoTxt3.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        pesoTxt3.addKeyListener(new NumericKeyListener());
        pesoTxt3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                pesoTxt3ActionPerformed(evt);
            }
        });

        this.pesoTxt4.setVisible(modoOperacion.equals("CANAL DE RES"));
        pesoTxt4.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        pesoTxt4.addKeyListener(new NumericKeyListener());
        pesoTxt4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                pesoTxt4ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel6)
                    .addComponent(jLabel2, javax.swing.GroupLayout.Alignment.TRAILING))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addComponent(pesoTxt1, javax.swing.GroupLayout.PREFERRED_SIZE, 75, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(pesoTxt2, javax.swing.GroupLayout.PREFERRED_SIZE, 75, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(pesoTxt3, javax.swing.GroupLayout.PREFERRED_SIZE, 75, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(pesoTxt4, javax.swing.GroupLayout.PREFERRED_SIZE, 77, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(numeroCanalTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 95, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(288, Short.MAX_VALUE))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel6)
                    .addComponent(numeroCanalTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(pesoTxt1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(pesoTxt2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(pesoTxt3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(pesoTxt4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(38, Short.MAX_VALUE))
        );

        tablaCanales.setModel(model);
        if (modoOperacion.equals("CANAL DE EQUINO")){
            String[] columnNames = {"Número de Canal",
                "Peso1",
                "Peso2",
                "Proveedor",
                "Producto",
                "Almacen"};

            model.setColumnIdentifiers(columnNames);
        } else if(modoOperacion.equals("CANAL DE RES")){

            String[] columnNames = {"Número de Canal",
                "Peso1",
                "Peso2",
                "Peso3",
                "Peso4",
                "Proveedor",
                "Producto",
                "Almacen"};
            model.setColumnIdentifiers(columnNames);
        } else if(modoOperacion.equals("RES CASO ESPECIAL")){
            String[] columnNames = {"Número de Canal",
                "Peso",
                "Proveedor",
                "Producto",
                "Almacen"};
            model.setColumnIdentifiers(columnNames); 
        }
        jScrollPane1.setViewportView(tablaCanales);

        finalizarBtn.setText("Finalizar");
        finalizarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                finalizarBtnActionPerformed(evt);
            }
        });

        agregarBtn.setText("Agregar");
        agregarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                agregarBtnActionPerformed(evt);
            }
        });

        limpiarBtn.setText("Eliminar");
        limpiarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                limpiarBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(agregarBtn)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(limpiarBtn)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(finalizarBtn))
                            .addGroup(jPanel4Layout.createSequentialGroup()
                                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 979, Short.MAX_VALUE))
                .addContainerGap())
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(agregarBtn)
                    .addComponent(limpiarBtn)
                    .addComponent(finalizarBtn))
                .addGap(18, 18, 18)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(182, Short.MAX_VALUE))
        );

        jScrollPane2.setViewportView(jPanel4);

        add(jScrollPane2);
    }// </editor-fold>//GEN-END:initComponents

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

    private Object[] getProductosArray() {
        Object[] productos = null;
        try {
            productos = productoDAO.getCanalesXProveedor((Proveedores) proveedorLOV.getSelectedItem()).toArray();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurriò un error al consultar los Productos", "Error", ERROR_MESSAGE);
        }
        return productos;
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

    private void limpiarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_limpiarBtnActionPerformed
       limpiar();
    }//GEN-LAST:event_limpiarBtnActionPerformed
    private void limpiar() {
        pesoTxt1.setText("");
        pesoTxt2.setText("");
        pesoTxt3.setText("");
        pesoTxt4.setText("");
        if (modoOperacion.equals("CANAL DE RES")) {
            String[] columnNames = {"Número de Canal",
                "Peso1",
                "Peso2",
                "Peso3",
                "Peso4",
                "Proveedor",
                "Producto",
                "Almacen"};
            model.setColumnIdentifiers(columnNames);
            pesoTxt2.setVisible(true);
            pesoTxt3.setVisible(true);
            pesoTxt4.setVisible(true);
        } else if (modoOperacion.equals("CANAL DE EQUINO")) {
            String[] columnNames = {"Número de Canal",
                "Peso1",
                "Peso2",
                "Proveedor",
                "Producto",
                "Almacen"};

            model.setColumnIdentifiers(columnNames);
            pesoTxt2.setVisible(true);
            pesoTxt3.setVisible(false);
            pesoTxt4.setVisible(false);
        } else if (modoOperacion.equals("RES CASO ESPECIAL")) {
            String[] columnNames = {"Número de Canal",
                "Peso",
                "Proveedor",
                "Producto",
                "Almacen"};
            model.setColumnIdentifiers(columnNames);
            pesoTxt2.setVisible(false);
            pesoTxt3.setVisible(false);
            pesoTxt4.setVisible(false);
        }
        jPanel3.updateUI();
        jPanel3.repaint();
        pesoTxt2.updateUI();
        model.setRowCount(0);
        nuevosCanales.clear();
    }

    private void agregarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_agregarBtnActionPerformed
        if (modoOperacion.equals("CANAL DE EQUINO")){
            agregarCanalEquino();
        }else if(modoOperacion.equals("RES CASO ESPECIAL")){
            agregarResCasoEspecial();
        }else if(modoOperacion.equals("CANAL DE RES")){
            agregarCanalRes();
        }
    }//GEN-LAST:event_agregarBtnActionPerformed

    private void agregarCanalEquino() {
        
        int numeroCanal =0;
        if (pesoTxt1.getText().equals("") || pesoTxt2.getText().equals("")) {
            JOptionPane.showMessageDialog(null, "Debe capturar el peso.");
            return;
        }
        Object[] canal = new Object[6];
        ProductosInventario canal1 = new ProductosInventario();
        ProductosInventario canal2 = new ProductosInventario();
        if (tablaCanales.getRowCount() == 0) {

            numeroCanal= new Integer(numeroCanalTxt.getText());
        }else {
            numeroCanal = new Integer(tablaCanales.getValueAt(tablaCanales.getRowCount()-1, 0).toString())+1;
        }
        
            canal[0]= numeroCanal;
            canal[1] = pesoTxt1.getText();
            canal[2] = pesoTxt2.getText();
            canal[3] = proveedorLOV.getSelectedItem().toString();
            canal[4] = productoLov.getSelectedItem().toString();
            canal[5] = almacenLOV.getSelectedItem().toString();
        

        model.addRow(canal);

        canal1.setEstatus("ACTIVO");
        canal1.setNumeroMatanza(new Integer (matanzaTxt.getText()));
        canal1.setPeso(new BigDecimal(pesoTxt1.getText()));
        canal1.setPrecio(BigDecimal.ZERO);
        canal1.setProductosHasProveedores((ProductosHasProveedores) productoLov.getSelectedItem());
        canal1.setUbicaciones((Ubicaciones) almacenLOV.getSelectedItem());

        nuevosCanales.add(canal1);

        canal2.setEstatus("ACTIVO");
        canal2.setNumeroMatanza(new Integer (matanzaTxt.getText()));
        canal2.setPeso(new BigDecimal(pesoTxt2.getText()));
        canal2.setPrecio(BigDecimal.ZERO);
        canal2.setProductosHasProveedores((ProductosHasProveedores) productoLov.getSelectedItem());
        canal2.setUbicaciones((Ubicaciones) almacenLOV.getSelectedItem());

        nuevosCanales.add(canal2);
    }

    private void agregarCanalRes() {
        int numeroCanal= 0;
        
        if (pesoTxt1.getText().equals("") || pesoTxt2.getText().equals("") || pesoTxt3.getText().equals("")||pesoTxt4.getText().equals("") ){
            JOptionPane.showMessageDialog(null, "Debe capturar el peso.");
            return;
        }
        Object[] canal = new Object[8];
        ProductosInventario canal1 = new ProductosInventario();
        ProductosInventario canal2 = new ProductosInventario();
        ProductosInventario canal3 = new ProductosInventario();
        ProductosInventario canal4 = new ProductosInventario();
        if (tablaCanales.getRowCount() == 0) {

            numeroCanal= new Integer(numeroCanalTxt.getText());
        }else {
            numeroCanal = new Integer(tablaCanales.getValueAt(tablaCanales.getRowCount()-1, 0).toString())+1;
        }
            canal[0] = numeroCanal;
            canal[1] = pesoTxt1.getText();
            canal[2] = pesoTxt2.getText();
            canal[3] = pesoTxt3.getText();
            canal[4] = pesoTxt4.getText();
            canal[5] = proveedorLOV.getSelectedItem().toString();
            canal[6] = productoLov.getSelectedItem().toString();
            canal[7] = almacenLOV.getSelectedItem().toString();
        

        model.addRow(canal);
        
        canal1.setNumeroCanal(numeroCanal);
        canal1.setNumeroMatanza(new Integer (matanzaTxt.getText()));
        canal1.setEstatus("ACTIVO");
        canal1.setPeso(new BigDecimal(pesoTxt1.getText()));
        canal1.setPrecio(BigDecimal.ZERO);
        canal1.setProductosHasProveedores((ProductosHasProveedores) productoLov.getSelectedItem());
        canal1.setUbicaciones((Ubicaciones) almacenLOV.getSelectedItem());

        nuevosCanales.add(canal1);
        
        canal2.setNumeroCanal(numeroCanal);
        canal2.setNumeroMatanza(new Integer (matanzaTxt.getText()));
        canal2.setEstatus("ACTIVO");
        canal2.setPeso(new BigDecimal(pesoTxt2.getText()));
        canal2.setPrecio(BigDecimal.ZERO);
        canal2.setProductosHasProveedores((ProductosHasProveedores) productoLov.getSelectedItem());
        canal2.setUbicaciones((Ubicaciones) almacenLOV.getSelectedItem());

        nuevosCanales.add(canal2);
        
        canal3.setNumeroCanal(numeroCanal);
        canal3.setNumeroMatanza(new Integer (matanzaTxt.getText()));
        canal3.setEstatus("ACTIVO");
        canal3.setPeso(new BigDecimal(pesoTxt3.getText()));
        canal3.setPrecio(BigDecimal.ZERO);
        canal3.setProductosHasProveedores((ProductosHasProveedores) productoLov.getSelectedItem());
        canal3.setUbicaciones((Ubicaciones) almacenLOV.getSelectedItem());

        nuevosCanales.add(canal3);
        
        canal4.setNumeroCanal(numeroCanal);
        canal4.setNumeroMatanza(new Integer (matanzaTxt.getText()));
        canal4.setEstatus("ACTIVO");
        canal4.setPeso(new BigDecimal(pesoTxt4.getText()));
        canal4.setPrecio(BigDecimal.ZERO);
        canal4.setProductosHasProveedores((ProductosHasProveedores) productoLov.getSelectedItem());
        canal4.setUbicaciones((Ubicaciones) almacenLOV.getSelectedItem());

        nuevosCanales.add(canal4);
        
    }
    private void agregarResCasoEspecial() {
        int numeroCanal=0;
        
        if (pesoTxt1.getText().equals("")) {
            JOptionPane.showMessageDialog(null, "Debe capturar el peso.");
            return;
        }
        Object[] canal = new Object[5];
        ProductosInventario producto = new ProductosInventario();

        if (tablaCanales.getRowCount() == 0) {

            numeroCanal= new Integer(numeroCanalTxt.getText());
        }else {
            numeroCanal = new Integer(tablaCanales.getValueAt(tablaCanales.getRowCount()-1, 0).toString())+1;
        }
        
        
        canal[0] = numeroCanal;
        canal[1] = pesoTxt1.getText();
        canal[2] = proveedorLOV.getSelectedItem().toString();
        canal[3] = productoLov.getSelectedItem().toString();
        canal[4] = almacenLOV.getSelectedItem().toString();

        model.addRow(canal);
        
        producto.setNumeroCanal(numeroCanal);
        producto.setNumeroMatanza(new Integer (matanzaTxt.getText()));
        producto.setEstatus("ACTIVO");
        producto.setPeso(new BigDecimal(pesoTxt1.getText()));
        producto.setPrecio(BigDecimal.ZERO);
        producto.setProductosHasProveedores((ProductosHasProveedores) productoLov.getSelectedItem());
        producto.setUbicaciones((Ubicaciones) almacenLOV.getSelectedItem());

        nuevosCanales.add(producto);
    }
    private void finalizarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_finalizarBtnActionPerformed
        OrdenesCompra orden = new OrdenesCompra();
        orden.setEstatus("ACTIVO");
        orden.setFecha(new Date());
        orden.setProveedores((Proveedores) proveedorLOV.getSelectedItem());
        BigDecimal total = BigDecimal.ZERO;
        for (ProductosInventario producto : orden.getProductosInventarios()) {
            total = total.add(producto.getPrecio().multiply(producto.getPeso()));
        }
        orden.setTotal(total);
        try {
            orden.setUsuarios(usuariosDao.getUsuarios().get(0));
        } catch (Exception ex) {
            Logger.getLogger(ReciboDeProducto.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            productoDAO.recibirProductos(nuevosCanales, orden);
            nuevosCanales.clear();
            JOptionPane.showMessageDialog(null, "Se recibieron los canales correctamente");
            model.setRowCount(0);
            pesoTxt1.setText("");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Ocurrió un error al recibir los canales");
        }
    }//GEN-LAST:event_finalizarBtnActionPerformed

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
        productoLov.setModel(new DefaultComboBoxModel(this.getProductosArray()));
        productoLov.repaint();
        if(productoLov.getSelectedItem()!= null){
        modoOperacion = productoLov.getSelectedItem().toString();
        }
        limpiar();
      
    }//GEN-LAST:event_proveedorLOVActionPerformed

    private void productoTxtKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productoTxtKeyReleased
        char c = evt.getKeyChar();
       
            if (!productoTxt.getText().equals("")) {
                Productos producto = null;
                try {
                    producto = productoDAO.getProductosXDescripcionOCodigo(productoTxt.getText());
                } catch (Exception ex) {
                    JOptionPane.showMessageDialog(null, ex, "ERROR", ERROR_MESSAGE);
                    return;
                }
                if(producto==null){
                    return;
                }
                ProductosHasProveedores prodProv = new ProductosHasProveedores();
                prodProv.setProveedores((Proveedores) proveedorLOV.getSelectedItem());
                prodProv.setProductos(producto);
                productoLov.setSelectedItem(prodProv);
                productoLov.repaint();
            }
        
    }//GEN-LAST:event_productoTxtKeyReleased

    private void productoTxtKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productoTxtKeyTyped
        
    }//GEN-LAST:event_productoTxtKeyTyped

    private void proveedorTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_proveedorTxtActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_proveedorTxtActionPerformed

    private void productoLovActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_productoLovActionPerformed
        // TODO add your handling code here:
        modoOperacion = ((ProductosHasProveedores)this.productoLov.getSelectedItem()).getProductos().getTipoProducto().getDescripcion();
        if(!productoAnterior.getProductos().getTipoProducto().getDescripcion().equals(modoOperacion)){
            limpiar();
        }
        
    }//GEN-LAST:event_productoLovActionPerformed

    private void pesoTxt2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_pesoTxt2ActionPerformed
        // TODO add your handling code here:
        if (modoOperacion.equals("CANAL DE EQUINO")){
            agregarCanalEquino();
            pesoTxt1.setText("");
            pesoTxt2.setText("");
            pesoTxt1.requestFocus();
            
        }   else {
            pesoTxt3.requestFocus();
        }  
    }//GEN-LAST:event_pesoTxt2ActionPerformed

    private void pesoTxt1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_pesoTxt1ActionPerformed
        // TODO add your handling code here:
        if(modoOperacion.equals("RES CASO ESPECIAL")){
            agregarResCasoEspecial();
            pesoTxt1.setText("");
        }else {
            pesoTxt2.requestFocus();
        }
    }//GEN-LAST:event_pesoTxt1ActionPerformed

    private void pesoTxt3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_pesoTxt3ActionPerformed
        // TODO add your handling code here:
        pesoTxt4.requestFocus();
        
    }//GEN-LAST:event_pesoTxt3ActionPerformed

    private void pesoTxt4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_pesoTxt4ActionPerformed
        // TODO add your handling code here:
            agregarCanalRes();
            pesoTxt1.setText("");
            pesoTxt2.setText("");
            pesoTxt3.setText("");
            pesoTxt4.setText("");
            pesoTxt1.requestFocus();
        
    }//GEN-LAST:event_pesoTxt4ActionPerformed

    private void productoTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_productoTxtActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_productoTxtActionPerformed

    private void productoLovItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_productoLovItemStateChanged
        // TODO add your handling code here:
        if(evt.getStateChange()== ItemEvent.DESELECTED){
            productoAnterior = (ProductosHasProveedores) evt.getItem();
        }
    }//GEN-LAST:event_productoLovItemStateChanged


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton agregarBtn;
    private javax.swing.JComboBox almacenLOV;
    private javax.swing.JButton finalizarBtn;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JButton limpiarBtn;
    private javax.swing.JTextField matanzaTxt;
    private javax.swing.JTextField numeroCanalTxt;
    private javax.swing.JTextField pesoTxt1;
    private javax.swing.JTextField pesoTxt2;
    private javax.swing.JTextField pesoTxt3;
    private javax.swing.JTextField pesoTxt4;
    private javax.swing.JComboBox productoLov;
    private javax.swing.JTextField productoTxt;
    private javax.swing.JComboBox proveedorLOV;
    private javax.swing.JTextField proveedorTxt;
    private javax.swing.JTable tablaCanales;
    // End of variables declaration//GEN-END:variables
}
