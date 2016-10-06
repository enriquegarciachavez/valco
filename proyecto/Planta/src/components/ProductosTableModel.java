/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package components;

import java.math.BigDecimal;
import java.util.Collection;
import mapping.ProductosInventario;

/**
 *
 * @author Administrador
 */
public interface ProductosTableModel {
    
    public void convertirProductos(Collection<ProductosInventario> productos);
    public Collection<ProductosInventario> eliminarProductos(int[] indices);
    public void agregarProducto(ProductosInventario producto);
    public Collection<ProductosInventario> getProductos();
    public BigDecimal getTotalSeleccionado();
    public void eliminarProductos();
    public Object getElementAt(int row, int column);
    
    
      
   
}
