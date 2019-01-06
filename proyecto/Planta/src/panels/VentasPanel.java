/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package panels;

import barcode.BarCodable;
import barcode.BarCodableImpl;
import dao.ClienteDAO;
import dao.NotasVentaDAO;
import dao.ProductoDAO;
import dao.RepartidoresDAO;
import java.awt.Component;
import java.awt.KeyboardFocusManager;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JDialog;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableModel;
import keydispatchers.BarCodeScannerKeyDispatcher;
import mapping.Clientes;
import mapping.NotasDeVenta;
import mapping.Procesos;
import mapping.ProductosInventario;
import mapping.Repartidores;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.view.JasperViewer;
import observers.AbrirCajaObserver;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import table.custom.ColumnEditableTableModel;
import table.custom.NoEditableTableModel;
import utilities.ParametrosGeneralesUtility;

/**
 *
 * @author Administrador
 */
public class VentasPanel extends BarCodableImpl  implements AbrirCajaObserver{

    ClienteDAO clienteDAO = new ClienteDAO();
    ProductoDAO productoDAO = new ProductoDAO();
    DefaultTableModel modelProductos = new ColumnEditableTableModel();
    NotasVentaDAO notasDAO = new NotasVentaDAO();
    List<ProductosInventario> productos = new ArrayList<>();
    public List<Component> exceptions = new ArrayList<>();
    NotasDeVenta notaSeleccionada = null;
    private String reportDir;
    private String path;
    private AbrirCajaPanel abrirCajaPanel;

    /**
     * Creates new form VentasPanel
     */
    public VentasPanel(){
    }
    
    public void init() {
        try {
            this.reportDir = ParametrosGeneralesUtility.getValor("RE001");
        } catch (Exception ex) {
            this.reportDir = "C://valco_installation//reportes//";
        }
        initComponents();
        abrirCajaDlg.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
        abrirCajaDlg.add(abrirCajaPanel);
        abrirCajaPanel.setBounds(0, 0, 1004, 453);
        abrirCajaPanel.registerObserver(this);
        List<Integer> columnasEditables = new ArrayList<>();
        columnasEditables.add(3);
        columnasEditables.add(1);
        ((ColumnEditableTableModel) modelProductos).setColumns(columnasEditables);
        modelProductos.addTableModelListener(new TableModelListener() {

            @Override
            public void tableChanged(TableModelEvent e) {
                if (tablaProductos1.isEditing()) {
                    ProductosInventario productoSeleccionado
                            = productos.get(tablaProductos1.getSelectedRow());
                    String precioNuevo = tablaProductos1.getValueAt(tablaProductos1.getSelectedRow(),
                            tablaProductos1.getSelectedColumn()).toString();
                    if (!NumberUtils.isNumber(precioNuevo)) {
                        return;
                    }
                    productoSeleccionado.setPrecio(new BigDecimal(precioNuevo));
                    NumberFormat formatter = NumberFormat.getCurrencyInstance();
                    String total = formatter.format(getTotalSeleccionado(productos));
                    totalLabel.setText(total);
                }
            }
        });
    }

    public BigDecimal getTotalSeleccionado(List<ProductosInventario> productos) {
        DecimalFormat df = new DecimalFormat("0.00");
        BigDecimal total = new BigDecimal(BigInteger.ZERO, 2);
        total.setScale(2, BigDecimal.ROUND_HALF_UP);
        if (productos != null && !productos.isEmpty()) {
            for (ProductosInventario producto : productos) {
                if (producto.getPeso() != null && producto.getPrecio() != null) {
                    total = total.add(producto.getPeso().multiply(producto.getPrecio()).setScale(2, RoundingMode.HALF_EVEN));
                } else {
                    JOptionPane.showMessageDialog(null, "Presione enter después de capturar un precio o un peso, de lo contrario el total podía no mostrarse bien");
                }
            }
        }
        return total;

    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        abrirCajaDlg = new javax.swing.JDialog();
        Pesaje = new javax.swing.JPanel();
        jSplitPane2 = new javax.swing.JSplitPane();
        jPanel4 = new javax.swing.JPanel();
        jSplitPane1 = new javax.swing.JSplitPane();
        jPanel1 = new javax.swing.JPanel();
        eliminarCajaBtn = new javax.swing.JButton();
        jPanel2 = new javax.swing.JPanel();
        jSplitPane3 = new javax.swing.JSplitPane();
        jScrollPane4 = new javax.swing.JScrollPane();
        tablaProductos1 = new javax.swing.JTable();
        String[] columnNames = {
            "Nombre",
            "Peso",
            "Codigo de Barras",
            "Precio"};

        modelProductos.setColumnIdentifiers(columnNames);
        jPanel6 = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        totalLabel = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();
        pesoTotalLbl = new javax.swing.JLabel();
        jScrollPane2 = new javax.swing.JScrollPane();
        jPanel3 = new javax.swing.JPanel();
        PanelRepartidor = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        clientesLov = new javax.swing.JComboBox();
        clienteTxt = new javax.swing.JTextField();
        PanelCodigoBarras = new javax.swing.JPanel();
        jLabel3 = new javax.swing.JLabel();
        barCodeTxt = new javax.swing.JTextField();
        abrirCajaBtn = new javax.swing.JButton();
        PanelFinalizar = new javax.swing.JPanel();
        finalizarBtn = new javax.swing.JButton();
        jPanel5 = new javax.swing.JPanel();
        notaLabel = new javax.swing.JLabel();
        notaTxt = new javax.swing.JTextField();
        repartidorLabel = new javax.swing.JLabel();

        abrirCajaDlg.setSize(new java.awt.Dimension(804, 453));

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

        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        Pesaje.setPreferredSize(new java.awt.Dimension(1558, 455));
        Pesaje.setLayout(new javax.swing.BoxLayout(Pesaje, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane2.setDividerLocation(650);
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

        jSplitPane3.setDividerLocation(500);
        jSplitPane3.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);

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

        jSplitPane3.setTopComponent(jScrollPane4);

        jLabel4.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        jLabel4.setText("Total : ");

        totalLabel.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N

        jLabel1.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        jLabel1.setText("Peso Total:");

        pesoTotalLbl.setFont(new java.awt.Font("Tahoma", 0, 36)); // NOI18N
        pesoTotalLbl.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        pesoTotalLbl.setText("0.00");

        javax.swing.GroupLayout jPanel6Layout = new javax.swing.GroupLayout(jPanel6);
        jPanel6.setLayout(jPanel6Layout);
        jPanel6Layout.setHorizontalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel6Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 183, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(pesoTotalLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 150, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 123, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(totalLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 210, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(204, Short.MAX_VALUE))
        );
        jPanel6Layout.setVerticalGroup(
            jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel6Layout.createSequentialGroup()
                .addGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                    .addComponent(totalLabel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(pesoTotalLbl, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jLabel4, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(0, 0, Short.MAX_VALUE))
        );

        jSplitPane3.setBottomComponent(jPanel6);

        jPanel2.add(jSplitPane3);

        jSplitPane1.setRightComponent(jPanel2);

        jPanel4.add(jSplitPane1);

        jSplitPane2.setRightComponent(jPanel4);

        jScrollPane2.setMinimumSize(new java.awt.Dimension(631, 655));

        jPanel3.setMinimumSize(new java.awt.Dimension(629, 653));

        PanelRepartidor.setBorder(javax.swing.BorderFactory.createTitledBorder("Selecione el Cliente"));

        jLabel2.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        jLabel2.setText("Cliente:");

        clientesLov.setModel(new DefaultComboBoxModel(getClientes()));

        clienteTxt.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                clienteTxtKeyReleased(evt);
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
                .addComponent(clienteTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 235, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(clientesLov, javax.swing.GroupLayout.PREFERRED_SIZE, 207, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(22, Short.MAX_VALUE))
        );
        PanelRepartidorLayout.setVerticalGroup(
            PanelRepartidorLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanelRepartidorLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(PanelRepartidorLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(clientesLov, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(PanelRepartidorLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(clienteTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)))
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

        abrirCajaBtn.setText("Abrir caja");
        abrirCajaBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                abrirCajaBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout PanelCodigoBarrasLayout = new javax.swing.GroupLayout(PanelCodigoBarras);
        PanelCodigoBarras.setLayout(PanelCodigoBarrasLayout);
        PanelCodigoBarrasLayout.setHorizontalGroup(
            PanelCodigoBarrasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanelCodigoBarrasLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 97, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(barCodeTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 232, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(abrirCajaBtn)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        PanelCodigoBarrasLayout.setVerticalGroup(
            PanelCodigoBarrasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanelCodigoBarrasLayout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addGroup(PanelCodigoBarrasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 22, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(barCodeTxt)
                    .addComponent(abrirCajaBtn))
                .addContainerGap(26, Short.MAX_VALUE))
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
                .addGap(25, 25, 25)
                .addComponent(finalizarBtn)
                .addContainerGap(41, Short.MAX_VALUE))
        );

        jPanel5.setBorder(javax.swing.BorderFactory.createTitledBorder("Ingresar No. de Nota"));

        notaLabel.setText("No. de Nota:");

        notaTxt.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusLost(java.awt.event.FocusEvent evt) {
                notaTxtFocusLost(evt);
            }
        });
        notaTxt.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                notaTxtActionPerformed(evt);
            }
        });
        notaTxt.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                notaTxtKeyReleased(evt);
            }
        });

        javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addGap(56, 56, 56)
                .addComponent(notaLabel)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(notaTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 235, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(repartidorLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel5Layout.createSequentialGroup()
                .addGap(27, 27, 27)
                .addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(notaLabel)
                    .addComponent(notaTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(repartidorLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 20, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(56, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(PanelFinalizar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(PanelRepartidor, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(PanelCodigoBarras, javax.swing.GroupLayout.DEFAULT_SIZE, 610, Short.MAX_VALUE)
                            .addComponent(jPanel5, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addGap(0, 17, Short.MAX_VALUE)))
                .addContainerGap())
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(5, 5, 5)
                .addComponent(PanelRepartidor, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(23, 23, 23)
                .addComponent(PanelCodigoBarras, javax.swing.GroupLayout.PREFERRED_SIZE, 90, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(PanelFinalizar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        PanelRepartidor.getAccessibleContext().setAccessibleDescription("");

        jScrollPane2.setViewportView(jPanel3);

        jSplitPane2.setLeftComponent(jScrollPane2);

        Pesaje.add(jSplitPane2);

        add(Pesaje);
    }// </editor-fold>//GEN-END:initComponents

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
        recalcularPrecio();
        recalcularPeso();
    }//GEN-LAST:event_eliminarCajaBtnActionPerformed

    private void recalcularPrecio() {
        NumberFormat formatter = NumberFormat.getCurrencyInstance();
        String total = formatter.format(getTotalSeleccionado(productos));
        totalLabel.setText(total);
    }
    
    private void recalcularPeso(){
        BigDecimal pesoTotal = BigDecimal.ZERO;
        for(ProductosInventario producto: productos){
            pesoTotal = pesoTotal.add(producto.getPeso());
        }
        pesoTotalLbl.setText(pesoTotal.toString());
    }

    private void tablaProductos1MousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tablaProductos1MousePressed
        // TODO add your handling code here:
    }//GEN-LAST:event_tablaProductos1MousePressed

    private void clienteTxtKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_clienteTxtKeyReleased
        char c = evt.getKeyChar();

        if (!clienteTxt.getText().equals("")) {
            Clientes cliente = new Clientes();

            try {
                cliente = clienteDAO.getClienteXDescripcionOCodigo(clienteTxt.getText());
            } catch (Exception ex) {
                return;
            }

            clientesLov.setSelectedItem(cliente);

        }
    }//GEN-LAST:event_clienteTxtKeyReleased

    private void barCodeTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_barCodeTxtActionPerformed
        // TODO add your handling code here:

    }//GEN-LAST:event_barCodeTxtActionPerformed

    private void barCodeTxtKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_barCodeTxtKeyReleased

    }//GEN-LAST:event_barCodeTxtKeyReleased

    private void barCodeTxtKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_barCodeTxtKeyTyped
        if (evt.getKeyChar() == KeyEvent.VK_ENTER) {
            changeScanned(barCodeTxt.getText());
        }

    }//GEN-LAST:event_barCodeTxtKeyTyped

    private void changeScanned(String barCode) {
        ProductosInventario producto = null;
        List<Integer> codigos = new ArrayList<>();
        try {
            int x = 0;
            for (ProductosInventario productoInv : productos) {
                codigos.add(productoInv.getCodigo());
                x++;
            }
            producto = productoDAO.getProductosXCodigoBarrasActivos(barCode, codigos);

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
            recalcularPeso();
            recalcularPrecio();
        }
    }

    private boolean isProductoRepetido(DefaultTableModel model, ProductosInventario producto) {
        for (int count = 0; count < model.getRowCount(); count++) {
            if (producto.equals((ProductosInventario) model.getValueAt(count, 0))) {
                return true;
            }
        }
        return false;

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
            row[3] = producto.getPrecio();
            modelProductos.addRow(row);
        }
    }
    private void finalizarBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_finalizarBtnActionPerformed
        if (productos == null || productos.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Debe seleccionar algún producto");
            return;
        }

        if (clientesLov.getSelectedItem() == null) {
            JOptionPane.showMessageDialog(null, "Debe seleccionar un Cliente");
            return;
        }
        if (notaSeleccionada == null) {
            JOptionPane.showMessageDialog(null, "Debe seleccionar una nota");
            return;
        }
        int row = 0;
        for (ProductosInventario producto : productos) {
            notaSeleccionada.getProductosInventarios().add(producto);
            producto.setRepartidores(notaSeleccionada.getRepartidores());
            producto.setNotasDeVenta(notaSeleccionada);
            producto.setEstatus("vendido");
        }
        notaSeleccionada.setClientes((Clientes) clientesLov.getSelectedItem());
        notaSeleccionada.setEstatus("VENDIDA");
        notaSeleccionada.setTotal(this.getTotalSeleccionado(productos));
        notaSeleccionada.setFechaDeVenta(new Date());

        try {
            notasDAO.actualizarNotaDeVenta(notaSeleccionada);
            JOptionPane.showMessageDialog(null, "El producto se vendio correctamente");
            limpiar();
            imprimirNota(notaSeleccionada.getCodigo());
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, ex);
        }
        
    }//GEN-LAST:event_finalizarBtnActionPerformed

    private void imprimirNota(int notaDeVentaCodigo) throws Exception{
        path = reportDir + "planta/NotaDeVenta.jrxml";
        String jasperPath = reportDir+"planta/NotaDeVenta2.jasper";
        String subreportPath = reportDir+"planta/NotaDeVenta_subreport1";

        Properties prop = new Properties();
        String propFileName = "C:\\valco_installation\\conf\\valco.properties";

        InputStream inputStream = null;
            inputStream = new FileInputStream(propFileName);
       

        if (inputStream != null) {
            
                prop.load(inputStream);
            
        } else {
            
                throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
            
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
            
            Map mapa = new HashMap();

            System.out.println(reportDir);
            System.out.println(realPath);
            mapa.put("NOTA_DE_VENTA_CODIGO", notaDeVentaCodigo);
            mapa.put("SUBREPORT_DIR", reportDir + "/planta/");
            JasperCompileManager.compileReportToFile(subreportPath+".jrxml", subreportPath+".jasper");
            JasperCompileManager.compileReportToFile(realPath, jasperPath);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperPath, mapa, conn);
            JasperViewer.viewReport(jasperPrint, false);
            JasperPrintManager.printReport(jasperPrint, false);
        } catch (SQLException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JRException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void notaTxtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_notaTxtActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_notaTxtActionPerformed

    private void notaTxtKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_notaTxtKeyReleased
        // TODO add your handling code here:

    }//GEN-LAST:event_notaTxtKeyReleased

    private void notaTxtFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_notaTxtFocusLost
        try {
            // TODO add your handling code here:
            NotasDeVenta nota = notasDAO.getNotaDeVentaXFolio(new Integer(notaTxt.getText()));
            if (nota == null) {
                JOptionPane.showMessageDialog(null, "No se encontro la nota ingresada");
                notaSeleccionada = null;
                return;

            } else if (!"ASIGNADA".equals(nota.getEstatus())) {
                JOptionPane.showMessageDialog(null, "La nota de venta no esta disponible para realizar la venta");
                notaSeleccionada = null;
                return;

            } else {
                notaSeleccionada = nota;
                repartidorLabel.setText(notaSeleccionada.getRepartidores().getApellidoPaterno() + " " + notaSeleccionada.getRepartidores().getNombres());

            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurrio un error al verificar la nota");
            notaSeleccionada = null;
            return;
        }

    }//GEN-LAST:event_notaTxtFocusLost

    private void abrirCajaBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_abrirCajaBtnActionPerformed
        abrirCajaDlg.setModal(true);
        abrirCajaDlg.setVisible(true);
    }//GEN-LAST:event_abrirCajaBtnActionPerformed

    public void limpiar() {
        modelProductos.setRowCount(0);
        productos.clear();
    }

    private Object[] getClientes() {
        Object[] clientesArray = new Object[0];
        try {
            clientesArray = clienteDAO.getClientes().toArray();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error", ERROR_MESSAGE);
        }
        return clientesArray;
    }

    @Override
    public void updateAbrirCajaObserver(ProductosInventario producto) {
        productos.add(producto);
        setTableModel();
        recalcularPeso();
        recalcularPrecio();
    }
    
    public AbrirCajaPanel getAbrirCajaPanel() {
        return abrirCajaPanel;
    }

    public void setAbrirCajaPanel(AbrirCajaPanel abrirCajaPanel) {
        this.abrirCajaPanel = abrirCajaPanel;
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JPanel PanelCodigoBarras;
    private javax.swing.JPanel PanelFinalizar;
    private javax.swing.JPanel PanelRepartidor;
    private javax.swing.JPanel Pesaje;
    private javax.swing.JButton abrirCajaBtn;
    private javax.swing.JDialog abrirCajaDlg;
    private javax.swing.JTextField barCodeTxt;
    private javax.swing.JTextField clienteTxt;
    private javax.swing.JComboBox clientesLov;
    private javax.swing.JButton eliminarCajaBtn;
    private javax.swing.JButton finalizarBtn;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane4;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JSplitPane jSplitPane2;
    private javax.swing.JSplitPane jSplitPane3;
    private javax.swing.JLabel notaLabel;
    private javax.swing.JTextField notaTxt;
    private javax.swing.JLabel pesoTotalLbl;
    private javax.swing.JLabel repartidorLabel;
    private javax.swing.JTable tablaProductos1;
    private javax.swing.JLabel totalLabel;
    // End of variables declaration//GEN-END:variables


}
