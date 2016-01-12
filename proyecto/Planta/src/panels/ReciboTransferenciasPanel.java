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
import java.awt.KeyboardFocusManager;
import java.awt.Point;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import keydispatchers.BarCodeScannerKeyDispatcher;
import mapping.ProductosInventario;
import mapping.Tranferencias;
import table.custom.NoEditableTableModel;

/**
 *
 * @author Administrador
 */
public class ReciboTransferenciasPanel extends javax.swing.JPanel {

    ProductoDAO productoDAO = new ProductoDAO();
    UbicacionesDAO ubicacionesDAO = new UbicacionesDAO();
    DefaultTableModel model = new NoEditableTableModel();
    List<ProductosInventario> productosList = new ArrayList<ProductosInventario>();
    KeyboardFocusManager manager;
    BarCodeScannerKeyDispatcher dispacher;
    public List<Component> exceptions = new ArrayList<>();
    private TransferenciasDAO transferenciasDao = new TransferenciasDAO();
    EnviosPanel enviosPanel = new EnviosPanel("RECIBO");
    Tranferencias transferenciaSeleccionada = new Tranferencias();

    /**
     * Creates new form ReciboTransferenciasPanel
     */
    public ReciboTransferenciasPanel() {
        initComponents();
        consultarTransferencias();
        pesajePanel.add(enviosPanel);
        jTabbedPane1.setEnabledAt(1, false);
    }

    public void consultarTransferencias() {
        List<Tranferencias> transferencias = new ArrayList<Tranferencias>();
        try {
            transferencias = transferenciasDao.getTransferencias();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage());
        }

        for (Tranferencias transferencia : transferencias) {
            Object[] row = new Object[8];

            row[0] = transferencia.getCodigo();
            row[1] = transferencia.getEstatus();
            row[2] = transferencia.getUbicacionesBySalida();
            row[3] = transferencia.getUbicacionesByDestino();
            row[4] = transferencia.getFechaEnvio();
            row[5] = transferencia.getFechaLlegada();
            row[6] = transferencia.getPesoTotal();
            row[7] = transferencia.getMermaTotal();

            model.addRow(row);
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

        jTabbedPane1 = new javax.swing.JTabbedPane();
        jPanel1 = new javax.swing.JPanel();
        jSplitPane1 = new javax.swing.JSplitPane();
        jPanel3 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        transferenciasTable = new javax.swing.JTable();
        jPanel4 = new javax.swing.JPanel();
        pesajePanel = new javax.swing.JPanel();

        setPreferredSize(new java.awt.Dimension(1394, 654));
        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        jPanel1.setLayout(new javax.swing.BoxLayout(jPanel1, javax.swing.BoxLayout.LINE_AXIS));

        jSplitPane1.setDividerLocation(100);
        jSplitPane1.setOrientation(javax.swing.JSplitPane.VERTICAL_SPLIT);

        jPanel3.setLayout(new javax.swing.BoxLayout(jPanel3, javax.swing.BoxLayout.LINE_AXIS));

        transferenciasTable.setModel(model);
        transferenciasTable.setSelectionMode(javax.swing.ListSelectionModel.SINGLE_SELECTION);
        String[] columnNames = {
            "Código",
            "Estátus",
            "Lugar de salida",
            "Lugar de recepcion",
            "Fecha de envio",
            "Fecha de llegada",
            "Peso total del envio",
            "Merma"};
        model.setColumnIdentifiers(columnNames); 
        transferenciasTable.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                transferenciasTableMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(transferenciasTable);

        jPanel3.add(jScrollPane1);

        jSplitPane1.setBottomComponent(jPanel3);

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 393, Short.MAX_VALUE)
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 0, Short.MAX_VALUE)
        );

        jSplitPane1.setLeftComponent(jPanel4);

        jPanel1.add(jSplitPane1);

        jTabbedPane1.addTab("Transferencias", jPanel1);

        pesajePanel.setLayout(new javax.swing.BoxLayout(pesajePanel, javax.swing.BoxLayout.LINE_AXIS));
        jTabbedPane1.addTab("Pesaje y escaneo", pesajePanel);

        add(jTabbedPane1);
        jTabbedPane1.getAccessibleContext().setAccessibleName("Transferencias");
    }// </editor-fold>//GEN-END:initComponents

    private void transferenciasTableMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_transferenciasTableMouseClicked
        JTable table = (JTable) evt.getSource();
        Point p = evt.getPoint();
        int row = table.rowAtPoint(p);
        if (evt.getClickCount() == 2) {
            try {
                transferenciaSeleccionada = transferenciasDao.getTransferenciaXCodigo((Integer) model.getValueAt(row, 0));
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex.getMessage());
            }
            enviosPanel.model.setRowCount(0);
            enviosPanel.setTransferenciaSeleccionada(transferenciaSeleccionada);
            for (ProductosInventario producto : transferenciaSeleccionada.getProductosInventarios()) {
                Object[] canal = new Object[6];

                canal[0] = producto.getPeso();
                canal[1] = producto.getProductosHasProveedores().getProveedores().getRazonSocial();
                canal[2] = producto;
                canal[3] = producto.getUbicaciones();
                canal[4] = producto.getEstatus();
                canal[5] = producto.getMermaTotal();

                enviosPanel.model.addRow(canal);
            }

            jTabbedPane1.setSelectedComponent(pesajePanel);
        }
    }//GEN-LAST:event_transferenciasTableMouseClicked


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JSplitPane jSplitPane1;
    private javax.swing.JTabbedPane jTabbedPane1;
    private javax.swing.JPanel pesajePanel;
    private javax.swing.JTable transferenciasTable;
    // End of variables declaration//GEN-END:variables
}
