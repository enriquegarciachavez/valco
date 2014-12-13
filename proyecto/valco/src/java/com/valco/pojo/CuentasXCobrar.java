package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * CuentasXCobrar generated by hbm2java
 */
public class CuentasXCobrar  implements java.io.Serializable {


     private Integer codigo;
     private NotasDeVenta notasDeVenta;
     private Date fecha;
     private BigDecimal importe;
     private String observaciones;
     private String estatus;
     private Set<AbonosCuentasXCobrar> abonosCuentasXCobrars = new HashSet<AbonosCuentasXCobrar>(0);
     private Double importeAbonado;

    public CuentasXCobrar() {
    }

	
    public CuentasXCobrar(NotasDeVenta notasDeVenta, Date fecha, BigDecimal importe) {
        this.notasDeVenta = notasDeVenta;
        this.fecha = fecha;
        this.importe = importe;
    }
    public CuentasXCobrar(NotasDeVenta notasDeVenta, Date fecha, BigDecimal importe, String observaciones, String estatus, Set<AbonosCuentasXCobrar> abonosCuentasXCobrars) {
       this.notasDeVenta = notasDeVenta;
       this.fecha = fecha;
       this.importe = importe;
       this.observaciones = observaciones;
       this.estatus = estatus;
       this.abonosCuentasXCobrars = abonosCuentasXCobrars;
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
    public Date getFecha() {
        return this.fecha;
    }
    
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public BigDecimal getImporte() {
        return this.importe;
    }
    
    public void setImporte(BigDecimal importe) {
        this.importe = importe;
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
    public Set<AbonosCuentasXCobrar> getAbonosCuentasXCobrars() {
        return this.abonosCuentasXCobrars;
    }
    
    public void setAbonosCuentasXCobrars(Set<AbonosCuentasXCobrar> abonosCuentasXCobrars) {
        this.abonosCuentasXCobrars = abonosCuentasXCobrars;
    }

    public Double getImporteAbonado() {
        importeAbonado=0.0;
        for (AbonosCuentasXCobrar abono : abonosCuentasXCobrars) {
            
           if (abono.getEstatus().equals("ACTIVO")){
              importeAbonado+=abono.getImporte().doubleValue();        
            
            }
                
            
            
        }
        return importeAbonado;
    }
    

    public void setImporteAbonado(Double importeAbonado) {
        this.importeAbonado = importeAbonado;
    }
    
    




}


