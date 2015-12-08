package com.valco.pojo;
// Generated 29/11/2015 05:47:35 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Familias generated by hbm2java
 */
public class Familias  implements java.io.Serializable {


     private Integer codigo;
     private String descripcion;
     private String abreviacion;
     private String estatus;
     private Set<Subfamilias> subfamiliases = new HashSet<Subfamilias>(0);

    public Familias() {
    }

	
    public Familias(String descripcion, String abreviacion, String estatus) {
        this.descripcion = descripcion;
        this.abreviacion = abreviacion;
        this.estatus = estatus;
    }
    public Familias(String descripcion, String abreviacion, String estatus, Set<Subfamilias> subfamiliases) {
       this.descripcion = descripcion;
       this.abreviacion = abreviacion;
       this.estatus = estatus;
       this.subfamiliases = subfamiliases;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public String getDescripcion() {
        return this.descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public String getAbreviacion() {
        return this.abreviacion;
    }
    
    public void setAbreviacion(String abreviacion) {
        this.abreviacion = abreviacion;
    }
    public String getEstatus() {
        return this.estatus;
    }
    
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
    public Set<Subfamilias> getSubfamiliases() {
        return this.subfamiliases;
    }
    
    public void setSubfamiliases(Set<Subfamilias> subfamiliases) {
        this.subfamiliases = subfamiliases;
    }

     public String toString (){
         return this.descripcion;
     }
     
     public boolean equals(Object o){
         if (o == null|| !Familias.class.isInstance(o)|| ((Familias)o).getCodigo()!= this.getCodigo()){
             return false;       
             
         }else{
             return true;
         }
     }


}

