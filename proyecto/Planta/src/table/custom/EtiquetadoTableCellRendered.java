/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.custom;

import components.CustomCellRendered;
import java.awt.Color;
import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;

/**
 *
 * @author Karla
 */
public class EtiquetadoTableCellRendered extends DefaultTableCellRenderer implements CustomCellRendered{
    private int estatusColumn ;

    @Override
    public Component getTableCellRendererComponent(JTable table,
            Object value, boolean isSelected, boolean hasFocus, int row, int col) {

        super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, col);

        String status = (String) table.getModel().getValueAt(row, estatusColumn);
        if ("CANCELADO".equals(status)) {
            setBackground(Color.RED);
            setForeground(table.getForeground());
        } else {
            setBackground(Color.GREEN);
            setForeground(table.getForeground());
        }

        if (table.isRowSelected(row)) {
            setBackground(Color.BLUE);
            setForeground(Color.WHITE);
        }

        return this;
    }

    public int getEstatusColumn() {
        return estatusColumn;
    }

    public void setEstatusColumn(int estatusColumn) {
        this.estatusColumn = estatusColumn;
    }
    
    

}
