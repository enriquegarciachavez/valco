package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1



/**
 * Telefonos generated by hbm2java
 */
public class Telefonos  implements java.io.Serializable {


     private Integer codigo;
     private Clientes clientes;
     private Proveedores proveedores;
     private String tipo;
     private int lada;
     private int numero;

    public Telefonos() {
    }

    public Telefonos(Clientes clientes, Proveedores proveedores, String tipo, int lada, int numero) {
       this.clientes = clientes;
       this.proveedores = proveedores;
       this.tipo = tipo;
       this.lada = lada;
       this.numero = numero;
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
    public Proveedores getProveedores() {
        return this.proveedores;
    }
    
    public void setProveedores(Proveedores proveedores) {
        this.proveedores = proveedores;
    }
    public String getTipo() {
        return this.tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public int getLada() {
        return this.lada;
    }
    
    public void setLada(int lada) {
        this.lada = lada;
    }
    public int getNumero() {
        return this.numero;
    }
    
    public void setNumero(int numero) {
        this.numero = numero;
    }




}


