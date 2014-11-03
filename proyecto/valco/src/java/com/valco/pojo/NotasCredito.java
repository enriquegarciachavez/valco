package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * NotasCredito generated by hbm2java
 */
public class NotasCredito  implements java.io.Serializable {


     private Integer codigo;
     private Clientes clientes;
     private Date fecha;
     private String observaciones;
     private String estatus;

    public NotasCredito() {
    }

	
    public NotasCredito(Clientes clientes, Date fecha) {
        this.clientes = clientes;
        this.fecha = fecha;
    }
    public NotasCredito(Clientes clientes, Date fecha, String observaciones, String estatus) {
       this.clientes = clientes;
       this.fecha = fecha;
       this.observaciones = observaciones;
       this.estatus = estatus;
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




}


