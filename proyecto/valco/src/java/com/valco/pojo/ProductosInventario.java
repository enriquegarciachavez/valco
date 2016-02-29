package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Objects;

/**
 * ProductosInventario generated by hbm2java
 */
public class ProductosInventario implements java.io.Serializable {

    private Integer codigo;
    private NotasDeVenta notasDeVenta;
    private OrdenesCompra ordenesCompra;
    private ProductosHasProveedores productosHasProveedores;
    private Tranferencias tranferencias;
    private Ubicaciones ubicaciones;
    private BigDecimal peso = new BigDecimal("0.00");
    private BigDecimal precio = new BigDecimal("0.00");
    private BigDecimal costo = new BigDecimal("0.00");
    private String codigoBarras;
    private String estatus;
    private Repartidores repartidor;
    private Boolean devuelto;
    private Boolean devolucionTotal;
    private Boolean malEstado;
    private BigDecimal cantidadDevuelta;

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public ProductosInventario() {
    }

    public ProductosInventario(NotasDeVenta notasDeVenta, OrdenesCompra ordenesCompra, ProductosHasProveedores productosHasProveedores, Tranferencias tranferencias, Ubicaciones ubicaciones, BigDecimal peso, BigDecimal precio) {
        this.notasDeVenta = notasDeVenta;
        this.ordenesCompra = ordenesCompra;
        this.productosHasProveedores = productosHasProveedores;
        this.tranferencias = tranferencias;
        this.ubicaciones = ubicaciones;
        this.peso = peso;
        this.precio = precio;
        this.peso.setScale(2, RoundingMode.HALF_EVEN);
        this.precio.setScale(2, RoundingMode.HALF_EVEN);
    }

    public ProductosInventario(NotasDeVenta notasDeVenta, OrdenesCompra ordenesCompra, ProductosHasProveedores productosHasProveedores, Tranferencias tranferencias, Ubicaciones ubicaciones, BigDecimal peso, BigDecimal precio, String codigoBarras) {
        this.notasDeVenta = notasDeVenta;
        this.ordenesCompra = ordenesCompra;
        this.productosHasProveedores = productosHasProveedores;
        this.tranferencias = tranferencias;
        this.ubicaciones = ubicaciones;
        this.peso = peso;
        this.precio = precio;
        this.codigoBarras = codigoBarras;
        this.peso.setScale(2, RoundingMode.HALF_EVEN);
        this.precio.setScale(2, RoundingMode.HALF_EVEN);
    }

    public Integer getCodigo() {
        return this.codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public NotasDeVenta getNotasDeVenta() {
        return this.notasDeVenta;
    }

    public void setNotasDeVenta(NotasDeVenta notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }

    public OrdenesCompra getOrdenesCompra() {
        return this.ordenesCompra;
    }

    public void setOrdenesCompra(OrdenesCompra ordenesCompra) {
        this.ordenesCompra = ordenesCompra;
    }

    public ProductosHasProveedores getProductosHasProveedores() {
        return this.productosHasProveedores;
    }

    public void setProductosHasProveedores(ProductosHasProveedores productosHasProveedores) {
        this.productosHasProveedores = productosHasProveedores;
    }

    public Tranferencias getTranferencias() {
        return this.tranferencias;
    }

    public void setTranferencias(Tranferencias tranferencias) {
        this.tranferencias = tranferencias;
    }

    public Ubicaciones getUbicaciones() {
        return this.ubicaciones;
    }

    public void setUbicaciones(Ubicaciones ubicaciones) {
        this.ubicaciones = ubicaciones;
    }

    public BigDecimal getPeso() {
        BigDecimal peso = new BigDecimal("0.00");
        RoundingMode RM = RoundingMode.HALF_EVEN;
        peso = peso.add(this.peso.setScale(2, RM));
        return peso;
    }

    public void setPeso(BigDecimal peso) {
        this.peso = peso;
    }

    public BigDecimal getPrecio() {
        BigDecimal precio = new BigDecimal("0.00");
        RoundingMode RM = RoundingMode.HALF_EVEN;
        precio = precio.add(this.precio.setScale(2, RM));
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public String getCodigoBarras() {
        return this.codigoBarras;
    }

    public void setCodigoBarras(String codigoBarras) {
        this.codigoBarras = codigoBarras;
    }

    public Repartidores getRepartidor() {
        return repartidor;
    }

    public void setRepartidor(Repartidores repartidor) {
        this.repartidor = repartidor;
    }

    @Override
    public boolean equals(Object o) {
        if (o != null) {
            if ((o instanceof ProductosInventario) && (((ProductosInventario) o).getCodigo() == this.getCodigo())) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public String toString() {
        String descripcion = "";
        descripcion += this.getProductosHasProveedores().getProductos().getDescripcion();
        descripcion += "    ";
        descripcion += this.getPeso();
        descripcion += " KG";
        return descripcion;
    }

    public Boolean getDevuelto() {
        return devuelto;
    }

    public void setDevuelto(Boolean devuelto) {
        this.devuelto = devuelto;
    }

    public Boolean getDevolucionTotal() {
        return devolucionTotal;
    }

    public void setDevolucionTotal(Boolean devolucionTotal) {
        this.devolucionTotal = devolucionTotal;
    }

    public Boolean getMalEstado() {
        return malEstado;
    }

    public void setMalEstado(Boolean malEstado) {
        this.malEstado = malEstado;
    }

    public BigDecimal getCantidadDevuelta() {
        return cantidadDevuelta;
    }

    public void setCantidadDevuelta(BigDecimal cantidadDevuelta) {
        this.cantidadDevuelta = cantidadDevuelta;
    }

    public BigDecimal getCosto() {
        return costo;
    }

    public void setCosto(BigDecimal costo) {
        this.costo = costo;
    }
    

}
