package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.Objects;

/**
 * ProductosInventario generated by hbm2java
 */
public class ProductosInventario  implements java.io.Serializable {


     private Integer codigo;
     private NotasDeVenta notasDeVenta;
     private OrdenesCompra ordenesCompra;
     private ProductosHasProveedores productosHasProveedores;
     private Tranferencias tranferencias;
     private Ubicaciones ubicaciones;
     private BigDecimal peso;
     private BigDecimal precio;
     private String codigoBarras;
     private String estatus;
     private Repartidores repartidor;

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
        return this.peso;
    }
    
    public void setPeso(BigDecimal peso) {
        this.peso = peso;
    }
    public BigDecimal getPrecio() {
        return this.precio;
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
        if( o != null){
        if((o instanceof ProductosInventario) && (((ProductosInventario) o).getCodigo() == this.getCodigo())){
            return true;
        }else{
            return false;
           }
        }else{
            return false;
        }
    }




}


