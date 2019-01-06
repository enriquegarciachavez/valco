package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Proveedores generated by hbm2java
 */
public class Proveedores  implements java.io.Serializable {


     private Integer codigo;
     private String razonSocial;
     private String apellidoPaterno;
     private String apellidoMaterno;
     private String nombres;
     private String direccion;
     private String ciudad;
     private String estado;
     private Integer codigoPostal;
     private String rfc;
     private int posicionPesoInicial;
     private int posicionPesoFinal;
     private int posicionCodigoInicial;
     private int posicionCodigoFinal;
     private String estatus;
     private Set<ProductosHasProveedores> productosHasProveedoreses = new HashSet<ProductosHasProveedores>(0);
     private Set<Telefonos> telefonoses = new HashSet<Telefonos>(0);
     private Set<OrdenesCompra> ordenesCompras = new HashSet<OrdenesCompra>(0);
     private Set<ProveedoresCodigo> proveedoresCodigos = new HashSet<ProveedoresCodigo>(0);

    public Proveedores() {
    }

	
    public Proveedores(String razonSocial, String apellidoPaterno, String nombres, String direccion, String ciudad, String estado, int posicionPesoInicial, int posicionPesoFinal, int posicionCodigoInicial, int posicionCodigoFinal, String estatus) {
        this.razonSocial = razonSocial;
        this.apellidoPaterno = apellidoPaterno;
        this.nombres = nombres;
        this.direccion = direccion;
        this.ciudad = ciudad;
        this.estado = estado;
        this.posicionPesoInicial = posicionPesoInicial;
        this.posicionPesoFinal = posicionPesoFinal;
        this.posicionCodigoInicial = posicionCodigoInicial;
        this.posicionCodigoFinal = posicionCodigoFinal;
        this.estatus = estatus;
    }
    public Proveedores(String razonSocial, String apellidoPaterno, String apellidoMaterno, String nombres, String direccion, String ciudad, String estado, Integer codigoPostal, String rfc, int posicionPesoInicial, int posicionPesoFinal, int posicionCodigoInicial, int posicionCodigoFinal, String estatus, Set<ProductosHasProveedores> productosHasProveedoreses, Set<Telefonos> telefonoses, Set<OrdenesCompra> ordenesCompras) {
       this.razonSocial = razonSocial;
       this.apellidoPaterno = apellidoPaterno;
       this.apellidoMaterno = apellidoMaterno;
       this.nombres = nombres;
       this.direccion = direccion;
       this.ciudad = ciudad;
       this.estado = estado;
       this.codigoPostal = codigoPostal;
       this.rfc = rfc;
       this.posicionPesoInicial = posicionPesoInicial;
       this.posicionPesoFinal = posicionPesoFinal;
       this.posicionCodigoInicial = posicionCodigoInicial;
       this.posicionCodigoFinal = posicionCodigoFinal;
       this.estatus = estatus;
       this.productosHasProveedoreses = productosHasProveedoreses;
       this.telefonoses = telefonoses;
       this.ordenesCompras = ordenesCompras;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public String getRazonSocial() {
        return this.razonSocial;
    }
    
    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
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
    public String getDireccion() {
        return this.direccion;
    }
    
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    public String getCiudad() {
        return this.ciudad;
    }
    
    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }
    public String getEstado() {
        return this.estado;
    }
    
    public void setEstado(String estado) {
        this.estado = estado;
    }
    public Integer getCodigoPostal() {
        return this.codigoPostal;
    }
    
    public void setCodigoPostal(Integer codigoPostal) {
        this.codigoPostal = codigoPostal;
    }
    public String getRfc() {
        return this.rfc;
    }
    
    public void setRfc(String rfc) {
        this.rfc = rfc;
    }
    public int getPosicionPesoInicial() {
        return this.posicionPesoInicial;
    }
    
    public void setPosicionPesoInicial(int posicionPesoInicial) {
        this.posicionPesoInicial = posicionPesoInicial;
    }
    public int getPosicionPesoFinal() {
        return this.posicionPesoFinal;
    }
    
    public void setPosicionPesoFinal(int posicionPesoFinal) {
        this.posicionPesoFinal = posicionPesoFinal;
    }
    public int getPosicionCodigoInicial() {
        return this.posicionCodigoInicial;
    }
    
    public void setPosicionCodigoInicial(int posicionCodigoInicial) {
        this.posicionCodigoInicial = posicionCodigoInicial;
    }
    public int getPosicionCodigoFinal() {
        return this.posicionCodigoFinal;
    }
    
    public void setPosicionCodigoFinal(int posicionCodigoFinal) {
        this.posicionCodigoFinal = posicionCodigoFinal;
    }
    public String getEstatus() {
        return this.estatus;
    }
    
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
    public Set<ProductosHasProveedores> getProductosHasProveedoreses() {
        return this.productosHasProveedoreses;
    }
    
    public void setProductosHasProveedoreses(Set<ProductosHasProveedores> productosHasProveedoreses) {
        this.productosHasProveedoreses = productosHasProveedoreses;
    }
    public Set<Telefonos> getTelefonoses() {
        return this.telefonoses;
    }
    
    public void setTelefonoses(Set<Telefonos> telefonoses) {
        this.telefonoses = telefonoses;
    }
    public Set<OrdenesCompra> getOrdenesCompras() {
        return this.ordenesCompras;
    }
    
    public void setOrdenesCompras(Set<OrdenesCompra> ordenesCompras) {
        this.ordenesCompras = ordenesCompras;
    }

    public Set<ProveedoresCodigo> getProveedoresCodigos() {
        return proveedoresCodigos;
    }

    public void setProveedoresCodigos(Set<ProveedoresCodigo> proveedoresCodigos) {
        this.proveedoresCodigos = proveedoresCodigos;
    }

    public String toString(){
        return this.getRazonSocial() + " - " + this.getNombres();
    }
    
    @Override
    public boolean equals(Object o) {
        if( o != null){
        if((o instanceof Proveedores) && (((Proveedores) o).getCodigo().equals(this.getCodigo()))){
            return true;
        }else{
            return false;
           }
        }else{
            return false;
        }
    }


}


