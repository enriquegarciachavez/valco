package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * NotasDeVenta generated by hbm2java
 */
public class NotasDeVenta implements java.io.Serializable {

    private Integer codigo;
    private Clientes clientes;
    private Facturas facturas;
    private Repartidores repartidores;
    private Usuarios usuarios;
    private int folio;
    private Date fechaDeVenta;
    private Integer flete;
    private String estatus;
    private Set<CuentasXCobrar> cuentasXCobrars = new HashSet<CuentasXCobrar>(0);
    private Set<ProductosInventario> productosInventarios = new HashSet<ProductosInventario>(0);
    private List<ProductosInventario> productosInventariosList = new ArrayList<ProductosInventario>(0);
    private CuentasXCobrar cuentaXCobrar;
    private BigDecimal total;

    public NotasDeVenta() {
    }

    public NotasDeVenta(Clientes clientes, Facturas facturas, Repartidores repartidores, Usuarios usuarios, int folio) {
        this.clientes = clientes;
        this.facturas = facturas;
        this.repartidores = repartidores;
        this.usuarios = usuarios;
        this.folio = folio;
    }

    public NotasDeVenta(Clientes clientes, Facturas facturas, Repartidores repartidores, Usuarios usuarios, int folio, Date fechaDeVenta, Integer flete, String estatus, Set<CuentasXCobrar> cuentasXCobrars, Set<ProductosInventario> productosInventarios) {
        this.clientes = clientes;
        this.facturas = facturas;
        this.repartidores = repartidores;
        this.usuarios = usuarios;
        this.folio = folio;
        this.fechaDeVenta = fechaDeVenta;
        this.flete = flete;
        this.estatus = estatus;
        this.cuentasXCobrars = cuentasXCobrars;
        this.productosInventarios = productosInventarios;
    }

    public Integer getCodigo() {
        return this.codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public Clientes getClientes() {
        return this.clientes;
    }

    public void setClientes(Clientes clientes) {
        this.clientes = clientes;
    }

    public Facturas getFacturas() {
        return this.facturas;
    }

    public void setFacturas(Facturas facturas) {
        this.facturas = facturas;
    }

    public Repartidores getRepartidores() {
        return this.repartidores;
    }

    public void setRepartidores(Repartidores repartidores) {
        this.repartidores = repartidores;
    }

    public Usuarios getUsuarios() {
        return this.usuarios;
    }

    public void setUsuarios(Usuarios usuarios) {
        this.usuarios = usuarios;
    }

    public int getFolio() {
        return this.folio;
    }

    public void setFolio(int folio) {
        this.folio = folio;
    }

    public Date getFechaDeVenta() {
        return this.fechaDeVenta;
    }

    public void setFechaDeVenta(Date fechaDeVenta) {
        this.fechaDeVenta = fechaDeVenta;
    }

    public Integer getFlete() {
        return this.flete;
    }

    public void setFlete(Integer flete) {
        this.flete = flete;
    }

    public String getEstatus() {
        return this.estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public Set<CuentasXCobrar> getCuentasXCobrars() {
        return this.cuentasXCobrars;
    }

    public void setCuentasXCobrars(Set<CuentasXCobrar> cuentasXCobrars) {
        this.cuentasXCobrars = cuentasXCobrars;
    }

    public Set<ProductosInventario> getProductosInventarios() {
        return this.productosInventarios;
    }

    public void setProductosInventarios(Set<ProductosInventario> productosInventarios) {
        this.productosInventarios = productosInventarios;
    }

    public List<ProductosInventario> getProductosInventariosList() {
        return productosInventariosList;
    }

    public void setProductosInventariosList(List<ProductosInventario> productosInventariosList) {
        this.productosInventariosList = productosInventariosList;
    }

    public CuentasXCobrar getCuentaXCobrar() {
        for (CuentasXCobrar cuenta : cuentasXCobrars) {
            if ("ACTIVO".equals(cuenta.getEstatus())) {
                this.cuentaXCobrar = cuenta;
                break;
            }
        }
        return this.cuentaXCobrar;
    }

    public void setCuentaXCobrar(CuentasXCobrar cuentaXCobrar) {
        this.cuentaXCobrar = cuentaXCobrar;
    }

    public BigDecimal getTotal() {
        total = new BigDecimal(0.00);
        total.setScale(2, RoundingMode.HALF_EVEN);
        for (ProductosInventario producto : this.getProductosInventarios()) {
            total = total.add(producto.getPeso().multiply(producto.getPrecio()));
        }
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

}
