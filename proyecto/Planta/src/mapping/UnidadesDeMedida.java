package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * UnidadesDeMedida generated by hbm2java
 */
public class UnidadesDeMedida  implements java.io.Serializable {


     private Integer codigo;
     private String descripcion;
     private String abreviacion;
     private String estatus;
     private Set<Productos> productoses = new HashSet<Productos>(0);

    public UnidadesDeMedida() {
    }

	
    public UnidadesDeMedida(String descripcion, String abreviacion, String estatus) {
        this.descripcion = descripcion;
        this.abreviacion = abreviacion;
        this.estatus = estatus;
    }
    public UnidadesDeMedida(String descripcion, String abreviacion, String estatus, Set<Productos> productoses) {
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




}


