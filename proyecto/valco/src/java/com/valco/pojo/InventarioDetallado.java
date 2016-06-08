/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.math.BigDecimal;

/**
 *
 * @author Administrador
 */
public class InventarioDetallado {
    
    Integer productoCodigoDetallado;
    String descripcion;
    BigDecimal peso;
    BigDecimal precioUnitario;
    BigDecimal precioTotal;
    String codigoBarras;
    String estatus;
    Integer inventarioGlobalCodigo;

    public InventarioDetallado() {
    }

    public InventarioDetallado(Integer productoCodigoDetallado, String descripcion, BigDecimal peso, BigDecimal precioUnitario, BigDecimal precioTotal, String codigoBarras, String estatus, Integer inventarioGlobalCodigo) {
        this.productoCodigoDetallado = productoCodigoDetallado;
        this.descripcion = descripcion;
        this.peso = peso;
        this.precioUnitario = precioUnitario;
        this.precioTotal = precioTotal;
        this.codigoBarras = codigoBarras;
        this.estatus = estatus;
        this.inventarioGlobalCodigo = inventarioGlobalCodigo;
    }

    

    public Integer getProductoCodigoDetallado() {
        return productoCodigoDetallado;
    }

    public void setProductoCodigoDetallado(Integer productoCodigoDetallado) {
        this.productoCodigoDetallado = productoCodigoDetallado;
    }

    
    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descrpcion) {
        this.descripcion = descrpcion;
    }

    public BigDecimal getPeso() {
        return peso;
    }

    public void setPeso(BigDecimal peso) {
        this.peso = peso;
    }

    public BigDecimal getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(BigDecimal precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public BigDecimal getPrecioTotal() {
        return precioTotal;
    }

    public void setPrecioTotal(BigDecimal precioTotal) {
        this.precioTotal = precioTotal;
    }

    public String getCodigoBarras() {
        return codigoBarras;
    }

    public void setCodigoBarras(String codigoBarras) {
        this.codigoBarras = codigoBarras;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public Integer getInventarioGlobalCodigo() {
        return inventarioGlobalCodigo;
    }

    public void setInventarioGlobalCodigo(Integer inventarioGlobalCodigo) {
        this.inventarioGlobalCodigo = inventarioGlobalCodigo;
    }
    
    
    
    
    
    
}
