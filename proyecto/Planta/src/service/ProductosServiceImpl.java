/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import dao.ProductoDAO;
import dao.ProductosHasProveedoresDao;
import javax.swing.JOptionPane;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.Proveedores;


public class ProductosServiceImpl implements ProductosService {
    private ProductoDAO productoDAO;
    private ProductosHasProveedoresDao pHasPro;
    
    @Override
    public ProductosHasProveedores armarProdHasProv(Productos producto, Proveedores proveedor){
        ProductosHasProveedores productoHasProveedor = null;
        try {
            productoHasProveedor = productoDAO.getProductosXProveedorYProducto(proveedor, producto.getCodigo());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        if (productoHasProveedor == null) {
            productoHasProveedor = new ProductosHasProveedores();
            productoHasProveedor.setProveedores(proveedor);
            productoHasProveedor.setProductos(producto);
            productoHasProveedor.setPrecioSugerido(producto.getPrecioSugerido());
            productoHasProveedor.setCodigoProveedor(producto.getCodigo().toString());
            try {
                pHasPro.insertarProductosHasProveedores(productoHasProveedor);
            } catch (Exception ex1) {
                JOptionPane.showMessageDialog(null, ex1);
            }
        } else {
            System.out.println("Obviamente si encontro el valor");
        }
        return productoHasProveedor;
    }

    public ProductoDAO getProductoDAO() {
        return productoDAO;
    }

    public void setProductoDAO(ProductoDAO productoDAO) {
        this.productoDAO = productoDAO;
    }

    public ProductosHasProveedoresDao getpHasPro() {
        return pHasPro;
    }

    public void setpHasPro(ProductosHasProveedoresDao pHasPro) {
        this.pHasPro = pHasPro;
    }
    
    
}
