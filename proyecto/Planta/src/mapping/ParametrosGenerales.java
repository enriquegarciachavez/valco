package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1



/**
 * ParametrosGenerales generated by hbm2java
 */
public class ParametrosGenerales  implements java.io.Serializable {


     private Integer codigo;
     private String estatus;
     private String clave;
     private String valor;

    public ParametrosGenerales() {
    }

    public ParametrosGenerales(String estatus, String clave, String valor) {
       this.estatus = estatus;
       this.clave = clave;
       this.valor = valor;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public String getEstatus() {
        return this.estatus;
    }
    
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
    public String getClave() {
        return this.clave;
    }
    
    public void setClave(String clave) {
        this.clave = clave;
    }
    public String getValor() {
        return this.valor;
    }
    
    public void setValor(String valor) {
        this.valor = valor;
    }




}


