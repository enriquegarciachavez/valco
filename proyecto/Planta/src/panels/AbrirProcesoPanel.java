package panels;


import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import dao.ProcesosDAO;
import dao.ProductoDAO;
import java.awt.Component;
import java.awt.KeyEventDispatcher;
import java.awt.KeyboardFocusManager;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.DefaultListModel;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.ListModel;
import keydispatchers.BarCodeScannerKeyDispatcher;
import mapping.ProductosInventario;
import net.sf.click.extras.control.PickList;
import java.awt.event.KeyEvent;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import mapping.Procesos;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Karla
 */
public class AbrirProcesoPanel extends javax.swing.JPanel {
    ProductoDAO productoDAO = new ProductoDAO();
    ProcesosDAO procesosDAO = new ProcesosDAO();
    DefaultListModel lmDisponibles =new DefaultListModel();
    DefaultListModel lmSeleccionados =new DefaultListModel();
    KeyboardFocusManager manager;
    boolean modoEdicion = false;
    Set<ProductosInventario> toRemove = new HashSet<>();
    Set<ProductosInventario> toAdd = new HashSet<>();
    List<ProductosInventario> source = new ArrayList<>();
    List<ProductosInventario> destination = new ArrayList<>();
    Procesos procesoEdicion;
    BarCodeScannerKeyDispatcher dispacher;
    
    /**
     * Creates new form AbrirProcesoPanel
     */
    public AbrirProcesoPanel() {
        try {
            source = productoDAO.getCanalesDisponibles();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", ERROR_MESSAGE);
        }
        initComponents();
        manager = KeyboardFocusManager.getCurrentKeyboardFocusManager();
        dispacher= new BarCodeScannerKeyDispatcher(barCodeTxt, manager, observacionesTxt);
        manager.addKeyEventDispatcher(dispacher);
        
        
    }
    
    public AbrirProcesoPanel(Procesos proceso){
        try {
            source = productoDAO.getCanalesDisponibles();
            destination= procesosDAO.getCajasPorProcesoHijo(proceso.getCodigo());
            this.procesoEdicion= proceso;
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", ERROR_MESSAGE);
        }
        initComponents();
        manager = KeyboardFocusManager.getCurrentKeyboardFocusManager();
         dispacher= new BarCodeScannerKeyDispatcher(barCodeTxt, manager, observacionesTxt);
        manager.addKeyEventDispatcher(dispacher);
        modoEdicion= true;
       
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButton1 = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        disponiblesJList = new javax.swing.JList();
        jScrollPane2 = new javax.swing.JScrollPane();
        seleccionadosJList = new javax.swing.JList();
        seleccionarSelecBtn = new javax.swing.JButton();
        SeleccionarTodosBtn = new javax.swing.JButton();
        quitarTodosBtn = new javax.swing.JButton();
        quitarSelecBtn = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jScrollPane3 = new javax.swing.JScrollPane();
        observacionesTxt = new javax.swing.JTextArea();
        jLabel3 = new javax.swing.JLabel();
        jPanel3 = new javax.swing.JPanel();
        jLabel10 = new javax.swing.JLabel();
        jLabel11 = new javax.swing.JLabel();
        pesoLbl2 = new javax.swing.JLabel();
        jLabel12 = new javax.swing.JLabel();
        fechaLbl = new javax.swing.JLabel();
        barCodeTxt = new javax.swing.JTextField();

        jButton1.setText("Abrir proceso");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        disponiblesJList.setModel(lmDisponibles);
        try{
            for(Object elemento : productoDAO.getCanalesDisponibles()){
                lmDisponibles.addElement(elemento);
            }
        }catch(Exception e){

        }
        jScrollPane1.setViewportView(disponiblesJList);

        seleccionadosJList.setModel(lmSeleccionados);
        try{
            for(Object elemento : destination){
                lmSeleccionados.addElement(elemento);
            }
        }catch(Exception e){

        }
        jScrollPane2.setViewportView(seleccionadosJList);

        seleccionarSelecBtn.setText(">");
        seleccionarSelecBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                seleccionarSelecBtnActionPerformed(evt);
            }
        });

        SeleccionarTodosBtn.setText(">>");
        SeleccionarTodosBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                SeleccionarTodosBtnActionPerformed(evt);
            }
        });

        quitarTodosBtn.setText("<<");
        quitarTodosBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                quitarTodosBtnActionPerformed(evt);
            }
        });

        quitarSelecBtn.setText("<");
        quitarSelecBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                quitarSelecBtnActionPerformed(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setText("Producto Disponible");

        jLabel2.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel2.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel2.setText("Producto seleccionado");

        observacionesTxt.setColumns(20);
        observacionesTxt.setRows(5);
        jScrollPane3.setViewportView(observacionesTxt);

        jLabel3.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel3.setText("Observaciones");

        jPanel3.setBorder(javax.swing.BorderFactory.createTitledBorder("Resumen"));

        jLabel10.setText("Peso inicial");

        jLabel11.setText("Fecha de apertura");

        pesoLbl2.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        pesoLbl2.setText("0");
        pesoLbl2.setToolTipText("");

        jLabel12.setText("KG");

        fechaLbl.setText(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(62, 62, 62)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(pesoLbl2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jLabel10, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addGap(126, 126, 126)
                        .addComponent(jLabel11))
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jLabel12)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(fechaLbl)))
                .addContainerGap(43, Short.MAX_VALUE))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(21, 21, 21)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel10)
                    .addComponent(jLabel11))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(pesoLbl2)
                    .addComponent(jLabel12)
                    .addComponent(fechaLbl))
                .addContainerGap(26, Short.MAX_VALUE))
        );

        barCodeTxt.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyTyped(java.awt.event.KeyEvent evt) {
                barCodeTxtKeyTyped(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 420, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 420, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                .addComponent(jScrollPane3, javax.swing.GroupLayout.PREFERRED_SIZE, 420, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 105, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(SeleccionarTodosBtn, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(quitarTodosBtn, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(quitarSelecBtn, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(seleccionarSelecBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 49, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 417, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 417, javax.swing.GroupLayout.PREFERRED_SIZE))))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(401, 401, 401)
                        .addComponent(jButton1))
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(barCodeTxt, javax.swing.GroupLayout.PREFERRED_SIZE, 269, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(4, 4, 4))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                        .addGap(151, 151, 151)
                        .addComponent(seleccionarSelecBtn)
                        .addGap(18, 18, 18)
                        .addComponent(SeleccionarTodosBtn)
                        .addGap(18, 18, 18)
                        .addComponent(quitarTodosBtn)
                        .addGap(18, 18, 18)
                        .addComponent(quitarSelecBtn))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(barCodeTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel1)
                            .addComponent(jLabel2))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 322, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 296, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel3)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jScrollPane3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(jButton1)
                .addContainerGap(25, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void seleccionarSelecBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_seleccionarSelecBtnActionPerformed
        int[] indices = disponiblesJList.getSelectedIndices();
        for(int x = indices.length-1 ; x >= 0; x--){
            lmSeleccionados.addElement(lmDisponibles.getElementAt(indices[x]));
            if(!destination.contains(lmDisponibles.getElementAt(indices[x]))&& modoEdicion){
                toAdd.add((ProductosInventario) lmDisponibles.getElementAt(indices[x]));
                toRemove.remove( lmDisponibles.getElementAt(indices[x]));
            }
            lmDisponibles.removeElementAt(indices[x]);
        }
        actualizarPeso();
    }//GEN-LAST:event_seleccionarSelecBtnActionPerformed

    
    private void SeleccionarTodosBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_SeleccionarTodosBtnActionPerformed
        for(Object element : lmDisponibles.toArray()){
            lmSeleccionados.addElement(element);
            if(!destination.contains(element) && modoEdicion){
                toAdd.add((ProductosInventario) element);
                toRemove.remove(element);
            }
        }
        lmDisponibles.clear();
        actualizarPeso();
    }//GEN-LAST:event_SeleccionarTodosBtnActionPerformed

    private void quitarTodosBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_quitarTodosBtnActionPerformed
        for(Object element : lmSeleccionados.toArray()){
            lmDisponibles.addElement(element);
            if(!source.contains(element) && modoEdicion){
                toRemove.add((ProductosInventario) element);
                toAdd.remove(element);
            }
        }
        lmSeleccionados.clear();
        actualizarPeso();
    }//GEN-LAST:event_quitarTodosBtnActionPerformed

    private void quitarSelecBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_quitarSelecBtnActionPerformed
        int[] indices = seleccionadosJList.getSelectedIndices();
        for(int x = indices.length-1 ; x >= 0; x--){
            lmDisponibles.addElement(lmSeleccionados.getElementAt(indices[x]));
            if(!source.contains(lmSeleccionados.getElementAt(indices[x]))&& modoEdicion){
                toRemove.add((ProductosInventario) lmSeleccionados.getElementAt(indices[x]));
                toAdd.remove( lmSeleccionados.getElementAt(indices[x]));
            }
            lmSeleccionados.removeElementAt(indices[x]);
            
        }
        actualizarPeso();
    }//GEN-LAST:event_quitarSelecBtnActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        mapping.Procesos proceso = new mapping.Procesos();
        proceso.setFechaInicio(new Date());
        proceso.setEstatus("ACTIVO");
        proceso.setObservaciones(observacionesTxt.getText());
        try {
            proceso.setLetra(procesosDAO.getSiguienteLetra());
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurriò un error al abrir el proceso", "Error", ERROR_MESSAGE);
            return;
        }
        
        try {
            if(modoEdicion){
                procesosDAO.actualizarProceso(procesoEdicion, toAdd, toRemove);
              
            }else{
            procesosDAO.abrirProceso(proceso, lmSeleccionados.toArray());
            }
            
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurriò un error al abrir el proceso", "Error", ERROR_MESSAGE);
            return;
        }
        JOptionPane.showMessageDialog(null, "Se abrio el proceso correctamente", "Informacion", JOptionPane.INFORMATION_MESSAGE);
    }//GEN-LAST:event_jButton1ActionPerformed

    private void barCodeTxtKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_barCodeTxtKeyTyped
        if(evt.getKeyChar()== KeyEvent.VK_ENTER)
            {
                changeScanned(barCodeTxt.getText());
            }
    }//GEN-LAST:event_barCodeTxtKeyTyped

    private void changeScanned(String barCode){
        for(int x = 0 ; x < lmDisponibles.getSize(); x++){
            ProductosInventario producto = (ProductosInventario) lmDisponibles.getElementAt(x);
            if(barCode.equals(producto.getCodigoBarras())){
                lmSeleccionados.addElement(lmDisponibles.getElementAt(x));
                lmDisponibles.removeElementAt(x);
                actualizarPeso();
                return;
            }
        }
        
        for(int x = 0 ; x < lmSeleccionados.getSize(); x++){
            ProductosInventario producto = (ProductosInventario) lmSeleccionados.getElementAt(x);
            if(producto.getCodigoBarras().equals(barCode)){
                lmDisponibles.addElement(lmSeleccionados.getElementAt(x));
                lmSeleccionados.removeElementAt(x);
                actualizarPeso();
                return;
            }
        }

    }
    
    private void actualizarPeso(){
        BigDecimal pesoInicial = new BigDecimal("0.00");
        for (Object producto : lmSeleccionados.toArray()){
            pesoInicial= pesoInicial.add(((ProductosInventario)producto).getPeso());
        }
        pesoLbl2.setText(pesoInicial.toString());
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton SeleccionarTodosBtn;
    private javax.swing.JTextField barCodeTxt;
    private javax.swing.JList disponiblesJList;
    private javax.swing.JLabel fechaLbl;
    private javax.swing.JButton jButton1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JTextArea observacionesTxt;
    private javax.swing.JLabel pesoLbl2;
    private javax.swing.JButton quitarSelecBtn;
    private javax.swing.JButton quitarTodosBtn;
    private javax.swing.JList seleccionadosJList;
    private javax.swing.JButton seleccionarSelecBtn;
    // End of variables declaration//GEN-END:variables
}
