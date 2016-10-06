/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.util.List;
import mapping.ProductosHasProveedores;
import mapping.ProductosHasProveedoresView;

/**
 *
 * @author Administrador
 */
public class ProductosUtility {
    
    public static ProductosHasProveedores getProductosHasProveedoresByBarCode(List<ProductosHasProveedoresView> productosHasProveedores, String barCode){
        for (ProductosHasProveedoresView productoProveedor: productosHasProveedores){
            if(barCode.length()> productoProveedor.getPosicionCodigoFinal() &&
                   barCode.length()> productoProveedor.getPosicionCodigoInicial() &&
                   barCode.length()> productoProveedor.getPosicionPesoFinal() &&
                    barCode.length()> productoProveedor.getPosicionPesoInicial() &&
                    productoProveedor.getPosicionCodigoFinal()> productoProveedor.getPosicionCodigoInicial()){
                String codigoProducto = barCode.substring(productoProveedor.getPosicionCodigoInicial(), productoProveedor.getPosicionCodigoFinal());
                System.out.println(codigoProducto + " "+ productoProveedor.getCodigoProveedor());
                if(codigoProducto.equals(productoProveedor.getCodigoProveedor())){
                    return productoProveedor.getProductoProveedor();
                    
                }
            }
        }
        return null;
            
        
    
}
    
}
