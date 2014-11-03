package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Repartidores generated by hbm2java
 */
public class Repartidores  implements java.io.Serializable {


     private Integer codigo;
     private String apellidoPaterno;
     private String apellidoMaterno;
     private String nombres;
     private String estatus;
     private Set<NotasDeVenta> notasDeVentas = new HashSet<NotasDeVenta>(0);

    public Repartidores() {
    }

	
    public Repartidores(String apellidoPaterno, String nombres, String estatus) {
        this.apellidoPaterno = apellidoPaterno;
        this.nombres = nombres;
        this.estatus = estatus;
    }
    public Repartidores(String apellidoPaterno, String apellidoMaterno, String nombres, String estatus, Set<NotasDeVenta> notasDeVentas) {
       this.apellidoPaterno = apellidoPaterno;
       this.apellidoMaterno = apellidoMaterno;
       this.nombres = nombres;
       this.estatus = estatus;
       this.notasDeVentas = notasDeVentas;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public String getApellidoPaterno() {
        return this.apellidoPaterno;
    }
    
    public void setApellidoPaterno(String apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }
    public String getApellidoMaterno() {
        return this.apellidoMaterno;
    }
    
    public void setApellidoMaterno(String apellidoMaterno) {
        this.apellidoMaterno = apellidoMaterno;
    }
    public String getNombres() {
        return this.nombres;
    }
    
    public void setNombres(String nombres) {
        this.nombres = nombres;
    }
    public String getEstatus() {
        return this.estatus;
    }
    
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
    public Set<NotasDeVenta> getNotasDeVentas() {
        return this.notasDeVentas;
    }
    
    public void setNotasDeVentas(Set<NotasDeVenta> notasDeVentas) {
        this.notasDeVentas = notasDeVentas;
    }




}


