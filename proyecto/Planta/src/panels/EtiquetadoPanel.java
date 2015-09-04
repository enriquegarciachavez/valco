package panels;

import creators.PanelCreator;
import dao.ProcesosDAO;
import dao.ProductoDAO;
import java.awt.ComponentOrientation;
import java.awt.KeyEventDispatcher;
import java.awt.KeyboardFocusManager;
import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.swing.AbstractAction;
import javax.swing.AbstractButton;
import javax.swing.Action;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JDesktopPane;
import javax.swing.JInternalFrame;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.JPanel;
import javax.swing.KeyStroke;
import javax.swing.SwingConstants;
import javax.swing.table.DefaultTableModel;
import listeners.NumericKeyListener;
import mapping.Procesos;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import mapping.Ubicaciones;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.view.JasperViewer;
import table.custom.EtiquetadoTableCellRendered;
import table.custom.NoEditableTableModel;
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
public class EtiquetadoPanel extends CoustomPanel {

    String path = "src/Reportes/Lote_Final.jrxml";
    ProcesosDAO procesosDAO = new ProcesosDAO();
    ProductoDAO productoDAO = new ProductoDAO();
    DefaultTableModel model = new NoEditableTableModel();
    String formato = "##.##";
    JInternalFrame internalFrame;
    Action action = new AbstractAction("doSomething") {

        @Override
        public void actionPerformed(ActionEvent e) {
            System.out.println("triggered the action");
        }

    };

    /**
     * Creates new form EtiquetadoPanel
     */
    public EtiquetadoPanel(JDesktopPane mainPanel) {
        this.mainPanel= mainPanel;
        initComponents();
        action.putValue(Action.ACCELERATOR_KEY, KeyStroke.getKeyStroke("control S"));
        tablaProductos.setDefaultRenderer(Object.class, new EtiquetadoTableCellRendered());
        this.setTableModel();
        try {
            consecutivoLbl.setText(procesosDAO.getConsecutivo(((Procesos) procesosLov.getSelectedItem()).getCodigo()).toString());
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
        KeyboardFocusManager.getCurrentKeyboardFocusManager()
                .addKeyEventDispatcher(new KeyEventDispatcher() {
                    @Override
                    public boolean dispatchKeyEvent(KeyEvent e) {
                        System.out.println("Got key event!");
                        return false;
                    }
                });
        pesoThread.setPesoLbl(pesoBasculaLbl);
        Thread thread = new Thread(pesoThread);
        thread.start();

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

    private Object[] getProcesosActivosArray() {
        Object[] procesosActivosArray = new Object[0];
        try {
            procesosActivosArray = procesosDAO.getProcesosActivos().toArray();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error", ERROR_MESSAGE);
        }
        return procesosActivosArray;
    }

    private Object[] getProcesosActivosEInactivosArray() {
        Object[] procesosActivosEInactivosArray = new Object[0];
        try {
            procesosActivosEInactivosArray = procesosDAO.getProcesosActivosEInactivos().toArray();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error", ERROR_MESSAGE);
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

        reporteGroup = new javax.swing.ButtonGroup();
        jTabbedPane1 = new javax.swing.JTabbedPane();
        jPanel3 = new javax.swing.JPanel();
        jSplitPane1 = new javax.swing.JSplitPane();
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
        imprimirEtiquetaBtn = new javax.swing.JButton();
        imprimirEtiquetaBtn.setMnemonic(KeyEvent.VK_ENTER);
        jLabel9 = new javax.swing.JLabel();
        productoLbl = new javax.swing.JLabel();
        eliminarCajaBtn = new javax.swing.JButton();
        jLabel11 = new javax.swing.JLabel();
        jLabel12 = new javax.swing.JLabel();
        jLabel13 = new javax.swing.JLabel();
        consecutivoLbl = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        procesoLbl = new javax.swing.JLabel();
        pesoManualLbl = new javax.swing.JTextField();
        jPanel2 = new javax.swing.JPanel();
        jScrollPane3 = new javax.swing.JScrollPane();
        tablaProductos = new javax.swing.JTable();
        String[] columnNames = {
            "Nombre",
            "Peso",
            "Etiqueta",
            "Consecutivo",
            "Estatus"};

        model.setColumnIdentifiers(columnNames);
        jPanel4 = new javax.swing.JPanel();
        jLabel3 = new javax.swing.JLabel();
        procesoLbl1 = new javax.swing.JLabel();
        jPanel5 = new javax.swing.JPanel();
        jLabel5 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        jLabel10 = new javax.swing.JLabel();
        jLabel14 = new javax.swing.JLabel();
        jLabel15 = new javax.swing.JLabel();
        masTxt = new javax.swing.JTextField();
        manoDeObraTxt = new javax.swing.JTextField();
        costoIndirectoTxt = new javax.swing.JTextField();
        costoInicialLbl = new javax.swing.JLabel();
        totalLbl = new javax.swing.JLabel();
        guardarCostoBtn = new javax.swing.JButton();
        agregarCostoBtn = new javax.swing.JButton();
        jPanel6 = new javax.swing.JPanel();
        P = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();
        pesoFinalLbl = new javax.swing.JLabel();
        agregarPesoInicialBtn = new javax.swing.JButton();
        pesoInicialLbl = new javax.swing.JLabel();
        jPanel7 = new javax.swing.JPanel();
        condensadoRadio = new javax.swing.JRadioButton();
        detalladoRadio = new javax.swing.JRadioButton();
        reporteBtn = new javax.swing.JButton();
        jPanel8 = new javax.swing.JPanel();
        jLabel16 = new javax.swing.JLabel();
        jLabel17 = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        pesoHuesoLbl = new javax.swing.JLabel();
        pesoSeboLbl = new javax.swing.JLabel();
        pesoAcerrinLbl = new javax.swing.JLabel();
        cerrarProcesoBtn = new javax.swing.JButton();
        reporteFinalBtn = new javax.swing.JButton();

        addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                formKeyPressed(evt);
            }
        });
        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        jPanel3.setLayout(new javax.swing.BoxLayout(jPanel3, javax.swing.BoxLayout.LINE_AXIS));

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

        productoLbl.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        productoLbl.setText(productosLov.getSelectedItem().toString());

        eliminarCajaBtn.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        eliminarCajaBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/button_cancel-48.png"))); // NOI18N
        eliminarCajaBtn.setText("<html><center>Eliminar<br>Caja<html>");
        eliminarCajaBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                eliminarCajaBtnActionPerformed(evt);
            }
        });

        jLabel11.setText("Cajas:");

        jLabel12.setText("000000");

        jLabel13.setText("Consecutivo:");

        consecutivoLbl.setText("00000");

        jLabel4.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N
        jLabel4.setText("Descripción:");

        procesoLbl.setText(procesosLov.getSelectedItem().toString());

        pesoManualLbl.setBackground(new java.awt.Color(0, 0, 0));
        pesoManualLbl.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        pesoManualLbl.setForeground(new java.awt.Color(0, 204, 51));
        pesoManualLbl.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        pesoManualLbl.addKeyListener(new NumericKeyListener());

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
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 6, Short.MAX_VALUE)
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
                        .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 213, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 609, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(14, 14, 14)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
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
                                .addComponent(reimprimirEtiquetaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 153, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(28, 28, 28)
                                .addComponent(imprimirEtiquetaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 146, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(49, 49, 49)
                                .addComponent(eliminarCajaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 185, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(pesoManualLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 266, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(18, 18, 18)
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(toneladasChk, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(pesoManualChk, javax.swing.GroupLayout.DEFAULT_SIZE, 112, Short.MAX_VALUE)))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 88, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(productoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 375, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                .addContainerGap(53, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(18, 18, 18)
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
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addComponent(pesoManualLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(45, 45, 45))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(pesoManualChk)
                            .addComponent(fechaElaboracionEtiquetaChk))
                        .addGap(6, 6, 6)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(toneladasChk)
                            .addComponent(fechaCaducidadEtiquetaChk))
                        .addGap(9, 9, 9)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(diasCaducidadTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(33, 33, 33)))
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(reimprimirEtiquetaBtn)
                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(imprimirEtiquetaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(eliminarCajaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(productoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(145, Short.MAX_VALUE))
        );

        jSplitPane1.setLeftComponent(jPanel1);

        jPanel2.setLayout(new javax.swing.BoxLayout(jPanel2, javax.swing.BoxLayout.LINE_AXIS));

        tablaProductos.setModel(model);
        jScrollPane3.setViewportView(tablaProductos);

        jPanel2.add(jScrollPane3);

        jSplitPane1.setRightComponent(jPanel2);

        jPanel3.add(jSplitPane1);

        jTabbedPane1.addTab("Pesaje de proceso", jPanel3);

        jLabel3.setText("proceso:");

        procesoLbl1.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N
        procesoLbl1.setText(procesosLov.getSelectedItem().toString());

        jPanel5.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Información del costo", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Times New Roman", 1, 14))); // NOI18N
        jPanel5.setToolTipText("");

        jLabel5.setText("Cost inicial:");

        jLabel7.setText("+");

        jLabel10.setText("Total:");

        jLabel14.setText("Mano de obra:");

        jLabel15.setText("Cstos indirectos:");

        guardarCostoBtn.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        guardarCostoBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/save.png"))); // NOI18N
        guardarCostoBtn.setText("Guardar");
        guardarCostoBtn.setHorizontalTextPosition(SwingConstants.CENTER);
        guardarCostoBtn.setVerticalTextPosition(SwingConstants.BOTTOM);

        agregarCostoBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/plus-icon.png"))); // NOI18N

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addGap(35, 35, 35)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel14)
                    .addComponent(jLabel10)
                    .addComponent(jLabel7)
                    .addComponent(jLabel15)
                    .addComponent(jLabel5))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(masTxt, javax.swing.GroupLayout.DEFAULT_SIZE, 105, Short.MAX_VALUE)
                    .addComponent(manoDeObraTxt)
                    .addComponent(costoIndirectoTxt)
                    .addComponent(totalLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(costoInicialLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(35, 35, 35)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(guardarCostoBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 120, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(agregarCostoBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 62, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addGap(25, 25, 25)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jLabel5, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(costoInicialLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel7)
                    .addComponent(masTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jLabel10)
                    .addComponent(totalLbl, javax.swing.GroupLayout.DEFAULT_SIZE, 19, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel14)
                    .addComponent(manoDeObraTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel15)
                    .addComponent(costoIndirectoTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(34, Short.MAX_VALUE))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel5Layout.createSequentialGroup()
                .addGap(0, 0, Short.MAX_VALUE)
                .addComponent(agregarCostoBtn)
                .addGap(18, 18, 18)
                .addComponent(guardarCostoBtn)
                .addContainerGap())
        );

        jPanel6.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Información del peso", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Times New Roman", 1, 14))); // NOI18N

        P.setText("Peso Inicial:");

        jLabel1.setText("Peso final:");

        agregarPesoInicialBtn.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        agregarPesoInicialBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/plus-icon.png"))); // NOI18N
        agregarPesoInicialBtn.setText("Agregar peso inicial");
        agregarPesoInicialBtn.setHorizontalTextPosition(SwingConstants.CENTER);
        agregarPesoInicialBtn.setVerticalTextPosition(SwingConstants.BOTTOM);
        agregarPesoInicialBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                agregarPesoInicialBtnActionPerformed(evt);
            }
        });

        pesoInicialLbl.setText(this.getPesoInicial());

        javax.swing.GroupLayout jPanel6Layout = new javax.swing.GroupLayout(jPanel6);
        jPanel6.setLayout(jPanel6Layout);
        jPanel6Layout.setHorizontalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel6Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(P)
                    .addComponent(jLabel1))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(pesoInicialLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 110, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(pesoFinalLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 134, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(agregarPesoInicialBtn)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel6Layout.setVerticalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel6Layout.createSequentialGroup()
                .addGap(39, 39, 39)
                .addGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(P)
                    .addComponent(pesoInicialLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(15, 15, 15)
                .addGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(jPanel6Layout.createSequentialGroup()
                        .addGap(35, 35, 35)
                        .addComponent(jLabel1))
                    .addComponent(pesoFinalLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(0, 29, Short.MAX_VALUE))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel6Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(agregarPesoInicialBtn)
                .addGap(38, 38, 38))
        );

        jPanel7.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Reportes", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Times New Roman", 1, 14))); // NOI18N

        reporteGroup.add(condensadoRadio);
        condensadoRadio.setText("Reporte Condensado");
        condensadoRadio.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                condensadoRadioActionPerformed(evt);
            }
        });

        reporteGroup.add(detalladoRadio);
        detalladoRadio.setText("Reporte detallado");
        detalladoRadio.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                detalladoRadioActionPerformed(evt);
            }
        });

        reporteBtn.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        reporteBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/Book-icon.PNG"))); // NOI18N
        reporteBtn.setText("Reporte");
        reporteBtn.setHorizontalTextPosition(SwingConstants.CENTER);
        reporteBtn.setVerticalTextPosition(SwingConstants.BOTTOM);
        reporteBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                reporteBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel7Layout = new javax.swing.GroupLayout(jPanel7);
        jPanel7.setLayout(jPanel7Layout);
        jPanel7Layout.setHorizontalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel7Layout.createSequentialGroup()
                .addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(detalladoRadio, javax.swing.GroupLayout.PREFERRED_SIZE, 127, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(condensadoRadio, javax.swing.GroupLayout.PREFERRED_SIZE, 145, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 78, Short.MAX_VALUE)
                .addComponent(reporteBtn)
                .addGap(25, 25, 25))
        );
        jPanel7Layout.setVerticalGroup(
            jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel7Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(reporteBtn, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGap(76, 76, 76))
            .addGroup(jPanel7Layout.createSequentialGroup()
                .addComponent(condensadoRadio)
                .addGap(18, 18, 18)
                .addComponent(detalladoRadio)
                .addGap(0, 0, Short.MAX_VALUE))
        );

        jPanel8.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Sobrante", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Times New Roman", 1, 14))); // NOI18N

        jLabel16.setText("Hueso:");

        jLabel17.setText("Sebo:");

        jLabel8.setText("Aserrin:");

        pesoHuesoLbl.setText(this.getPesoHueso());

        pesoSeboLbl.setText(this.getPesoSebo());

        pesoAcerrinLbl.setText(this.getPesoAserrin());

        javax.swing.GroupLayout jPanel8Layout = new javax.swing.GroupLayout(jPanel8);
        jPanel8.setLayout(jPanel8Layout);
        jPanel8Layout.setHorizontalGroup(
            jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel8Layout.createSequentialGroup()
                .addGap(21, 21, 21)
                .addGroup(jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel8)
                    .addComponent(jLabel17)
                    .addComponent(jLabel16))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(pesoHuesoLbl, javax.swing.GroupLayout.DEFAULT_SIZE, 142, Short.MAX_VALUE)
                    .addComponent(pesoSeboLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 64, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(pesoAcerrinLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel8Layout.setVerticalGroup(
            jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel8Layout.createSequentialGroup()
                .addGap(36, 36, 36)
                .addGroup(jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel16)
                    .addComponent(pesoHuesoLbl))
                .addGap(32, 32, 32)
                .addGroup(jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel17)
                    .addComponent(pesoSeboLbl))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel8)
                    .addComponent(pesoAcerrinLbl))
                .addContainerGap())
        );

        cerrarProcesoBtn.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        cerrarProcesoBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/lock.png"))); // NOI18N
        cerrarProcesoBtn.setText("Cerrar proceso");
        cerrarProcesoBtn.setHorizontalTextPosition(SwingConstants.CENTER);
        cerrarProcesoBtn.setVerticalTextPosition(SwingConstants.BOTTOM);
        cerrarProcesoBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cerrarProcesoBtnActionPerformed(evt);
            }
        });

        reporteFinalBtn.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        reporteFinalBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/Book-icon.PNG"))); // NOI18N
        reporteFinalBtn.setText("Reporte final");
        reporteFinalBtn.setEnabled(((Procesos)this.procesosLov.getSelectedItem()).getEstatus().equals("ACTIVO")
        );
        reporteFinalBtn.setHorizontalTextPosition(SwingConstants.CENTER);
        reporteFinalBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                reporteFinalBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jPanel6, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(jPanel5, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(21, 21, 21)
                        .addComponent(jLabel3)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(procesoLbl1, javax.swing.GroupLayout.PREFERRED_SIZE, 236, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(30, 30, 30)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(cerrarProcesoBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 180, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(reporteFinalBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 188, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(jPanel7, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jPanel8, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap(622, Short.MAX_VALUE))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(23, 23, 23)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(procesoLbl1)))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(cerrarProcesoBtn, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(reporteFinalBtn, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED, 14, Short.MAX_VALUE)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jPanel8, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel6, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel4Layout.createSequentialGroup()
                        .addComponent(jPanel7, javax.swing.GroupLayout.PREFERRED_SIZE, 161, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(8, 8, 8)))
                .addContainerGap(204, Short.MAX_VALUE))
        );

        cerrarProcesoBtn.getAccessibleContext().setAccessibleName("Cerrarproceso");

        jTabbedPane1.addTab("Cierre de proceso", jPanel4);

        add(jTabbedPane1);
    }// </editor-fold>//GEN-END:initComponents

    private String getPesoInicial() {
        String pesoInicial = "";
        try {
            pesoInicial = procesosDAO.getPesoInicial(((Procesos) procesosLov.getSelectedItem()).getCodigo()).toString();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
        return pesoInicial;
    }

    private String getPesoHueso() {
        String pesoInicial = "";
        try {
            pesoInicial = procesosDAO.getPesoHueso(((Procesos) procesosLov.getSelectedItem()).getCodigo()).toString();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
        return pesoInicial;
    }

    private String getPesoSebo() {
        String pesoInicial = "";
        try {
            pesoInicial = procesosDAO.getPesoSebo(((Procesos) procesosLov.getSelectedItem()).getCodigo()).toString();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
        return pesoInicial;
    }

    private String getPesoAserrin() {
        String pesoInicial = "";
        try {
            pesoInicial = procesosDAO.getPesoAserrin(((Procesos) procesosLov.getSelectedItem()).getCodigo()).toString();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
        return pesoInicial;
    }

    private void procesosCerradosChkActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_procesosCerradosChkActionPerformed
        AbstractButton abstractButton = (AbstractButton) evt.getSource();
        boolean selected = abstractButton.getModel().isSelected();
        if (selected) {
            this.procesosLov.setModel(new DefaultComboBoxModel(getProcesosActivosEInactivosArray()));
        } else {
            this.procesosLov.setModel(new DefaultComboBoxModel(getProcesosActivosArray()));
        }
        procesoLbl.setText(procesosLov.getSelectedItem().toString());
    }//GEN-LAST:event_procesosCerradosChkActionPerformed

    private void procesosLovActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_procesosLovActionPerformed
        procesoLbl.setText(procesosLov.getSelectedItem().toString());
        procesoLbl1.setText(procesosLov.getSelectedItem().toString());
        try {
            consecutivoLbl.setText(procesosDAO.getConsecutivo(((Procesos) procesosLov.getSelectedItem()).getCodigo()).toString());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
        this.setTableModel();
        this.actualizarValores();
        this.reporteFinalBtn.setEnabled(!((Procesos) this.procesosLov.getSelectedItem()).getEstatus().equals("ACTIVO"));
    }//GEN-LAST:event_procesosLovActionPerformed

    private void productoCodigoAreaKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productoCodigoAreaKeyReleased
        char c = evt.getKeyChar();
        if (!(Character.isDigit(c) || c == KeyEvent.VK_BACK_SPACE || c == KeyEvent.VK_DELETE)) {
            evt.consume();
        } else {
            if (!productoCodigoArea.getText().equals("")) {
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
        if (selected) {
            this.pesoBasculaLbl.setEnabled(false);
            this.pesoManualLbl.setEnabled(true);
        } else {
            this.pesoBasculaLbl.setEnabled(true);
            this.pesoManualLbl.setEnabled(false);
        }
    }//GEN-LAST:event_pesoManualChkActionPerformed

    private void toneladasChkActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_toneladasChkActionPerformed
        AbstractButton abstractButton = (AbstractButton) evt.getSource();
        boolean selected = abstractButton.getModel().isSelected();
        if (selected) {

        } else {

        }
    }//GEN-LAST:event_toneladasChkActionPerformed

    private void productosLovActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_productosLovActionPerformed
        productoLbl.setText(productosLov.getSelectedItem().toString());
        productoCodigoArea.setText(((Productos) productosLov.getSelectedItem()).getCodigo().toString());
    }//GEN-LAST:event_productosLovActionPerformed

    private void imprimirEtiquetaBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_imprimirEtiquetaBtnActionPerformed
        ProductosInventario productoInventario = new ProductosInventario();
        Ubicaciones ubicacion = new Ubicaciones();
        ubicacion.setCodigo(1);
        productoInventario.setProductosHasProveedores((ProductosHasProveedores) productosLov.getSelectedItem());
        productoInventario.setUbicaciones(ubicacion);
        if (pesoManualChk.isSelected()) {
            if (pesoManualLbl.getText().equals("")) {
                JOptionPane.showMessageDialog(null, "Debe introducir el peso de la caja.");
                return;
            }
            productoInventario.setPeso(new BigDecimal(pesoManualLbl.getText()));
        } else {
            productoInventario.setPeso(new BigDecimal(pesoBasculaLbl.getText()));
        }
        productoInventario.setProcesosCodigoPadre(((Procesos) procesosLov.getSelectedItem()).getCodigo());
        productoInventario.setPrecio(BigDecimal.ZERO);
        productoInventario.setEstatus("ACTIVO");
        productoInventario.setConsecutivoProceso(new Integer(consecutivoLbl.getText()));
        productoInventario.setCodigoBarras(getCodigoBarras());
        try {
            productoDAO.insertarProducto(productoInventario);
            this.imprimirCodigo();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex, "Errot", ERROR_MESSAGE);
        }
        this.setTableModel();
        this.actualizarValores();
    }//GEN-LAST:event_imprimirEtiquetaBtnActionPerformed

    private void eliminarCajaBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_eliminarCajaBtnActionPerformed
        int[] selectedRows = tablaProductos.getSelectedRows();
        List<ProductosInventario> productosSeleccionados = new ArrayList<>();
        if (selectedRows.length > 0) {
            for (int i = selectedRows.length - 1; i >= 0; i--) {
                ProductosInventario productoSeleccionado = (ProductosInventario) model.getValueAt(selectedRows[i], 0);
                productoSeleccionado.setEstatus("CANCELADO");
                productosSeleccionados.add(productoSeleccionado);
            }
            try {
                productoDAO.actualizarProductosInventario(productosSeleccionados);
                JOptionPane.showMessageDialog(null, "Las cajas se cancelaron correctamente");
                setTableModel();
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex, "Error", ERROR_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(null, "No hay ningúna caja seleccionada.");
        }
    }//GEN-LAST:event_eliminarCajaBtnActionPerformed

    private void formKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_formKeyPressed
        JOptionPane.showMessageDialog(null, "chafa");
    }//GEN-LAST:event_formKeyPressed

    private void cerrarProcesoBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cerrarProcesoBtnActionPerformed
        Procesos proceso = (Procesos) procesosLov.getSelectedItem();
        proceso.setEstatus("CERRADO");
        try {
            procesosDAO.actualizarProceso(proceso);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error", ERROR_MESSAGE
            );
        }
    }//GEN-LAST:event_cerrarProcesoBtnActionPerformed

    private void reporteFinalBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_reporteFinalBtnActionPerformed
        // TODO add your handling code here:
        System.out.println(EtiquetadoPanel.class.getProtectionDomain().getCodeSource().getLocation().getPath());
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/valco", "admin3ZheGrA", "1VtHQW5M-3g-");) {
            /* TODO output your page here. You may use following sample code. */

            //Connecting to the MySQL database
            //Loading Jasper Report File from Local file system
            String realPath = "src/Reportes/Lote_Final.jrxml";
            InputStream input = new FileInputStream(new File(realPath));
            Map mapa = new HashMap();

            mapa.put("procesoCodigo", ((Procesos) (this.procesosLov.getSelectedItem())).getCodigo());

            JasperReport jasperReport = JasperCompileManager.compileReport(input);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, mapa, conn);
            JasperViewer.viewReport(jasperPrint, false);
        } catch (SQLException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JRException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_reporteFinalBtnActionPerformed

    private void reporteBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_reporteBtnActionPerformed
        // TODO add your handling code here:
        if (detalladoRadio.isSelected()) {
            path = "src/Reportes/LoteDetallado.jrxml";
        } else {
            path = "src/Reportes/Lote_final.jrxml";
        }
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/valco", "admin3ZheGrA", "1VtHQW5M-3g-");) {
            /* TODO output your page here. You may use following sample code. */

            //Connecting to the MySQL database
            //Loading Jasper Report File from Local file system
            String realPath = path;
            InputStream input = new FileInputStream(new File(realPath));
            Map mapa = new HashMap();

            mapa.put("procesoCodigo", ((Procesos) (this.procesosLov.getSelectedItem())).getCodigo());

            JasperReport jasperReport = JasperCompileManager.compileReport(input);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, mapa, conn);
            JasperViewer.viewReport(jasperPrint, false);
        } catch (SQLException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JRException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_reporteBtnActionPerformed

    private void detalladoRadioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_detalladoRadioActionPerformed
        // TODO add your handling code here:
        String path = "src/Reportes/LoteDetallado.jrxml";
    }//GEN-LAST:event_detalladoRadioActionPerformed

    private void condensadoRadioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_condensadoRadioActionPerformed
        // TODO add your handling code here:
        String path = "src/Reportes/Lote_Final.jrxml";
    }//GEN-LAST:event_condensadoRadioActionPerformed

    private void agregarPesoInicialBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_agregarPesoInicialBtnActionPerformed
        // TODO add your handling code here:
        addNewPanel(evt);
        
    }//GEN-LAST:event_agregarPesoInicialBtnActionPerformed

    private void addNewPanel(ActionEvent evt){
        if(internalFrame != null)
        this.mainPanel.remove(internalFrame);
        internalFrame = new JInternalFrame("Modificación de peso Inicial", true, true, true);
        JPanel prueb = new AbrirProcesoPanel((Procesos) procesosLov.getSelectedItem());
        internalFrame.add(prueb);
        internalFrame.setBounds(0, 0, 1002, 702);
        this.mainPanel.add(internalFrame);
        internalFrame.setVisible(true);
        internalFrame.show();
        internalFrame.repaint();
    }
    private String swapChars(String str, int lIdx, int rIdx) {
        StringBuilder sb = new StringBuilder(str);
        char l = sb.charAt(lIdx), r = sb.charAt(rIdx);
        sb.setCharAt(lIdx, r);
        sb.setCharAt(rIdx, l);
        return sb.toString();
    }

    private void setTableModel() {
        int rowCount = model.getRowCount();
        //Remove rows one by one from the end of the table
        for (int i = rowCount - 1; i >= 0; i--) {
            model.removeRow(i);
        }
        List<ProductosInventario> productos = new ArrayList<>();
        try {
            productos = procesosDAO.getCajasPorProceso(((Procesos) procesosLov.getSelectedItem()).getCodigo());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex, "Error", ERROR_MESSAGE);
        }
        for (ProductosInventario producto : productos) {
            Object[] row = new Object[5];
            row[0] = producto;
            row[1] = producto.getPeso();
            row[2] = producto.getCodigoBarras();
            row[3] = producto.getConsecutivoProceso();
            row[4] = producto.getEstatus();
            model.addRow(row);
        }
    }

    private void actualizarValores() {
        this.pesoInicialLbl.setText(this.getPesoInicial());
        this.pesoHuesoLbl.setText(this.getPesoHueso());
        this.pesoSeboLbl.setText(this.getPesoSebo());
        this.pesoAcerrinLbl.setText(this.getPesoAserrin());
        try {
            consecutivoLbl.setText(procesosDAO.getConsecutivo(((Procesos) procesosLov.getSelectedItem()).getCodigo()).toString());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
    }
    private String getCodigoBarras(){
       return this.procesosLov.getSelectedItem()
                + new SimpleDateFormat("yyddMM").format(new Date())
                + ((ProductosHasProveedores) this.productosLov.getSelectedItem()).getProductos().getCodigo()
                + (pesoManualChk.isSelected() ? pesoManualLbl.getText().replaceAll("\\.", "") : pesoBasculaLbl.getText().replaceAll("\\.", ""))
                + consecutivoLbl.getText();
    }

    private void imprimirCodigo() {
        // aca obtenemos la printer default  
        PrintService printService = PrintServiceLookup.lookupDefaultPrintService();

        String zplCommand = "^XA"
                + "^FO30,150^ARN,11,7^FD "+ this.productosLov.getSelectedItem()+""
                + "^BCN, 80, Y, Y, Y^FD >"+getCodigoBarras()+" ^FS "
                + "^XZ";

// convertimos el comando a bytes  
        byte[] by = zplCommand.getBytes();
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


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel P;
    private javax.swing.JButton agregarCostoBtn;
    private javax.swing.JButton agregarPesoInicialBtn;
    private javax.swing.JButton cerrarProcesoBtn;
    private javax.swing.JRadioButton condensadoRadio;
    private javax.swing.JLabel consecutivoLbl;
    private javax.swing.JTextField costoIndirectoTxt;
    private javax.swing.JLabel costoInicialLbl;
    private javax.swing.JTextArea descripcionArea;
    private javax.swing.JRadioButton detalladoRadio;
    private javax.swing.JTextField diasCaducidadTxt;
    private javax.swing.JButton eliminarCajaBtn;
    private javax.swing.JCheckBox fechaCaducidadEtiquetaChk;
    private javax.swing.JCheckBox fechaElaboracionEtiquetaChk;
    private javax.swing.JButton guardarCostoBtn;
    public javax.swing.JButton imprimirEtiquetaBtn;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel15;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel17;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JTabbedPane jTabbedPane1;
    private javax.swing.JTextField manoDeObraTxt;
    private javax.swing.JTextField masTxt;
    private javax.swing.JLabel pesoAcerrinLbl;
    private javax.swing.JLabel pesoBasculaLbl;
    private javax.swing.JLabel pesoFinalLbl;
    private javax.swing.JLabel pesoHuesoLbl;
    private javax.swing.JLabel pesoInicialLbl;
    private javax.swing.JCheckBox pesoManualChk;
    private javax.swing.JTextField pesoManualLbl;
    private javax.swing.JLabel pesoSeboLbl;
    private javax.swing.JLabel procesoLbl;
    private javax.swing.JLabel procesoLbl1;
    private javax.swing.JCheckBox procesosCerradosChk;
    private javax.swing.JComboBox procesosLov;
    private javax.swing.JTextArea productoCodigoArea;
    private javax.swing.JLabel productoLbl;
    private javax.swing.JComboBox productosLov;
    private javax.swing.JButton reimprimirEtiquetaBtn;
    private javax.swing.JButton reporteBtn;
    private javax.swing.JButton reporteFinalBtn;
    private javax.swing.ButtonGroup reporteGroup;
    private javax.swing.JTable tablaProductos;
    private javax.swing.JCheckBox toneladasChk;
    private javax.swing.JLabel totalLbl;
    // End of variables declaration//GEN-END:variables
}
