package com.valco.pojo;
// Generated 29/11/2015 05:47:35 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Subfamilias generated by hbm2java
 */
public class Subfamilias  implements java.io.Serializable {


     private Integer codigo;
     private Familias familias;
     private String descripcion;
     private String abreviacion;
     private String estatus;
     private Set<Productos> productoses = new HashSet<Productos>(0);

    public Subfamilias() {
    }

	
    public Subfamilias(Familias familias, String descripcion, String abreviacion, String estatus) {
        this.familias = familias;
        this.descripcion = descripcion;
        this.abreviacion = abreviacion;
        this.estatus = estatus;
    }
    public Subfamilias(Familias familias, String descripcion, String abreviacion, String estatus, Set<Productos> productoses) {
       this.familias = familias;
       this.descripcion = descripcion;
       this.abreviacion = abreviacion;
       this.estatus = estatus;
       this.productoses = productoses;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public Familias getFamilias() {
        return this.familias;
    }
    
    public void setFamilias(Familias familias) {
        this.familias = familias;
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
    public Set<Productos> getProductoses() {
        return this.productoses;
    }
    
    public void setProductoses(Set<Productos> productoses) {
        this.productoses = productoses;
    }

    public boolean equals(Object o){
         if (o == null|| !Subfamilias.class.isInstance(o)|| ((Subfamilias)o).getCodigo()!= this.getCodigo()){
             return false;       
             
         }else{
             return true;
         }
     }


}


