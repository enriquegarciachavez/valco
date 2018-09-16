/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package components;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.swing.JOptionPane;
import mapping.ProductosInventario;
import table.custom.NoEditableTableModel;

/**
 *
 * @author Administrador
 */
public class ProductosTableModelReetiquetado extends NoEditableTableModel implements ProductosTableModel {

    private List<ProductosInventario> productosInventario = new ArrayList<>();

    public ProductosTableModelReetiquetado() {
        String[] columnNames = {
            "Nombre",
            "Peso",
            "Etiqueta",
            "Estatus"
        };

        this.setColumnIdentifiers(columnNames);
    }

    @Override
    public void convertirProductos(Collection<ProductosInventario> productos) {
        int rowCount = this.getRowCount();
        //Remove rows one by one from the end of the table
        for (int i = rowCount - 1; i >= 0; i--) {
            this.removeRow(i);
        }

        for (ProductosInventario producto : productos) {
            Object[] row = new Object[4];
            row[0] = producto;
            row[1] = producto.getPeso();
            row[2] = producto.getCodigoBarras();
            row[3] = producto.getEstatus();

            this.addRow(row);
        }
    }

    @Override
    public Collection<ProductosInventario> eliminarProductos(int[] indices) {
        List<ProductosInventario> productosEliminados = new ArrayList<>();
        if (indices.length > 0) {
            for (int i = indices.length - 1; i >= 0; i--) {
                ProductosInventario productoEliminado = (ProductosInventario) this.getValueAt(indices[i], 0);
                this.productosInventario.remove(indices[i]);
                this.removeRow(indices[i]);
                productosEliminados.add(productoEliminado);
            }

        } else {
            JOptionPane.showMessageDialog(null, "No hay ningúna caja seleccionada.");
        }
        return productosEliminados;
    }

    @Override
    public void agregarProducto(ProductosInventario producto) {
        this.productosInventario.add(producto);
        Object[] row = new Object[4];
        row[0] = producto;
        row[1] = producto.getPeso();
        row[2] = producto.getCodigoBarras();
        row[3] = producto.getEstatus();

        this.addRow(row);

    }

    @Override
    public Collection<ProductosInventario> getProductos() {
        return this.productosInventario;
    }

    public List<ProductosInventario> getProductosInventario() {
        return productosInventario;
    }

    public void setProductosInventario(List<ProductosInventario> productosInventario) {
        this.productosInventario = productosInventario;
    }

    public BigDecimal getTotalSeleccionado() {
        DecimalFormat df = new DecimalFormat("0.00");
        BigDecimal total = new BigDecimal(BigInteger.ZERO, 2);
        total.setScale(2, BigDecimal.ROUND_HALF_UP);
        if (this.productosInventario != null && !this.productosInventario.isEmpty()) {
            for (ProductosInventario producto : this.productosInventario) {
                if (producto.getPeso() != null && producto.getPrecio() != null) {
                    total = total.add(producto.getPeso().multiply(producto.getPrecio()).setScale(2, RoundingMode.HALF_EVEN));
                } else {
                    JOptionPane.showMessageDialog(null, "Presione enter después de capturar un precio o un peso, de lo contrario el total podía no mostrarse bien");
                }
            }
        }
        return total;

    }
    
     @Override
    public void limpiar() {
        this.setRowCount(0);
        
    }
    
    @Override
    public Object getElementAt(int row, int column) {
        return this.getValueAt(row, column);
    }

}