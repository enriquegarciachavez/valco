/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import dao.ProductoDAO;
import java.util.List;
import mapping.ProductosInventario;
import mapping.Repartidores;

public class AsignacionServiceImpl implements TransactionService {

    private ProductoDAO productoDAO;
    
    @Override
    public void finalize(List<ProductosInventario> productos, Repartidores repartidor,
            String modoOperacion) throws Exception {
        if (productos == null || productos.isEmpty()) {
            throw new Exception("Debe seleccionar algún producto");
        }
        if (modoOperacion.equals("ENTRADA")) {
            for (ProductosInventario producto : productos) {
                producto.setEstatus("ACTIVO");
                producto.setRepartidores(null);
            }
            productoDAO.actualizarProductosInventario(productos);
        } else {
            if (repartidor == null) {
                throw new Exception("Debe seleccionar un repartidor");
            }
            for (ProductosInventario producto : productos) {
                producto.setEstatus("EN TRANSITO");
                producto.setRepartidores(repartidor);
            }
            productoDAO.actualizarProductosInventario(productos);
        }
    }

    public ProductoDAO getProductoDAO() {
        return productoDAO;
    }

    public void setProductoDAO(ProductoDAO productoDAO) {
        this.productoDAO = productoDAO;
    }
    
    

}
