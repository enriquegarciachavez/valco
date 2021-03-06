package com.valco.pojo;
// Generated 12/10/2015 09:38:41 PM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.Date;

/**
 * NotasCredito generated by hbm2java
 */
public class NotasCredito  implements java.io.Serializable {


     private Integer codigo;
     private Facturas factura;
     private Date fecha;
     private String observaciones;
     private String estatus;
     private String tipoNota;
     private BigDecimal cantidad;
     private Boolean devolucion;

    public NotasCredito() {
    }

	
    public NotasCredito(Facturas factura, Date fecha, BigDecimal cantidad) {
        this.factura = factura;
        this.fecha = fecha;
        this.cantidad = cantidad;
    }
    public NotasCredito(Facturas factura, Date fecha, String observaciones, String estatus, String tipoNota, BigDecimal cantidad, Boolean devolucion) {
       this.factura = factura;
       this.fecha = fecha;
       this.observaciones = observaciones;
       this.estatus = estatus;
       this.tipoNota = tipoNota;
       this.cantidad = cantidad;
       this.devolucion = devolucion;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public Date getFecha() {
        return this.fecha;
    }
    
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public String getObservaciones() {
        return this.observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    public String getEstatus() {
        return this.estatus;
    }
    
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
    public String getTipoNota() {
        return this.tipoNota;
    }
    
    public void setTipoNota(String tipoNota) {
        this.tipoNota = tipoNota;
    }
    public BigDecimal getCantidad() {
        return this.cantidad;
    }
    
    public void setCantidad(BigDecimal cantidad) {
        this.cantidad = cantidad;
    }
    public Boolean getDevolucion() {
        return this.devolucion;
    }
    
    public void setDevolucion(Boolean devolucion) {
        this.devolucion = devolucion;
    }

    public Facturas getFactura() {
        return factura;
    }

    public void setFactura(Facturas factura) {
        this.factura = factura;
    }




}


