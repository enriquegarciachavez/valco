/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.Proveedores;

/**
 *
 * @author Karla
 */
public interface ProductosService {
    public ProductosHasProveedores armarProdHasProv(Productos producto, Proveedores proveedor);
}
