package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * Movimientos generated by hbm2java
 */
public class Movimientos  implements java.io.Serializable {


     private Integer codigo;
     private Usuarios usuarios;
     private String descripcion;
     private Date fecha;

    public Movimientos() {
    }

    public Movimientos(Usuarios usuarios, String descripcion, Date fecha) {
       this.usuarios = usuarios;
       this.descripcion = descripcion;
       this.fecha = fecha;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public Usuarios getUsuarios() {
        return this.usuarios;
    }
    
    public void setUsuarios(Usuarios usuarios) {
        this.usuarios = usuarios;
    }
    public String getDescripcion() {
        return this.descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public Date getFecha() {
        return this.fecha;
    }
    
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }




}


