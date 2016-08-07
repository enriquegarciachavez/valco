/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listeners;

import components.CustomDropDown;
import dao.DAO;
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
    
    public CustomDropDownActionListener(JTextField txt, JComboBox combo, DAO dao, CustomDropDown child){
        this.txt = txt;
        this.combo = combo;
        this.dao = dao;
        this.child = child; 
    } 
    

    @Override
    public void actionPerformed(ActionEvent e) {
        try {

            if (!txt.getText().equals("")) {
                Object object =  dao.getElementsByCodeOrDesc(txt.getText());
                if (object != null) {
                    combo.setSelectedItem(object);
                    if(child != null ){
                        child.filterByFather(object);
                    }
                    combo.repaint();
                }
            }

        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Ocurriò un error al consultar el proveedor", "Error", ERROR_MESSAGE);
        }
    }
    
}
