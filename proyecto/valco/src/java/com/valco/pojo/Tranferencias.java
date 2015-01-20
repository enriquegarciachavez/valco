package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

/**
 * Tranferencias generated by hbm2java
 */
public class Tranferencias  implements java.io.Serializable {


     private Integer codigo;
     private Ubicaciones ubicacionesBySalida;
     private Ubicaciones ubicacionesByDestino;
     private String estatus;
     Date fechaEnvio;
     Date fechaLlegada;
     Usuarios usuario;
     private Set<ProductosInventario> productosInventarios = new HashSet<ProductosInventario>(0);

    public Tranferencias() {
    }

	
    public Tranferencias(Ubicaciones ubicacionesBySalida, Ubicaciones ubicacionesByDestino, String estatus) {
        this.ubicacionesBySalida = ubicacionesBySalida;
        this.ubicacionesByDestino = ubicacionesByDestino;
        this.estatus = estatus;
    }
    public Tranferencias(Ubicaciones ubicacionesBySalida, Ubicaciones ubicacionesByDestino, String estatus, Set<ProductosInventario> productosInventarios) {
       this.ubicacionesBySalida = ubicacionesBySalida;
       this.ubicacionesByDestino = ubicacionesByDestino;
       this.estatus = estatus;
       this.productosInventarios = productosInventarios;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public Ubicaciones getUbicacionesBySalida() {
        return this.ubicacionesBySalida;
    }
    
    public void setUbicacionesBySalida(Ubicaciones ubicacionesBySalida) {
        this.ubicacionesBySalida = ubicacionesBySalida;
    }
    public Ubicaciones getUbicacionesByDestino() {
        return this.ubicacionesByDestino;
    }
    
    public void setUbicacionesByDestino(Ubicaciones ubicacionesByDestino) {
        this.ubicacionesByDestino = ubicacionesByDestino;
    }
    public String getEstatus() {
        return this.estatus;
    }
    
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public Date getFechaEnvio() {
        return fechaEnvio;
    }

    public void setFechaEnvio(Date fechaEnvio) {
        this.fechaEnvio = fechaEnvio;
    }

    public Date getFechaLlegada() {
        return fechaLlegada;
    }

    public void setFechaLlegada(Date fechaLlegada) {
        this.fechaLlegada = fechaLlegada;
    }

    public Usuarios getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuarios usuario) {
        this.usuario = usuario;
    }
    
    public Set<ProductosInventario> getProductosInventarios() {
        return this.productosInventarios;
    }
    
    public void setProductosInventarios(Set<ProductosInventario> productosInventarios) {
        this.productosInventarios = productosInventarios;
    }

     @Override
    public boolean equals(Object o){
         if( o != null){
             return (o instanceof Tranferencias) && (Objects.equals(((Tranferencias) o).getCodigo(), this.getCodigo()));
        }else{
            return false;
        }     
    }


}


