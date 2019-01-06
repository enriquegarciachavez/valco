/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import mapping.Procesos;
import mapping.ProductosHasProveedores;
import mapping.ProductosHasProveedoresView;
import mapping.ProductosInventario;

/**
 *
 * @author Administrador
 */
public class ProductosUtility {

    public static ProductosHasProveedores getProductosHasProveedoresByBarCode(List<ProductosHasProveedoresView> productosHasProveedores, String barCode) {
        try {
            if(!ParametrosGeneralesUtility.getValor("CB001").equals("true")){
                return null;
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            //return null;
        }
        if (productosHasProveedores == null || barCode == null) {
            return null;

        }
        for (ProductosHasProveedoresView productoProveedor : productosHasProveedores) {
            if (barCode.length() > productoProveedor.getPosicionCodigoFinal()
                    && barCode.length() > productoProveedor.getPosicionCodigoInicial()
                    && barCode.length() > productoProveedor.getPosicionPesoFinal()
                    && barCode.length() > productoProveedor.getPosicionPesoInicial()
                    && productoProveedor.getPosicionCodigoFinal() > productoProveedor.getPosicionCodigoInicial()) {
                String codigoProducto = barCode.substring(productoProveedor.getPosicionCodigoInicial(), productoProveedor.getPosicionCodigoFinal());
                System.out.println(codigoProducto + " " + productoProveedor.getCodigoProveedor());
                if (codigoProducto.equals(productoProveedor.getCodigoProveedor())) {
                    productoProveedor.getProductoProveedor().getProveedores().setPosicionCodigoInicial(productoProveedor.getPosicionCodigoInicial());
                    productoProveedor.getProductoProveedor().getProveedores().setPosicionCodigoFinal(productoProveedor.getPosicionCodigoFinal());
                    productoProveedor.getProductoProveedor().getProveedores().setPosicionPesoInicial(productoProveedor.getPosicionPesoInicial());
                    productoProveedor.getProductoProveedor().getProveedores().setPosicionPesoFinal(productoProveedor.getPosicionPesoFinal());
                    return productoProveedor.getProductoProveedor();

                }
            }
        }
        return null;

    }

    public static ProductosInventario buildProductoFromBarCode(ProductosHasProveedores productoHasProveedor, String barCode) {
        if(productoHasProveedor == null || barCode ==null ){
            return null;
        }
            
        ProductosInventario productoInventario = new ProductosInventario();
        productoInventario.setProductosHasProveedores(productoHasProveedor);
        productoInventario.setUbicaciones(UsuarioFirmado.getUsuarioFirmado().getUbicaciones());
        String pesoString = barCode.substring(productoHasProveedor.getProveedores().getPosicionPesoInicial(), productoHasProveedor.getProveedores().getPosicionPesoFinal());
        pesoString = new StringBuffer(pesoString).insert(pesoString.length()-2, ".").toString();
        BigDecimal peso = new BigDecimal(pesoString);
        peso.setScale(2, RoundingMode.HALF_EVEN);
        productoInventario.setPeso(peso);
        productoInventario.setPrecio(productoHasProveedor.getPrecioSugerido());
        productoInventario.setEstatus("ACTIVO");
        productoInventario.setCodigoBarras(barCode);
        productoInventario.setFechaCreacion(new Date());
        return productoInventario;

    }
    
    public static String getCodigosCsv(List<ProductosInventario> productos){
        String codigos="(";
        for(ProductosInventario producto: productos){
            codigos+=producto.getCodigo()+",";
        }
        codigos = codigos.substring(0, codigos.length()-1);
        codigos+=")";
        System.out.println(codigos);
        return codigos;
    }

}
