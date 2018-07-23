/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package panels;

import components.CustomDropDown;
import dao.ProductoDAO;
import dao.ProveedoresDAO;
import dao.ProveedoresKiloDAO;
import dao.RepartidoresDAO;
import java.awt.Component;
import java.awt.ComponentOrientation;
import java.awt.KeyboardFocusManager;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.swing.AbstractButton;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.table.DefaultTableModel;
import keydispatchers.BarCodeScannerKeyDispatcher;
import listeners.NumericKeyListener;
import mapping.Mermas;
import mapping.Procesos;
import mapping.Productos;
import mapping.ProductosDelInventario;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import mapping.Repartidores;
import pesable.PesableBarCodeable;
import table.custom.NoEditableTableModel;
import threads.PesoThread;
import utilities.UsuarioFirmado;

/**
 *
 * @author Administrador
 */
public class AsignacionProductoRepartidor extends PesableBarCodeable {

    ProductoDAO productoDAO = new ProductoDAO();
    ProveedoresDAO proveedoresDao = new ProveedoresKiloDAO();
    DefaultTableModel modelProductos = new NoEditableTableModel();
    private RepartidoresDAO repartidoresDao = new RepartidoresDAO();
    List<Repartidores> repartidores = new ArrayList<>();
    List<ProductosInventario> productos = new ArrayList<>();
    public List<Component> exceptions = new ArrayList<>();
    private String modoOperacion;
    private CustomDropDown proveedoresDropDown = new CustomDropDown();

    /**
     * Creates new form AsignacionProductoRepartidor
     */
    public AsignacionProductoRepartidor() {
        initComponents();
        this.modoOperacion = "SALIDA";
        proveedoresDropDown.setDao(proveedoresDao);
        proveedoresDropDown.setEtiqueta("Proveedor");
        proveedoresDropDown.init();
        panelProveedor.add(proveedoresDropDown);
        proveedoresDropDown.setBounds(10, 20, 500, 65);
        proveedoresDropDown.disable();
        setManager(KeyboardFocusManager.getCurrentKeyboardFocusManager());
        exceptions.add(pesoManualLbl);
        exceptions.add(repartidorTxt);
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
            //return;
        }
        if(getPesoThread() != null){
            getPesoThread().setPesoLbl(pesoBasculaLbl);
            Thread thread = new Thread(getPesoThread());
            thread.start();
        }
    }

    public AsignacionProductoRepartidor(String modoOperacion) {
        initComponents();
        this.modoOperacion = modoOperacion;
        jLabel2.setVisible(false);
        repartidorTxt.setVisible(false);
        repartidoresLov.setVisible(false);
        PanelRepartidor.setVisible(false);
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

        buttonGroup1 = new javax.swing.ButtonGroup();
        Pesaje = new javax.swing.JPanel();
        jSplitPane2 = new javax.swing.JSplitPane();
        jPanel4 = new javax.swing.JPanel();
        jSplitPane1 = new javax.swing.JSplitPane();
        jPanel1 = new javax.swing.JPanel();
        eliminarCajaBtn = new javax.swing.JButton();
        jPanel2 = new javax.swing.JPanel();
        jScrollPane4 = new javax.swing.JScrollPane();
        tablaProductos1 = new javax.swing.JTable();
        String[] columnNames = {
            "Nombre",
            "Peso",
            "Codigo de Barras",
            "Estatus"};

        modelProductos.setColumnIdentifiers(columnNames);
        jScrollPane2 = new javax.swing.JScrollPane();
        jPanel3 = new javax.swing.JPanel();
        PanelRepartidor = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        repartidoresLov = new javax.swing.JComboBox();
        repartidorTxt = new javax.swing.JTextField();
        PanelCodigoBarras = new javax.swing.JPanel();
        jLabel3 = new javax.swing.JLabel();
        barCodeTxt = new javax.swing.JTextField();
        PanelPeso = new javax.swing.JPanel();
        pesoBasculaLbl = new javax.swing.JLabel();
        pesoManualLbl = new javax.swing.JTextField();
        pesoManualChk = new javax.swing.JCheckBox();
        jLabel9 = new javax.swing.JLabel();
        productoLbl = new javax.swing.JLabel();
        productosLov = new javax.swing.JComboBox();
        jScrollPane3 = new javax.swing.JScrollPane();
        productoCodigoArea = new javax.swing.JTextArea();
        imprimirEtiquetaBtn = new javax.swing.JButton();
        imprimirEtiquetaBtn.setMnemonic(KeyEvent.VK_ENTER);
        PanelFinalizar = new javax.swing.JPanel();
        finalizarBtn = new javax.swing.JButton();
        jPanel5 = new javax.swing.JPanel();
        yesRadio = new javax.swing.JRadioButton();
        noRadio = new javax.swing.JRadioButton();
        panelProveedor = new javax.swing.JPanel();

        setPreferredSize(new java.awt.Dimension(200, 455));
        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        Pesaje.setPreferredSize(new java.awt.Dimension(1558, 455));
        Pesaje.setLayout(new javax.swing.BoxLayout(Pesaje, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane2.setDividerLocation(651);
        jSplitPane2.setMinimumSize(new java.awt.Dimension(30, 25));

        jPanel4.setPreferredSize(new java.awt.Dimension(922, 425));
        jPanel4.setLayout(new javax.swing.BoxLayout(jPanel4, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane1.setDividerLocation(55);
        jSplitPane1.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);

        eliminarCajaBtn.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        eliminarCajaBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/button_cancel-48.png"))); // NOI18N
        eliminarCajaBtn.setText("Eliminar");
        eliminarCajaBtn.setToolTipText("");
        eliminarCajaBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                eliminarCajaBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(300, 300, 300)
                .addComponent(eliminarCajaBtn)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(eliminarCajaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jSplitPane1.setTopComponent(jPanel1);

        jPanel2.setLayout(new javax.swing.BoxLayout(jPanel2, javax.swing.BoxLayout.LINE_AXIS));

        tablaProductos1.getTableHeader().add(eliminarCajaBtn);
        tablaProductos1.setModel(modelProductos);
        tablaProductos1.getColumnModel().getColumn(1).setMaxWidth(60);
        tablaProductos1.getColumnModel().getColumn(2).setMaxWidth(200);
        tablaProductos1.getColumnModel().getColumn(3).setMaxWidth(200);
        tablaProductos1.getColumnModel().getColumn(2).setMinWidth(200);
        tablaProductos1.getColumnModel().getColumn(3).setMinWidth(200);
        tablaProductos1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mousePressed(java.awt.event.MouseEvent evt) {
                tablaProductos1MousePressed(evt);
            }
        });
        jScrollPane4.setViewportView(tablaProductos1);

        jPanel2.add(jScrollPane4);

        jSplitPane1.setRightComponent(jPanel2);

        jPanel4.add(jSplitPane1);

        jSplitPane2.setRightComponent(jPanel4);

        jScrollPane2.setMinimumSize(new java.awt.Dimension(631, 655));

        jPanel3.setMinimumSize(new java.awt.Dimension(629, 653));
        jPanel3.setPreferredSize(new java.awt.Dimension(629, 653));

        PanelRepartidor.setBorder(javax.swing.BorderFactory.createTitledBorder("Selecione el Repartidor"));

        jLabel2.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        jLabel2.setText("Repartidor:");

        repartidoresLov.setModel(new DefaultComboBoxModel(getRepartidoes()));
        repartidoresLov.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                repartidoresLovItemStateChanged(evt);
            }
        });

        repartidorTxt.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                repartidorTxtKeyReleased(evt);
            }
        });

        javax.swing.GroupLayout PanelRepartidorLayout = new javax.swing.GroupLayout(PanelRepartidor);
        PanelRepartidor.setLayout(PanelRepartidorLayout);
        PanelRepartidorLayout.setHorizontalGroup(
            PanelRepartidorLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, PanelRepartidorLayout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 94, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(repartidorTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 235, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(repartidoresLov, javax.swing.GroupLayout.PREFERRED_SIZE, 207, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        PanelRepartidorLayout.setVerticalGroup(
            PanelRepartidorLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanelRepartidorLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(PanelRepartidorLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(repartidoresLov, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(PanelRepartidorLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(repartidorTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        PanelCodigoBarras.setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createTitledBorder(""), "Ingrese el Codigo de Barras"));
        PanelCodigoBarras.setMinimumSize(new java.awt.Dimension(610, 78));
        PanelCodigoBarras.setName(""); // NOI18N
        PanelCodigoBarras.setPreferredSize(new java.awt.Dimension(584, 78));

        jLabel3.setText("Codigo de Barras");

        barCodeTxt.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                barCodeTxtActionPerformed(evt);
            }
        });
        barCodeTxt.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                barCodeTxtKeyReleased(evt);
            }
            public void keyTyped(java.awt.event.KeyEvent evt) {
                barCodeTxtKeyTyped(evt);
            }
        });

        javax.swing.GroupLayout PanelCodigoBarrasLayout = new javax.swing.GroupLayout(PanelCodigoBarras);
        PanelCodigoBarras.setLayout(PanelCodigoBarrasLayout);
        PanelCodigoBarrasLayout.setHorizontalGroup(
            PanelCodigoBarrasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanelCodigoBarrasLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 97, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(barCodeTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 240, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        PanelCodigoBarrasLayout.setVerticalGroup(
            PanelCodigoBarrasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanelCodigoBarrasLayout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addGroup(PanelCodigoBarrasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(barCodeTxt))
                .addContainerGap(27, Short.MAX_VALUE))
        );

        PanelPeso.setBorder(javax.swing.BorderFactory.createTitledBorder("Ó Seleccione y pese un producto"));
        PanelPeso.setPreferredSize(new java.awt.Dimension(584, 343));

        pesoBasculaLbl.setBackground(new java.awt.Color(0, 0, 0));
        pesoBasculaLbl.setFont(new java.awt.Font("Tahoma", 0, 48)); // NOI18N
        pesoBasculaLbl.setForeground(new java.awt.Color(0, 255, 0));
        pesoBasculaLbl.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        pesoBasculaLbl.setText("XXX.XX");
        pesoBasculaLbl.setOpaque(true);

        pesoManualLbl.setBackground(new java.awt.Color(0, 0, 0));
        pesoManualLbl.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        pesoManualLbl.setForeground(new java.awt.Color(0, 204, 51));
        pesoManualLbl.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        pesoManualLbl.addKeyListener(new NumericKeyListener());
        pesoManualLbl.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                pesoManualLblActionPerformed(evt);
            }
        });

        pesoManualChk.setText("Pesaje Manual");
        pesoManualChk.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                pesoManualChkActionPerformed(evt);
            }
        });

        jLabel9.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel9.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        jLabel9.setText("Producto:");

        productoLbl.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N

        productosLov.setModel(new DefaultComboBoxModel(getProducts()));
        productosLov.getSelectedItem().toString();
        productosLov.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                productosLovActionPerformed(evt);
            }
        });

        jScrollPane3.setHorizontalScrollBar(null);

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
        jScrollPane3.setViewportView(productoCodigoArea);

        imprimirEtiquetaBtn.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        imprimirEtiquetaBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/Print-48.png"))); // NOI18N
        imprimirEtiquetaBtn.setText("Agregar");
        imprimirEtiquetaBtn.setToolTipText("");
        imprimirEtiquetaBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                imprimirEtiquetaBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout PanelPesoLayout = new javax.swing.GroupLayout(PanelPeso);
        PanelPeso.setLayout(PanelPesoLayout);
        PanelPesoLayout.setHorizontalGroup(
            PanelPesoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanelPesoLayout.createSequentialGroup()
                .addGroup(PanelPesoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(PanelPesoLayout.createSequentialGroup()
                        .addGap(2, 2, 2)
                        .addComponent(pesoBasculaLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGap(18, 18, 18)
                        .addGroup(PanelPesoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jScrollPane3, javax.swing.GroupLayout.PREFERRED_SIZE, 174, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(productosLov, javax.swing.GroupLayout.PREFERRED_SIZE, 174, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addComponent(imprimirEtiquetaBtn))
                    .addGroup(PanelPesoLayout.createSequentialGroup()
                        .addComponent(pesoManualLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 219, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(PanelPesoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(pesoManualChk)
                            .addGroup(PanelPesoLayout.createSequentialGroup()
                                .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 80, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(productoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 253, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                .addContainerGap())
        );
        PanelPesoLayout.setVerticalGroup(
            PanelPesoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanelPesoLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(PanelPesoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(PanelPesoLayout.createSequentialGroup()
                        .addComponent(imprimirEtiquetaBtn)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(pesoManualChk)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(PanelPesoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(productoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(165, 165, 165))
                    .addGroup(PanelPesoLayout.createSequentialGroup()
                        .addGroup(PanelPesoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(PanelPesoLayout.createSequentialGroup()
                                .addComponent(jScrollPane3, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(productosLov))
                            .addComponent(pesoBasculaLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(pesoManualLbl, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(172, 172, 172))))
        );

        PanelFinalizar.setBorder(javax.swing.BorderFactory.createTitledBorder("Finalizar"));

        finalizarBtn.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        finalizarBtn.setText("Finalizar");
        finalizarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                finalizarBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout PanelFinalizarLayout = new javax.swing.GroupLayout(PanelFinalizar);
        PanelFinalizar.setLayout(PanelFinalizarLayout);
        PanelFinalizarLayout.setHorizontalGroup(
            PanelFinalizarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanelFinalizarLayout.createSequentialGroup()
                .addGap(230, 230, 230)
                .addComponent(finalizarBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 130, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        PanelFinalizarLayout.setVerticalGroup(
            PanelFinalizarLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanelFinalizarLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(finalizarBtn)
                .addContainerGap(14, Short.MAX_VALUE))
        );

        jPanel5.setBorder(javax.swing.BorderFactory.createTitledBorder("¿El producto ya existe en el inventario?"));

        buttonGroup1.add(yesRadio);
        yesRadio.setSelected(true);
        yesRadio.setText("Si");
        yesRadio.setName("yes"); // NOI18N
        yesRadio.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                yesRadioActionPerformed(evt);
            }
        });

        buttonGroup1.add(noRadio);
        noRadio.setText("No");
        noRadio.setName("no"); // NOI18N
        noRadio.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                noRadioActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addComponent(yesRadio)
                .addGap(41, 41, 41)
                .addComponent(noRadio)
                .addGap(0, 0, Short.MAX_VALUE))
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(yesRadio)
                    .addComponent(noRadio))
                .addContainerGap(13, Short.MAX_VALUE))
        );

        panelProveedor.setBorder(javax.swing.BorderFactory.createTitledBorder("Seleccione un proveedor"));
        panelProveedor.setEnabled(false);
        panelProveedor.setName("panelProveedor"); // NOI18N
        panelProveedor.setPreferredSize(new java.awt.Dimension(612, 130));

        javax.swing.GroupLayout panelProveedorLayout = new javax.swing.GroupLayout(panelProveedor);
        panelProveedor.setLayout(panelProveedorLayout);
        panelProveedorLayout.setHorizontalGroup(
            panelProveedorLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 600, Short.MAX_VALUE)
        );
        panelProveedorLayout.setVerticalGroup(
            panelProveedorLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 70, Short.MAX_VALUE)
        );

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(PanelPeso, javax.swing.GroupLayout.DEFAULT_SIZE, 612, Short.MAX_VALUE)
                    .addComponent(PanelFinalizar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(PanelCodigoBarras, javax.swing.GroupLayout.DEFAULT_SIZE, 612, Short.MAX_VALUE)
                    .addComponent(PanelRepartidor, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel5, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addComponent(panelProveedor, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(panelProveedor, javax.swing.GroupLayout.PREFERRED_SIZE, 93, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(PanelRepartidor, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(PanelCodigoBarras, javax.swing.GroupLayout.PREFERRED_SIZE, 90, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(PanelPeso, javax.swing.GroupLayout.PREFERRED_SIZE, 205, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(PanelFinalizar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(56, 56, 56))
        );

        jScrollPane2.setViewportView(jPanel3);

        jSplitPane2.setLeftComponent(jScrollPane2);

        Pesaje.add(jSplitPane2);

        add(Pesaje);
    }// </editor-fold>//GEN-END:initComponents

    private void tablaProductos1MousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tablaProductos1MousePressed
        // TODO add your handling code here:
    }//GEN-LAST:event_tablaProductos1MousePressed

    private boolean isProductoRepetido(DefaultTableModel model, ProductosInventario producto) {
        for (int count = 0; count < model.getRowCount(); count++) {
            if (producto.equals((ProductosInventario) model.getValueAt(count, 0))) {
                return true;
            }
        }
        return false;

    }

    public void agregarProductoDeBascula() {
        ProductosInventario productoNuevo = new ProductosInventario();
        String peso = "";
        if (pesoManualChk.isSelected()) {
            peso = pesoManualLbl.getText();
        } else {
            peso = pesoBasculaLbl.getText();
        }
        
        if(noRadio.isSelected()){
            ProductosInventario productoInventario = new ProductosInventario();
        productoInventario.setProductosHasProveedores((ProductosHasProveedores) productosLov.getSelectedItem());
        productoInventario.setUbicaciones(UsuarioFirmado.getUsuarioFirmado().getUbicaciones());
        productoInventario.setPeso(new BigDecimal(peso));
        productoInventario.setPrecio(BigDecimal.ZERO);
        productoInventario.setEstatus("ACTIVO");
        productoInventario.setCodigoBarras(getCodigoBarras(peso));
        productoInventario.setFechaCreacion(new Date());
        productoInventario.setReetiquetado(false);
        try {
            productoDAO.insertarProducto(productoInventario);
            imprimirCodigo(productoInventario);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex, "Errot", ERROR_MESSAGE);
        }
        setTableModel();
        }

        try {
            if (modoOperacion.equals("ENTRADA")) {
                productoNuevo = productoDAO.getProductoPesadoTransito(peso, ((ProductosHasProveedores) productosLov.getSelectedItem()).getProductos(), modelProductos);
            } else {
                productoNuevo = productoDAO.getProductoPesadoActivo(peso, ((ProductosHasProveedores) productosLov.getSelectedItem()).getProductos(), modelProductos);
            }

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return;
        }
        if (productoNuevo == null) {
            return;
        }
        if (isProductoRepetido(modelProductos, productoNuevo)) {
            return;
        }
        productos.add(productoNuevo);
        setTableModel();
    }
    
    private String getCodigoBarras(String peso) {
        return "N"
                + new SimpleDateFormat("yyddMM").format(new Date())
                + String.format("%05d", ((ProductosHasProveedores) this.productosLov.getSelectedItem()).getProductos().getCodigo())
                + String.format("%06d", Integer.parseInt(peso.replaceAll("\\.", "")))
                + String.format("%09d", 999999999);
    }

    private void barCodeTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_barCodeTxtActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_barCodeTxtActionPerformed

    private void imprimirCodigo(ProductosInventario producto) {
        // aca obtenemos la printer default  

        String label = "";
        try (BufferedReader br = new BufferedReader(new FileReader("C:\\valco\\CodigoBarras.txt"))){
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
        label = label.replace("PRODUCTO", this.productosLov.getSelectedItem().toString());
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
    
    private void barCodeTxtKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_barCodeTxtKeyTyped
        if (evt.getKeyChar() == KeyEvent.VK_ENTER) {
            if(noRadio.isSelected()){
                armarProductoConCodigo();
            }else{
                changeScanned(barCodeTxt.getText());
            }
        }
    }//GEN-LAST:event_barCodeTxtKeyTyped

    private Proveedores getProveedorSeleccionado() {
        return (Proveedores) proveedoresDropDown.getSelectedItem();
    }
    
    private void armarProductoConCodigo(){
       int barCodeSize = 0;
        
        if(barCodeTxt.getText().length() < getProveedorSeleccionado().getPosicionCodigoFinal()){
            return;
        }

        ProductosHasProveedores productoHasProveedores = null;
        barCodeSize= barCodeTxt.getText().length();
        if(barCodeSize< getProveedorSeleccionado().getPosicionCodigoInicial() || 
                barCodeSize< getProveedorSeleccionado().getPosicionCodigoFinal() ||
                barCodeSize < getProveedorSeleccionado().getPosicionPesoInicial() ||
                barCodeSize< getProveedorSeleccionado().getPosicionPesoFinal()){
            return;
        }

        String codigoProducto
                = barCodeTxt.getText().substring(getProveedorSeleccionado().getPosicionCodigoInicial(),
                        getProveedorSeleccionado().getPosicionCodigoFinal());
        String peso
                = barCodeTxt.getText().substring(getProveedorSeleccionado().getPosicionPesoInicial(),
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
            productoNuevo.setCodigoBarras(barCodeTxt.getText());
            productoNuevo.setProductosHasProveedores(productoHasProveedores);
            productoNuevo.setCosto(productoHasProveedores.getPrecioSugerido());
            productoNuevo.setPrecio(productoHasProveedores.getProductos().getPrecioSugerido());
            productoNuevo.setUbicaciones(UsuarioFirmado.getUsuarioFirmado().getUbicaciones());
            productoNuevo.setEstatus("ACTIVO");
            productos.add(productoNuevo);
            barCodeTxt.setText("");
            setTableModel();
        } 
    }
    
    private void repartidorTxtKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_repartidorTxtKeyReleased
        char c = evt.getKeyChar();

        if (!repartidorTxt.getText().equals("")) {
            Repartidores repartidor = new Repartidores();
            Productos producto = new Productos();
            try {
                repartidor = repartidoresDao.getRepartidorXDescripcionOCodigo(repartidorTxt.getText());
            } catch (Exception ex) {
                Logger.getLogger(AsignacionProductoRepartidor.class.getName()).log(Level.SEVERE, null, ex);
            }

            repartidoresLov.setSelectedItem(repartidor);

        }
    }//GEN-LAST:event_repartidorTxtKeyReleased

    private void barCodeTxtKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_barCodeTxtKeyReleased

    }//GEN-LAST:event_barCodeTxtKeyReleased

    private void finalizarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_finalizarBtnActionPerformed
        if (productos == null || productos.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Debe seleccionar algún producto");
            return;
        }
        if (modoOperacion.equals("ENTRADA")) {
            for (ProductosInventario producto : productos) {
                producto.setEstatus("ACTIVO");
                producto.setRepartidores(null);
            }

            try {
                productoDAO.actualizarProductosInventario(productos);
                JOptionPane.showMessageDialog(null, "El product se asignó al repartidor correctamente");
                limpiar();
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex);
            }
            return;
        }
        if (repartidoresLov.getSelectedItem() == null) {
            JOptionPane.showMessageDialog(null, "Debe seleccionar un repartidor");
            return;
        }
        for (ProductosInventario producto : productos) {
            producto.setEstatus("EN TRANSITO");
            producto.setRepartidores((Repartidores) repartidoresLov.getSelectedItem());
        }

        try {
            productoDAO.actualizarProductosInventario(productos);
            JOptionPane.showMessageDialog(null, "El product se asignó al repartidor correctamente");
            limpiar();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
    }//GEN-LAST:event_finalizarBtnActionPerformed

    private void imprimirEtiquetaBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_imprimirEtiquetaBtnActionPerformed
        agregarProductoDeBascula();
    }//GEN-LAST:event_imprimirEtiquetaBtnActionPerformed

    private void eliminarCajaBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_eliminarCajaBtnActionPerformed
        int[] selectedRows = tablaProductos1.getSelectedRows();
        List<ProductosInventario> productosSeleccionados = new ArrayList<>();
        if (selectedRows.length > 0) {
            for (int i = selectedRows.length - 1; i >= 0; i--) {
                ProductosInventario productoSeleccionado = (ProductosInventario) modelProductos.getValueAt(selectedRows[i], 0);
                productos.remove(productoSeleccionado);
            }
            try {
                //inventarioDao.actualizarProductosInventario(productosSeleccionados);
                //JOptionPane.showMessageDialog(null, "Las cajas se cancelaron correctamente");
                setTableModel();
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex, "Error", ERROR_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(null, "No hay ningúna caja seleccionada.");
        }
    }//GEN-LAST:event_eliminarCajaBtnActionPerformed

    private void productoCodigoAreaKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productoCodigoAreaKeyTyped

    }//GEN-LAST:event_productoCodigoAreaKeyTyped

    private void productoCodigoAreaKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productoCodigoAreaKeyReleased
        char c = evt.getKeyChar();

        if (!productoCodigoArea.getText().equals("")) {
            ProductosHasProveedores productoProveedor = new ProductosHasProveedores();
            Productos producto = new Productos();
            try {
                producto = productoDAO.getProductosXDescripcionOCodigo(productoCodigoArea.getText());
            } catch (Exception ex) {
                Logger.getLogger(AsignacionProductoRepartidor.class.getName()).log(Level.SEVERE, null, ex);
            }
            productoProveedor.setProductos(producto);
            Proveedores prov = new Proveedores();
            prov.setCodigo(1);
            productoProveedor.setProveedores(prov);
            productosLov.setSelectedItem(productoProveedor);
            productosLov.repaint();
        }
    }//GEN-LAST:event_productoCodigoAreaKeyReleased

    private void productosLovActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_productosLovActionPerformed
        productoLbl.setText(productosLov.getSelectedItem().toString());
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

    private void pesoManualLblActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_pesoManualLblActionPerformed
        agregarProductoDeBascula();
    }//GEN-LAST:event_pesoManualLblActionPerformed

    private void noRadioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_noRadioActionPerformed
        panelProveedor.setEnabled(true);
        proveedoresDropDown.enable();
    }//GEN-LAST:event_noRadioActionPerformed

    private void yesRadioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_yesRadioActionPerformed
        panelProveedor.setEnabled(false);
        proveedoresDropDown.disable();
        productosLov.setModel(new DefaultComboBoxModel(getProducts()));
    }//GEN-LAST:event_yesRadioActionPerformed

    private void repartidoresLovItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_repartidoresLovItemStateChanged
        Proveedores proveedorSeleccionado = (Proveedores) proveedoresDropDown.getSelectedItem();
        productosLov.setModel(new DefaultComboBoxModel(proveedorSeleccionado.getProductosHasProveedoreses().toArray()));
    }//GEN-LAST:event_repartidoresLovItemStateChanged

    public void limpiar() {
        modelProductos.setRowCount(0);
        productos.clear();
    }

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

    private Object[] getRepartidoes() {
        Object[] repatidoressArray = new Object[0];
        try {
            repatidoressArray = repartidoresDao.getRepartidores().toArray();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error", ERROR_MESSAGE);
        }
        return repatidoressArray;
    }

    private void changeScanned(String barCode) {
        ProductosInventario producto = null;
        Integer[] codigos = new Integer[productos.size()];
        try {
            int x = 0;
            for (ProductosInventario productoInv : productos) {
                codigos[x] = productoInv.getCodigo();
                x++;
            }
            if (modoOperacion.equals("ENTRADA")) {
                producto = productoDAO.getProductosXCodigoBarrasTransito(barCode, codigos);
            } else {
                producto = productoDAO.getProductosXCodigoBarrasActivos(barCode, codigos);
            }

        } catch (Exception ex) {
            //JOptionPane.showMessageDialog(null, ex);
            barCodeTxt.setText("");
            System.out.println(ex.getMessage());
            return;
        }
        if (producto == null) {
            //JOptionPane.showMessageDialog(null, "No se encontro el codigo de barras");
            barCodeTxt.setText("");
            return;
        } else {

            try {
                if (isProductoRepetido(modelProductos, producto)) {
                    barCodeTxt.setText("");
                    return;
                }
                productos.add(producto);
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex);
                barCodeTxt.setText("");
                return;
            }
            this.setTableModel();
            barCodeTxt.setText("");

        }
    }

    private void setTableModel() {
        int rowCount = modelProductos.getRowCount();
        //Remove rows one by one from the end of the table
        for (int i = rowCount - 1; i >= 0; i--) {
            modelProductos.removeRow(i);
        }

        for (ProductosInventario producto : productos) {
            Object[] row = new Object[5];
            row[0] = producto;
            row[1] = producto.getPeso();
            row[2] = producto.getCodigoBarras();
            row[3] = producto.getEstatus();
            modelProductos.addRow(row);
        }
    }
    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JPanel PanelCodigoBarras;
    private javax.swing.JPanel PanelFinalizar;
    private javax.swing.JPanel PanelPeso;
    private javax.swing.JPanel PanelRepartidor;
    private javax.swing.JPanel Pesaje;
    private javax.swing.JTextField barCodeTxt;
    private javax.swing.ButtonGroup buttonGroup1;
    private javax.swing.JButton eliminarCajaBtn;
    private javax.swing.JButton finalizarBtn;
    public javax.swing.JButton imprimirEtiquetaBtn;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JScrollPane jScrollPane4;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JSplitPane jSplitPane2;
    private javax.swing.JRadioButton noRadio;
    private javax.swing.JPanel panelProveedor;
    private javax.swing.JLabel pesoBasculaLbl;
    private javax.swing.JCheckBox pesoManualChk;
    private javax.swing.JTextField pesoManualLbl;
    private javax.swing.JTextArea productoCodigoArea;
    private javax.swing.JLabel productoLbl;
    private javax.swing.JComboBox productosLov;
    private javax.swing.JTextField repartidorTxt;
    private javax.swing.JComboBox repartidoresLov;
    private javax.swing.JTable tablaProductos1;
    private javax.swing.JRadioButton yesRadio;
    // End of variables declaration//GEN-END:variables
}
