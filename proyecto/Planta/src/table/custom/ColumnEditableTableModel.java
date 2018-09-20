/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.custom;

import java.util.List;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Karla
 */
public class ColumnEditableTableModel extends DefaultTableModel {

    private List<Integer> columns;

    @Override
    public boolean isCellEditable(int row, int column) {
        if (columns.contains(column)) {
            return true;
        }
        return false;
    }

    public List<Integer> getColumns() {
        return columns;
    }

    public void setColumns(List<Integer> columns) {
        this.columns = columns;
    }
}
