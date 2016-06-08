/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author Karla
 */



public class ProductosInventarioAgrupados {
    BigDecimal peso;
    ProductosHasProveedores producto;
    ProductosHasProveedores productoModificado;
    BigDecimal precio;
    BigDecimal costo;
    BigDecimal precioModificado;
    List<ProductosInventario> productos;

    public BigDecimal getPeso() {
        return peso;
    }

    public void setPeso(BigDecimal peso) {
        this.peso = peso;
    }

    public BigDecimal getCosto() {
        return costo;
    }

    public void setCosto(BigDecimal costo) {
        this.costo = costo;
    }
    
    

    public ProductosHasProveedores getProducto() {
        return producto;
    }

    public void setProducto(ProductosHasProveedores producto) {
        this.producto = producto;
    }

    public ProductosHasProveedores getProductoModificado() {
        return productoModificado;
    }

    public void setProductoModificado(ProductosHasProveedores productoModificado) {
        this.productoModificado = productoModificado;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public BigDecimal getPrecioModificado() {
        return precioModificado;
    }

    public void setPrecioModificado(BigDecimal precioModificado) {
        this.precioModificado = precioModificado;
    }

    public List<ProductosInventario> getProductos() {
        return productos;
    }

    public void setProductos(List<ProductosInventario> productos) {
        this.productos = productos;
    }
    
    
}
