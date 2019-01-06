package panels;

import components.BasculaPanel;
import components.CustomCellRendered;
import components.ProductosTableModel;
import creators.PanelCreator;
import dao.OrdenesCompraDAO;
import dao.ProcesosDAO;
import dao.ProcesosDAOImpl;
import dao.ProductoDAO;
import java.awt.ComponentOrientation;
import java.awt.KeyEventDispatcher;
import java.awt.KeyboardFocusManager;
import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
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
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableModel;
import listeners.NumericKeyListener;
import mapping.OrdenesCompra;
import mapping.Procesos;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import mapping.Subfamilias;
import mapping.Ubicaciones;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.view.JasperViewer;
import observables.Observable;
import observers.Observer;
import pesable.PesableBarCodeable;
import table.custom.EtiquetadoTableCellRendered;
import table.custom.NoEditableTableModel;
import threads.PesoThread;
import utilities.ParametrosGeneralesUtility;
import utilities.UsuarioFirmado;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Administrador
 */
public class EtiquetadoPanel extends PesableBarCodeable implements Observer{

    private CustomCellRendered cellRendered;

    String path;
    String reportDir;
    ProcesosDAOImpl procesosDAO = new ProcesosDAOImpl();
    ProcesosDAO cajasProcesoDAO;
    ProductoDAO productoDAO = new ProductoDAO();
    ProductosTableModel model;
    String formato = "##.##";
    JInternalFrame internalFrame;
    OrdenesCompraDAO ordenesDAO = new OrdenesCompraDAO();
    Action action = new AbstractAction("doSomething") {

        @Override
        public void actionPerformed(ActionEvent e) {
            System.out.println("triggered the action");
        }

    };
    private boolean reetiquetado;
    private String proceso;
    private BasculaPanel basculaPanel1;
    private AbrirCajaPanel abrirCajaPanel;
    private AbrirProcesoPanel actualizarProcesoPanel;

    /**
     * Creates new form EtiquetadoPanel
     */
    public EtiquetadoPanel(boolean reetiquetado) {
        this.reetiquetado = reetiquetado;
    }

    public void init() {
        try {
            this.reportDir = ParametrosGeneralesUtility.getValor("RE001");
        } catch (Exception ex) {
            this.reportDir = "C://valco_installation//reportes//";
        }
        this.mainPanel = mainPanel;
        initComponents();
        productoCodigoArea.getDocument().putProperty("filterNewlines", Boolean.TRUE);
        action.putValue(Action.ACCELERATOR_KEY, KeyStroke.getKeyStroke("control S"));
        tablaProductos.setDefaultRenderer(Object.class, (TableCellRenderer) cellRendered);
        this.setTableModel();
        tablaProductos.getColumn("Nombre").setPreferredWidth(300);
        tablaProductos.getColumn("Peso").setPreferredWidth(80);
        tablaProductos.getColumn("Etiqueta").setPreferredWidth(320);
//        tablaProductos.getColumn("Consecutivo").setPreferredWidth(100);
        tablaProductos.getColumn("Estatus").setPreferredWidth(100);
        try {
            consecutivoLbl.setText(procesosDAO.getConsecutivo(((Procesos) procesosLov.getSelectedItem()).getCodigo()).toString());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
        cierrePanel.setVisible(!reetiquetado);
        procesoPanel.setVisible(!reetiquetado);
        if (procesosLov.getSelectedItem() != null) {
            procesoLbl.setText(procesosLov.getSelectedItem().toString());
            model.limpiar();
        }
        jPanel1.add(basculaPanel1);
        basculaPanel1.setBounds(20, 310, 379, 200);
        if (reetiquetado) {
            panelPestanas.remove(1);
            imprimirEtiquetaBtn.setVisible(false);
            eliminarCajaBtn.setVisible(false);
        } else {
            productosLov.setModel(new DefaultComboBoxModel(getProducts()));
        }
        abrirCajaDlg.add(abrirCajaPanel);
        abrirCajaPanel.setBounds(0, 0, 1004, 453);
        updateValues();
    }

    private Object[] getProducts() {
        Object[] productosArray = new Object[0];
        Set<Subfamilias> subfamilias = new HashSet<>();
        try {
            for (ProductosInventario productos : ((Procesos) procesosLov.getSelectedItem()).getProductosPadres()) {
                subfamilias.add(productos.getProductosHasProveedores().getProductos().getSubfamilias());
                System.out.println("Una subfamilia");
            }
            Proveedores proveedor = new Proveedores();
            proveedor.setCodigo(9999999);
            productosArray = productoDAO.getProductosHasProveedoresInFamilias(subfamilias, proveedor).toArray();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error", ERROR_MESSAGE);
        }
        return productosArray;
    }

    private Object[] getProcesosActivosArray() {
        Object[] procesosActivosArray = new Object[0];
        try {
            OrdenesCompra orden = new OrdenesCompra();
            orden.setCodigo(24);
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
        abrirCajaDlg = new javax.swing.JDialog();
        pesoInicialDlg = new javax.swing.JDialog();
        panelPestanas = new javax.swing.JTabbedPane();
        jPanel3 = new javax.swing.JPanel();
        jSplitPane1 = new javax.swing.JSplitPane();
        jPanel1 = new javax.swing.JPanel();
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
        procesoPanel = new javax.swing.JPanel();
        procesosCerradosChk = new javax.swing.JCheckBox();
        procesoLbl = new javax.swing.JLabel();
        consecutivoLbl = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel13 = new javax.swing.JLabel();
        jLabel11 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        descripcionArea = new javax.swing.JTextArea();
        jLabel4 = new javax.swing.JLabel();
        procesosLov = new javax.swing.JComboBox();
        jLabel12 = new javax.swing.JLabel();
        Menudeo = new javax.swing.JButton();
        buscarBtn = new javax.swing.JButton();
        jPanel2 = new javax.swing.JPanel();
        jScrollPane3 = new javax.swing.JScrollPane();
        tablaProductos = new javax.swing.JTable();
        cierrePanel = new javax.swing.JPanel();
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
        pesoFinalLbl2 = new javax.swing.JLabel();
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

        abrirCajaDlg.setMinimumSize(new java.awt.Dimension(1004, 460));

        javax.swing.GroupLayout abrirCajaDlgLayout = new javax.swing.GroupLayout(abrirCajaDlg.getContentPane());
        abrirCajaDlg.getContentPane().setLayout(abrirCajaDlgLayout);
        abrirCajaDlgLayout.setHorizontalGroup(
            abrirCajaDlgLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 400, Short.MAX_VALUE)
        );
        abrirCajaDlgLayout.setVerticalGroup(
            abrirCajaDlgLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 300, Short.MAX_VALUE)
        );

        pesoInicialDlg.setMinimumSize(new java.awt.Dimension(1100, 750));

        javax.swing.GroupLayout pesoInicialDlgLayout = new javax.swing.GroupLayout(pesoInicialDlg.getContentPane());
        pesoInicialDlg.getContentPane().setLayout(pesoInicialDlgLayout);
        pesoInicialDlgLayout.setHorizontalGroup(
            pesoInicialDlgLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 400, Short.MAX_VALUE)
        );
        pesoInicialDlgLayout.setVerticalGroup(
            pesoInicialDlgLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 300, Short.MAX_VALUE)
        );

        addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                formMouseClicked(evt);
            }
        });
        addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                formKeyPressed(evt);
            }
        });
        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        panelPestanas.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                panelPestanasMouseClicked(evt);
            }
        });

        jPanel3.setLayout(new javax.swing.BoxLayout(jPanel3, javax.swing.BoxLayout.LINE_AXIS));

        jScrollPane2.setHorizontalScrollBar(null);

        productoCodigoArea.setColumns(40);
        productoCodigoArea.setFont(new java.awt.Font("Arial", 1, 22)); // NOI18N
        productoCodigoArea.setRows(1);
        productoCodigoArea.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                productoCodigoAreaKeyReleased(evt);
            }
        });
        jScrollPane2.setViewportView(productoCodigoArea);

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
        reimprimirEtiquetaBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                reimprimirEtiquetaBtnActionPerformed(evt);
            }
        });

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

        eliminarCajaBtn.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        eliminarCajaBtn.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/button_cancel-48.png"))); // NOI18N
        eliminarCajaBtn.setText("<html><center>Eliminar<br>Caja<html>");
        eliminarCajaBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                eliminarCajaBtnActionPerformed(evt);
            }
        });

        procesoPanel.setBorder(javax.swing.BorderFactory.createTitledBorder("Detalle del proceso"));

        procesosCerradosChk.setText("Mostrar procesos cerrados");
        procesosCerradosChk.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                procesosCerradosChkActionPerformed(evt);
            }
        });

        consecutivoLbl.setText("00000");

        jLabel2.setText("ID del proceso:");

        jLabel13.setText("Consecutivo:");

        jLabel11.setText("Cajas:");

        descripcionArea.setColumns(20);
        descripcionArea.setRows(5);
        jScrollPane1.setViewportView(descripcionArea);

        jLabel4.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N
        jLabel4.setText("Descripción:");

        procesosLov.setModel(new DefaultComboBoxModel(getProcesosActivosArray()));
        procesosLov.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                procesosLovActionPerformed(evt);
            }
        });

        jLabel12.setText("000000");

        Menudeo.setText("Menudeo");
        Menudeo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                MenudeoActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout procesoPanelLayout = new javax.swing.GroupLayout(procesoPanel);
        procesoPanel.setLayout(procesoPanelLayout);
        procesoPanelLayout.setHorizontalGroup(
            procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(procesoPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(procesoPanelLayout.createSequentialGroup()
                        .addGroup(procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(procesoPanelLayout.createSequentialGroup()
                                .addGap(4, 4, 4)
                                .addComponent(procesosCerradosChk)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(procesosLov, javax.swing.GroupLayout.PREFERRED_SIZE, 246, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(procesoPanelLayout.createSequentialGroup()
                                .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 85, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(procesoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 95, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(procesoPanelLayout.createSequentialGroup()
                                .addGroup(procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                    .addComponent(jLabel13)
                                    .addComponent(jLabel11))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addGroup(procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(jLabel12)
                                    .addComponent(consecutivoLbl))
                                .addGap(115, 115, 115))
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, procesoPanelLayout.createSequentialGroup()
                                .addComponent(Menudeo, javax.swing.GroupLayout.PREFERRED_SIZE, 214, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addContainerGap())))
                    .addGroup(procesoPanelLayout.createSequentialGroup()
                        .addGroup(procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 213, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 609, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addContainerGap())))
        );
        procesoPanelLayout.setVerticalGroup(
            procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(procesoPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(procesosCerradosChk)
                    .addComponent(procesosLov, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel11)
                    .addComponent(jLabel12))
                .addGroup(procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(procesoPanelLayout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(procesoLbl))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(procesoPanelLayout.createSequentialGroup()
                        .addGap(2, 2, 2)
                        .addGroup(procesoPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel13)
                            .addComponent(consecutivoLbl))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(Menudeo)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        buscarBtn.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        buscarBtn.setText("Buscar");
        buscarBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buscarBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(14, 14, 14)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                .addGroup(jPanel1Layout.createSequentialGroup()
                                    .addComponent(diasCaducidadTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 69, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addGap(18, 18, 18)
                                    .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 135, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 226, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(productosLov, javax.swing.GroupLayout.PREFERRED_SIZE, 226, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(fechaElaboracionEtiquetaChk)
                                .addComponent(fechaCaducidadEtiquetaChk))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(reimprimirEtiquetaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 153, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(10, 10, 10)
                                .addComponent(imprimirEtiquetaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 146, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(eliminarCajaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 152, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(buscarBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 151, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(procesoPanel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(13, 13, 13)
                .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 88, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(productoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 375, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(procesoPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(33, 33, 33)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 54, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(productosLov, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(11, 11, 11)
                .addComponent(fechaElaboracionEtiquetaChk)
                .addGap(9, 9, 9)
                .addComponent(fechaCaducidadEtiquetaChk)
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(diasCaducidadTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(7, 7, 7)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(reimprimirEtiquetaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 57, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(imprimirEtiquetaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(eliminarCajaBtn, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(buscarBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 55, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(productoLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(122, Short.MAX_VALUE))
        );

        jSplitPane1.setLeftComponent(jPanel1);

        jPanel2.setLayout(new javax.swing.BoxLayout(jPanel2, javax.swing.BoxLayout.LINE_AXIS));

        tablaProductos.setModel((TableModel)model);
        jScrollPane3.setViewportView(tablaProductos);

        jPanel2.add(jScrollPane3);

        jSplitPane1.setRightComponent(jPanel2);

        jPanel3.add(jSplitPane1);

        panelPestanas.addTab("Pesaje de proceso", jPanel3);

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
                    .addComponent(pesoFinalLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 134, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(pesoFinalLbl2, javax.swing.GroupLayout.PREFERRED_SIZE, 89, javax.swing.GroupLayout.PREFERRED_SIZE))
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
                        .addGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel1)
                            .addComponent(pesoFinalLbl2, javax.swing.GroupLayout.PREFERRED_SIZE, 14, javax.swing.GroupLayout.PREFERRED_SIZE)))
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

        javax.swing.GroupLayout cierrePanelLayout = new javax.swing.GroupLayout(cierrePanel);
        cierrePanel.setLayout(cierrePanelLayout);
        cierrePanelLayout.setHorizontalGroup(
            cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(cierrePanelLayout.createSequentialGroup()
                .addGroup(cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(cierrePanelLayout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jPanel6, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(jPanel5, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                    .addGroup(cierrePanelLayout.createSequentialGroup()
                        .addGap(21, 21, 21)
                        .addComponent(jLabel3)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(procesoLbl1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addGap(30, 30, 30)
                .addGroup(cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(cierrePanelLayout.createSequentialGroup()
                        .addComponent(cerrarProcesoBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 180, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(reporteFinalBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 188, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(jPanel7, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jPanel8, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap(622, Short.MAX_VALUE))
        );
        cierrePanelLayout.setVerticalGroup(
            cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(cierrePanelLayout.createSequentialGroup()
                .addGroup(cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(cierrePanelLayout.createSequentialGroup()
                        .addGap(23, 23, 23)
                        .addGroup(cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(procesoLbl1)))
                    .addGroup(cierrePanelLayout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(cerrarProcesoBtn, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(reporteFinalBtn, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED, 20, Short.MAX_VALUE)
                .addGroup(cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jPanel8, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel6, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addGroup(cierrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, cierrePanelLayout.createSequentialGroup()
                        .addComponent(jPanel7, javax.swing.GroupLayout.PREFERRED_SIZE, 161, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(8, 8, 8)))
                .addContainerGap(210, Short.MAX_VALUE))
        );

        cerrarProcesoBtn.getAccessibleContext().setAccessibleName("Cerrarproceso");

        panelPestanas.addTab("Cierre de proceso", cierrePanel);

        add(panelPestanas);
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

    public ProcesosDAO getCajasProcesoDAO() {
        return cajasProcesoDAO;
    }

    public void setCajasProcesoDAO(ProcesosDAO cajasProcesoDAO) {
        this.cajasProcesoDAO = cajasProcesoDAO;
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
        updateValues();
    }//GEN-LAST:event_procesosLovActionPerformed

    private void updateValues() {
        procesoLbl.setText(procesosLov.getSelectedItem().toString());
        procesoLbl1.setText(procesosLov.getSelectedItem().toString());
        descripcionArea.setText(((Procesos) procesosLov.getSelectedItem()).getObservaciones());
        this.setTableModel();
        this.actualizarValores();
        this.reporteFinalBtn.setEnabled(!((Procesos) this.procesosLov.getSelectedItem()).getEstatus().equals("ACTIVO"));
        pesoFinalLbl2.setText(((Procesos) procesosLov.getSelectedItem()).getPesoSalida().toString());
        productosLov.setModel(new DefaultComboBoxModel(getProducts()));
    }

    private void productoCodigoAreaKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productoCodigoAreaKeyReleased
        if (evt.getKeyChar() == KeyEvent.VK_ENTER) {
            imprimitEtiqueta();
        } else {
            if (!productoCodigoArea.getText().equals("")) {
                ProductosHasProveedores productoProveedor = new ProductosHasProveedores();
                Productos producto = new Productos();
                try {
                    producto = productoDAO.getProductosXDescripcionOCodigo(productoCodigoArea.getText());
                } catch (Exception ex) {
                    Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
                }
                productoProveedor.setProductos(producto);
                Proveedores prov = new Proveedores();
                prov.setCodigo(9999999);
                System.out.println(producto);
                productoProveedor.setProveedores(prov);
                productosLov.setSelectedItem(productoProveedor);
                productosLov.repaint();
            }
        }

    }//GEN-LAST:event_productoCodigoAreaKeyReleased


    private void productosLovActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_productosLovActionPerformed
        productoLbl.setText(productosLov.getSelectedItem().toString());
        //productoCodigoArea.setText(((ProductosHasProveedores) productosLov.getSelectedItem()).getCodigo().toString());
    }//GEN-LAST:event_productosLovActionPerformed

    private void imprimirEtiquetaBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_imprimirEtiquetaBtnActionPerformed
        imprimitEtiqueta();
    }//GEN-LAST:event_imprimirEtiquetaBtnActionPerformed

    private void imprimitEtiqueta() {
        ProductosInventario productoInventario = new ProductosInventario();
        productoInventario.setProductosHasProveedores((ProductosHasProveedores) productosLov.getSelectedItem());
        productoInventario.setUbicaciones(UsuarioFirmado.getUsuarioFirmado().getUbicaciones());
        productoInventario.setPeso(basculaPanel1.getPeso());
        productoInventario.setProcesosCodigoPadre(((Procesos) procesosLov.getSelectedItem()).getCodigo());
        productoInventario.setPrecio(BigDecimal.ZERO);
        productoInventario.setEstatus("ACTIVO");
        productoInventario.setConsecutivoProceso(new Integer(consecutivoLbl.getText()));
        productoInventario.setCodigoBarras(getCodigoBarras());
        productoInventario.setFechaCreacion(new Date());
        productoInventario.setReetiquetado(reetiquetado);
        try {
            productoDAO.insertarProducto(productoInventario);
            this.imprimirCodigo(productoInventario);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex, "Errot", ERROR_MESSAGE);
        }
        this.setTableModel();
        this.actualizarValores();
    }

    private void eliminarCajaBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_eliminarCajaBtnActionPerformed
        int[] selectedRows = tablaProductos.getSelectedRows();
        List<ProductosInventario> productosSeleccionados = new ArrayList<>();
        if (selectedRows.length > 0) {
            for (int i = selectedRows.length - 1; i >= 0; i--) {
                ProductosInventario productoSeleccionado = (ProductosInventario) model.getElementAt(selectedRows[i], 0);
                if (productoSeleccionado.getEstatus().equals("ACTIVO")) {
                    productoSeleccionado.setEstatus("CANCELADO");
                    productosSeleccionados.add(productoSeleccionado);
                }

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
        Properties prop = new Properties();
        String propFileName = "C:\\valco_installation\\conf\\valco.properties";

        InputStream inputStream = null;
        try {
            inputStream = new FileInputStream(propFileName);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (inputStream != null) {
            try {
                prop.load(inputStream);
            } catch (IOException ex) {
                Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
            } catch (FileNotFoundException ex) {
                Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        String server = prop.getProperty("server");
        String port = prop.getProperty("port");
        String dbname = prop.getProperty("dbname");
        String user = prop.getProperty("user");
        String password = prop.getProperty("password");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://" + server + ":" + port + "/" + dbname, user, password);) {
            /* TODO output your page here. You may use following sample code. */

            //Connecting to the MySQL database
            //Loading Jasper Report File from Local file system
            String realPath = this.reportDir + "planta/Lote_Final.jrxml";
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
            path = reportDir + "planta/LoteDetallado.jrxml";
        } else {
            path = reportDir + "planta/Lote_Final.jrxml";
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

        Properties prop = new Properties();
        String propFileName = "C:\\valco_installation\\conf\\valco.properties";

        InputStream inputStream = null;
        try {
            inputStream = new FileInputStream(propFileName);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (inputStream != null) {
            try {
                prop.load(inputStream);
            } catch (IOException ex) {
                Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
            } catch (FileNotFoundException ex) {
                Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        String server = prop.getProperty("server");
        String port = prop.getProperty("port");
        String dbname = prop.getProperty("dbname");
        String user = prop.getProperty("user");
        String password = prop.getProperty("password");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://" + server + ":" + port + "/" + dbname, user, password);) {
            /* TODO output your page here. You may use following sample code. */

            //Connecting to the MySQL database
            //Loading Jasper Report File from Local file system
            String realPath = path;
            InputStream input = new FileInputStream(new File(realPath));
            Map mapa = new HashMap();

            System.out.println(reportDir);
            System.out.println(realPath);
            mapa.put("procesoCodigo", ((Procesos) (this.procesosLov.getSelectedItem())).getCodigo());
            mapa.put("SUBREPORT_DIR", reportDir + "/planta/");

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
        String path = reportDir + "planta/LoteDetallado.jrxml";
    }//GEN-LAST:event_detalladoRadioActionPerformed

    private void condensadoRadioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_condensadoRadioActionPerformed
        // TODO add your handling code here:
        String path = reportDir + "planta/Lote_Final.jrxml";
    }//GEN-LAST:event_condensadoRadioActionPerformed

    private void agregarPesoInicialBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_agregarPesoInicialBtnActionPerformed
        // TODO add your handling code here:
        addNewPanel(evt);

    }//GEN-LAST:event_agregarPesoInicialBtnActionPerformed

    private void reimprimirEtiquetaBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_reimprimirEtiquetaBtnActionPerformed
        int[] selectedRows = tablaProductos.getSelectedRows();
        if (selectedRows.length > 0) {
            for (int i = selectedRows.length - 1; i >= 0; i--) {
                ProductosInventario productoSeleccionado = (ProductosInventario) model.getElementAt(selectedRows[i], 0);
                this.imprimirCodigo(productoSeleccionado);
            }
        }
        model.limpiar();
    }//GEN-LAST:event_reimprimirEtiquetaBtnActionPerformed

    private void buscarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buscarBtnActionPerformed
        try {
            List<ProductosInventario> productos = productoDAO.getProductosPesadosByEstatus(
                    basculaPanel1.getPeso(),
                    ((ProductosHasProveedores) productosLov.getSelectedItem()).getProductos(),
                    "ACTIVO");
            model.convertirProductos(productos);
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(ex.getMessage());
            return;
        }
    }//GEN-LAST:event_buscarBtnActionPerformed

    private void formMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_formMouseClicked
        // TODO add your handling code here:
    }//GEN-LAST:event_formMouseClicked

    private void panelPestanasMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_panelPestanasMouseClicked
        pesoFinalLbl2.setText(((Procesos) procesosLov.getSelectedItem()).getPesoSalida().toString());
    }//GEN-LAST:event_panelPestanasMouseClicked

    private void MenudeoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_MenudeoActionPerformed
        abrirCajaDlg.setVisible(true);
    }//GEN-LAST:event_MenudeoActionPerformed

    private void addNewPanel(ActionEvent evt) {
        if(actualizarProcesoPanel!= null){
            pesoInicialDlg.remove(actualizarProcesoPanel);
        }
        actualizarProcesoPanel = new AbrirProcesoPanel((Procesos) procesosLov.getSelectedItem());
        pesoInicialDlg.add(actualizarProcesoPanel);
        actualizarProcesoPanel.setBounds(0, 0, 1002, 702);
        actualizarProcesoPanel.registerObserver(this);
        pesoInicialDlg.setVisible(true);
    }

    private String swapChars(String str, int lIdx, int rIdx) {
        StringBuilder sb = new StringBuilder(str);
        char l = sb.charAt(lIdx), r = sb.charAt(rIdx);
        sb.setCharAt(lIdx, r);
        sb.setCharAt(rIdx, l);
        return sb.toString();
    }

    private void setTableModel() {
        model.limpiar();
        List<ProductosInventario> productos = new ArrayList<>();
        try {
            productos = cajasProcesoDAO.getCajasPorProceso(((Procesos) procesosLov.getSelectedItem()).getCodigo());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex, "Error", ERROR_MESSAGE);
        }
        model.convertirProductos(productos);
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

    private String getCodigoBarras() {
        return ((Procesos)this.procesosLov.getSelectedItem()).getId()
                + String.format("%05d", ((ProductosHasProveedores) this.productosLov.getSelectedItem()).getProductos().getCodigo())
                + String.format("%06d", Integer.parseInt(basculaPanel1.getPeso().toString().replaceAll("\\.", "")))
                + String.format("%04d", Integer.parseInt(consecutivoLbl.getText()));
    }

    private void imprimirCodigo(ProductosInventario producto) {
        // aca obtenemos la printer default  

        String label = "";
        try (BufferedReader br = new BufferedReader(new FileReader("C:\\valco_installation\\conf\\CodigoBarras.txt"))) {
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
    
    @Override
    public void Update(Observable observable) {
        if(observable.equals(actualizarProcesoPanel)){
            try {
                pesoInicialLbl.setText(
                        procesosDAO.getPesoInicial(((Procesos)procesosLov.getSelectedItem()).getCodigo()).toString());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    public boolean isReetiquetado() {
        return reetiquetado;
    }

    public void setReetiquetado(boolean reetiquetado) {
        this.reetiquetado = reetiquetado;
    }

    public String getProceso() {
        return proceso;
    }

    public void setProceso(String proceso) {
        this.proceso = proceso;
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

    public BasculaPanel getBasculaPanel1() {
        return basculaPanel1;
    }

    public void setBasculaPanel1(BasculaPanel basculaPanel1) {
        this.basculaPanel1 = basculaPanel1;
    }

    public AbrirCajaPanel getAbrirCajaPanel() {
        return abrirCajaPanel;
    }

    public void setAbrirCajaPanel(AbrirCajaPanel abrirCajaPanel) {
        this.abrirCajaPanel = abrirCajaPanel;
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton Menudeo;
    private javax.swing.JLabel P;
    private javax.swing.JDialog abrirCajaDlg;
    private javax.swing.JButton agregarCostoBtn;
    private javax.swing.JButton agregarPesoInicialBtn;
    private javax.swing.JButton buscarBtn;
    private javax.swing.JButton cerrarProcesoBtn;
    public javax.swing.JPanel cierrePanel;
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
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JTextField manoDeObraTxt;
    private javax.swing.JTextField masTxt;
    private javax.swing.JTabbedPane panelPestanas;
    private javax.swing.JLabel pesoAcerrinLbl;
    private javax.swing.JLabel pesoFinalLbl;
    private javax.swing.JLabel pesoFinalLbl2;
    private javax.swing.JLabel pesoHuesoLbl;
    private javax.swing.JDialog pesoInicialDlg;
    private javax.swing.JLabel pesoInicialLbl;
    private javax.swing.JLabel pesoSeboLbl;
    private javax.swing.JLabel procesoLbl;
    private javax.swing.JLabel procesoLbl1;
    private javax.swing.JPanel procesoPanel;
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
    private javax.swing.JLabel totalLbl;
    // End of variables declaration//GEN-END:variables

    
}
