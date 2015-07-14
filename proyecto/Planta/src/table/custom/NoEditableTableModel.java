/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.custom;

import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Karla
 */
public class NoEditableTableModel extends DefaultTableModel{
    
     @Override
     public boolean isCellEditable(int row, int column){  
          return false;  
      }
    
}
