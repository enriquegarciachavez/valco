package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1



/**
 * MetodosPago generated by hbm2java
 */
public class MetodosPago  implements java.io.Serializable {


     private Integer codigo;
     private String descripcion;
     private String estatus;

    public MetodosPago() {
    }

    public MetodosPago(String descripcion, String estatus) {
       this.descripcion = descripcion;
       this.estatus = estatus;
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
    public String getEstatus() {
        return this.estatus;
    }
    
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }




}


