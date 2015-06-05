package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.Date;

/**
 * ProductosInventario generated by hbm2java
 */
public class ProductosInventario  implements java.io.Serializable {


     private Integer codigo;
     private NotasDeVenta notasDeVenta;
     private OrdenesCompra ordenesCompra;
     private ProductosHasProveedores productosHasProveedores;
     private Repartidores repartidores;
     private Tranferencias tranferencias;
     private Ubicaciones ubicaciones;
     private BigDecimal peso;
     private BigDecimal precio;
     private String codigoBarras;
     private String estatus;
     private Integer procesosCodigoPadre;
     private Integer procesosCodigoHijo;
     private Date fechaCaducidad;
     private Integer numeroMatanza;

    public ProductosInventario() {
    }

	
    public ProductosInventario(OrdenesCompra ordenesCompra, ProductosHasProveedores productosHasProveedores, Ubicaciones ubicaciones, BigDecimal peso, BigDecimal precio, String estatus) {
        this.ordenesCompra = ordenesCompra;
        this.productosHasProveedores = productosHasProveedores;
        this.ubicaciones = ubicaciones;
        this.peso = peso;
        this.precio = precio;
        this.estatus = estatus;
    }
    public ProductosInventario(NotasDeVenta notasDeVenta, OrdenesCompra ordenesCompra, ProductosHasProveedores productosHasProveedores, Repartidores repartidores, Tranferencias tranferencias, Ubicaciones ubicaciones, BigDecimal peso, BigDecimal precio, String codigoBarras, String estatus, Integer procesosCodigoPadre, Integer procesosCodigoHijo, Date fechaCaducidad, Integer numeroMatanza) {
       this.notasDeVenta = notasDeVenta;
       this.ordenesCompra = ordenesCompra;
       this.productosHasProveedores = productosHasProveedores;
       this.repartidores = repartidores;
       this.tranferencias = tranferencias;
       this.ubicaciones = ubicaciones;
       this.peso = peso;
       this.precio = precio;
       this.codigoBarras = codigoBarras;
       this.estatus = estatus;
       this.procesosCodigoPadre = procesosCodigoPadre;
       this.procesosCodigoHijo = procesosCodigoHijo;
       this.fechaCaducidad = fechaCaducidad;
       this.numeroMatanza = numeroMatanza;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public NotasDeVenta getNotasDeVenta() {
        return this.notasDeVenta;
    }
    
    public void setNotasDeVenta(NotasDeVenta notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }
    public OrdenesCompra getOrdenesCompra() {
        return this.ordenesCompra;
    }
    
    public void setOrdenesCompra(OrdenesCompra ordenesCompra) {
        this.ordenesCompra = ordenesCompra;
    }
    public ProductosHasProveedores getProductosHasProveedores() {
        return this.productosHasProveedores;
    }
    
    public void setProductosHasProveedores(ProductosHasProveedores productosHasProveedores) {
        this.productosHasProveedores = productosHasProveedores;
    }
    public Repartidores getRepartidores() {
        return this.repartidores;
    }
    
    public void setRepartidores(Repartidores repartidores) {
        this.repartidores = repartidores;
    }
    public Tranferencias getTranferencias() {
        return this.tranferencias;
    }
    
    public void setTranferencias(Tranferencias tranferencias) {
        this.tranferencias = tranferencias;
    }
    public Ubicaciones getUbicaciones() {
        return this.ubicaciones;
    }
    
    public void setUbicaciones(Ubicaciones ubicaciones) {
        this.ubicaciones = ubicaciones;
    }
    public BigDecimal getPeso() {
        return this.peso;
    }
    
    public void setPeso(BigDecimal peso) {
        this.peso = peso;
    }
    public BigDecimal getPrecio() {
        return this.precio;
    }
    
    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }
    public String getCodigoBarras() {
        return this.codigoBarras;
    }
    
    public void setCodigoBarras(String codigoBarras) {
        this.codigoBarras = codigoBarras;
    }
    public String getEstatus() {
        return this.estatus;
    }
    
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
    public Integer getProcesosCodigoPadre() {
        return this.procesosCodigoPadre;
    }
    
    public void setProcesosCodigoPadre(Integer procesosCodigoPadre) {
        this.procesosCodigoPadre = procesosCodigoPadre;
    }
    public Integer getProcesosCodigoHijo() {
        return this.procesosCodigoHijo;
    }
    
    public void setProcesosCodigoHijo(Integer procesosCodigoHijo) {
        this.procesosCodigoHijo = procesosCodigoHijo;
    }
    public Date getFechaCaducidad() {
        return this.fechaCaducidad;
    }
    
    public void setFechaCaducidad(Date fechaCaducidad) {
        this.fechaCaducidad = fechaCaducidad;
    }
    public Integer getNumeroMatanza() {
        return this.numeroMatanza;
    }
    
    public void setNumeroMatanza(Integer numeroMatanza) {
        this.numeroMatanza = numeroMatanza;
    }

    public String toString(){
        String descripcion = "";
        descripcion +=  this.getProductosHasProveedores().getProductos().getDescripcion();
        descripcion += "    ";
        descripcion += this.getPeso();
        descripcion += " KG";
        return descripcion;
    }


}


