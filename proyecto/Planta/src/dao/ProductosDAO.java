/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;

/**
 *
 * @author Administrador
 */
public interface ProductosDAO {
    
    public ProductosInventario getProductoMaster(ProductosHasProveedores productoMaster) throws Exception;
    public ProductosInventario getProductoMaster(Productos productoMaster) throws Exception;
     public ProductosInventario getProductosXCodigoBarrasActivos(String codigo, Integer[] codigos) throws Exception;
    
}
