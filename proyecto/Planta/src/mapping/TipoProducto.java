package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * TipoProducto generated by hbm2java
 */
public class TipoProducto  implements java.io.Serializable {


     private Integer codigo;
     private String descripcion;
     private String observaciones;
     private String estatus;
     private Set<Productos> productoses = new HashSet<Productos>(0);

    public TipoProducto() {
    }

	
    public TipoProducto(String descripcion, String estatus) {
        this.descripcion = descripcion;
        this.estatus = estatus;
    }
    public TipoProducto(String descripcion, String observaciones, String estatus, Set<Productos> productoses) {
       this.descripcion = descripcion;
       this.observaciones = observaciones;
       this.estatus = estatus;
       this.productoses = productoses;
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
    public Set<Productos> getProductoses() {
        return this.productoses;
    }
    
    public void setProductoses(Set<Productos> productoses) {
        this.productoses = productoses;
    }




}


