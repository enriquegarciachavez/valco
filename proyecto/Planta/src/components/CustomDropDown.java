/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package components;

import dao.DAO;
import dao.FiltrableByFather;
import dao.ProveedoresDAO;
import java.awt.event.ActionListener;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.JTextField;
import javax.swing.Timer;
import listeners.CustomDropDownActionListener;
import mapping.Proveedores;

/**
 *
 * @author Administrador
 */
public class CustomDropDown extends javax.swing.JPanel {

    private DAO dao;
    private Timer t;
    private CustomDropDown child;
    private FiltrableByFather daoFather;
    private String etiqueta;
    

    /**
     * Creates new form ProveedoresSelection
     */
    public void init() {
       
        initComponents();
        t = new Timer(800, new CustomDropDownActionListener(txt, combo, dao, child));

        t.setRepeats(false);
        if (etiqueta != null){
            label.setText(etiqueta);
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

        label = new javax.swing.JLabel();
        txt = new javax.swing.JTextField();
        combo = new javax.swing.JComboBox();

        label.setText("Elementos:");

        txt.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtActionPerformed(evt);
            }
        });
        txt.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtKeyReleased(evt);
            }
            public void keyTyped(java.awt.event.KeyEvent evt) {
                txtKeyTyped(evt);
            }
        });

        combo.setModel(new DefaultComboBoxModel(dao.getElementsArray()));

        combo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                comboActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(label)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(combo, javax.swing.GroupLayout.PREFERRED_SIZE, 135, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txt, javax.swing.GroupLayout.PREFERRED_SIZE, 135, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(24, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(label)
                    .addComponent(txt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(combo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    public void reloadChild (){
        child.filterByFather(this.getSelectedItem());
    }
    
    public Object getSelectedItem(){
        return combo.getSelectedItem();
    }
    
    public void setDao(DAO dao) {
        this.dao = dao;
    }

    public void setChild(CustomDropDown child) {
        this.child = child;
    }

    public void setDaoFather(FiltrableByFather daoFather) {
        this.daoFather = daoFather;
    }

     public void filterByFather(Object father){
          combo.setModel(new DefaultComboBoxModel(daoFather.getElementsByFatherArray(father)));
          combo.repaint();
          
     }  

    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    public JTextField getTxt() {
        return txt;
    }

    public CustomDropDown getChild() {
        return child;
    }
    
        
     

 


    private void txtActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtActionPerformed

    private void txtKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtKeyReleased
        // TODO add your handling code here:
        
        t.restart();

    }//GEN-LAST:event_txtKeyReleased

    private void txtKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtKeyTyped
        // TODO add your handling code here:
    }//GEN-LAST:event_txtKeyTyped

    private void comboActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_comboActionPerformed
        // TODO add your handling code here:

    }//GEN-LAST:event_comboActionPerformed

    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox combo;
    private javax.swing.JLabel label;
    private javax.swing.JTextField txt;
    // End of variables declaration//GEN-END:variables
}