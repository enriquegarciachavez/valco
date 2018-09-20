/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listeners;

import components.CustomDropDown;
import dao.DAO;
import dao.FiltrableByFather;
import dao.ProveedoresDAO;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.ERROR_MESSAGE;
import javax.swing.JTextField;
import mapping.Proveedores;

/**
 *
 * @author Administrador
 */
public class CustomDropDownActionListener implements ActionListener{
    private JTextField txt;
    private JComboBox combo;
    private DAO dao;
    private CustomDropDown child;
    private CustomDropDown father;
    private FiltrableByFather daoFather;
    
    public CustomDropDownActionListener(JTextField txt, JComboBox combo, DAO dao,
                                        CustomDropDown child, CustomDropDown father,
                                        FiltrableByFather daoFather){
        this.txt = txt;
        this.combo = combo;
        this.dao = dao;
        this.child = child;
        this.father = father;
        this.daoFather = daoFather;
    } 
    

    @Override
    public void actionPerformed(ActionEvent e) {
        try {
            Object match = null;
            if (!txt.getText().equals("")) {
                if(father != null){
                    match = daoFather.getElementByFatherAndCriteria(father.getSelectedItem(),
                                                                    txt.getText());
                }else{
                    match =  dao.getElementsByCodeOrDesc(txt.getText());
                }
                if (match != null) {
                    combo.setSelectedItem(match);
                    if(child != null ){
                        child.filterByFather(match);
                    }
                    combo.repaint();
                }
            }

        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error", ERROR_MESSAGE);
        }
    }
    
}
