/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 *
 * @author Administrador
 */
public class InventarioGlobal {

    Integer productoCodigo;
    String descripcion;
    Integer numeroCajas;
    BigDecimal pesoTotal;
    BigDecimal precioTotal;
    String estatus;
    Set<InventarioDetallado> inventariosDetallados = new HashSet<InventarioDetallado>(0);
    

    public InventarioGlobal() {
    }
    

    public InventarioGlobal(Integer productoCodigo, String descripcion, Integer numeroCajas, BigDecimal pesoTotal, BigDecimal precioTotal, String estatus) {
        this.productoCodigo = productoCodigo;
        this.descripcion = descripcion;
        this.numeroCajas = numeroCajas;
        this.pesoTotal = pesoTotal;
        this.precioTotal = precioTotal;
        this.estatus = estatus;
    }
    
    public Integer getProductoCodigo() {
        return productoCodigo;
    }

    public void setProductoCodigo(Integer productoCodigo) {
        this.productoCodigo = productoCodigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Integer getNumeroCajas() {
        return numeroCajas;
    }

    public void setNumeroCajas(Integer numeroCajas) {
        this.numeroCajas = numeroCajas;
    }

    public BigDecimal getPesoTotal() {
        return pesoTotal;
    }

    public void setPesoTotal(BigDecimal pesoTotal) {
        this.pesoTotal = pesoTotal;
    }

    public BigDecimal getPrecioTotal() {
        return precioTotal;
    }

    public void setPrecioTotal(BigDecimal precioTotal) {
        this.precioTotal = precioTotal;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public Set<InventarioDetallado> getInventariosDetallados() {
        return inventariosDetallados;
    }

    public void setInventariosDetallados(Set<InventarioDetallado> inventariosDetallados) {
        this.inventariosDetallados = inventariosDetallados;
    }

    

    
    
    
    
    
}

