package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * OrdenesCompra generated by hbm2java
 */
public class OrdenesCompra  implements java.io.Serializable {


     private Integer codigo;
     private Proveedores proveedores;
     private Usuarios usuarios;
     private Date fecha;
     private String observaciones;
     private BigDecimal total;
     private String estatus;
     private Set<CuentasXPagar> cuentasXPagars = new HashSet<CuentasXPagar>(0);
     private Set<ProductosInventario> productosInventarios = new HashSet<ProductosInventario>(0);

    public OrdenesCompra() {
    }

	
    public OrdenesCompra(Proveedores proveedores, Usuarios usuarios, Date fecha, BigDecimal total, String estatus) {
        this.proveedores = proveedores;
        this.usuarios = usuarios;
        this.fecha = fecha;
        this.total = total;
        this.estatus = estatus;
    }
    public OrdenesCompra(Proveedores proveedores, Usuarios usuarios, Date fecha, String observaciones, BigDecimal total, String estatus, Set<CuentasXPagar> cuentasXPagars, Set<ProductosInventario> productosInventarios) {
       this.proveedores = proveedores;
       this.usuarios = usuarios;
       this.fecha = fecha;
       this.observaciones = observaciones;
       this.total = total;
       this.estatus = estatus;
       this.cuentasXPagars = cuentasXPagars;
       this.productosInventarios = productosInventarios;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public Proveedores getProveedores() {
        return this.proveedores;
    }
    
    public void setProveedores(Proveedores proveedores) {
        this.proveedores = proveedores;
    }
    public Usuarios getUsuarios() {
        return this.usuarios;
    }
    
    public void setUsuarios(Usuarios usuarios) {
        this.usuarios = usuarios;
    }
    public Date getFecha() {
        return this.fecha;
    }
    
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public String getObservaciones() {
        return this.observaciones;
    }
    
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    public BigDecimal getTotal() {
        return this.total;
    }
    
    public void setTotal(BigDecimal total) {
        this.total = total;
    }
    public String getEstatus() {
        return this.estatus;
    }
    
    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }
    public Set<CuentasXPagar> getCuentasXPagars() {
        return this.cuentasXPagars;
    }
    
    public void setCuentasXPagars(Set<CuentasXPagar> cuentasXPagars) {
        this.cuentasXPagars = cuentasXPagars;
    }
    public Set<ProductosInventario> getProductosInventarios() {
        return this.productosInventarios;
    }
    
    public void setProductosInventarios(Set<ProductosInventario> productosInventarios) {
        this.productosInventarios = productosInventarios;
    }




}

