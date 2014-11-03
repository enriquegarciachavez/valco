package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Productos generated by hbm2java
 */
public class Productos  implements java.io.Serializable {


     private Integer codigo;
     private TipoProducto tipoProducto;
     private UnidadesDeMedida unidadesDeMedida;
     private String descripcion;
     private boolean incluyeVicera;
     private boolean generarSubproducto;
     private boolean aplicaInventarioFisico;
     private String estatus;
     private Set<ProductosHasProveedores> productosHasProveedoreses = new HashSet<ProductosHasProveedores>(0);
     private Set<Productos> productosesForProductosCodigoHijo = new HashSet<Productos>(0);
     private Set<Productos> productosesForProductosCodigoPadre = new HashSet<Productos>(0);

    public Productos() {
    }

	
    public Productos(TipoProducto tipoProducto, UnidadesDeMedida unidadesDeMedida, String descripcion, boolean incluyeVicera, boolean generarSubproducto, boolean aplicaInventarioFisico) {
        this.tipoProducto = tipoProducto;
        this.unidadesDeMedida = unidadesDeMedida;
        this.descripcion = descripcion;
        this.incluyeVicera = incluyeVicera;
        this.generarSubproducto = generarSubproducto;
        this.aplicaInventarioFisico = aplicaInventarioFisico;
    }
    public Productos(TipoProducto tipoProducto, UnidadesDeMedida unidadesDeMedida, String descripcion, boolean incluyeVicera, boolean generarSubproducto, boolean aplicaInventarioFisico, String estatus, Set<ProductosHasProveedores> productosHasProveedoreses, Set<Productos> productosesForProductosCodigoHijo, Set<Productos> productosesForProductosCodigoPadre) {
       this.tipoProducto = tipoProducto;
       this.unidadesDeMedida = unidadesDeMedida;
       this.descripcion = descripcion;
       this.incluyeVicera = incluyeVicera;
       this.generarSubproducto = generarSubproducto;
       this.aplicaInventarioFisico = aplicaInventarioFisico;
       this.estatus = estatus;
       this.productosHasProveedoreses = productosHasProveedoreses;
       this.productosesForProductosCodigoHijo = productosesForProductosCodigoHijo;
       this.productosesForProductosCodigoPadre = productosesForProductosCodigoPadre;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public TipoProducto getTipoProducto() {
        return this.tipoProducto;
    }
    
    public void setTipoProducto(TipoProducto tipoProducto) {
        this.tipoProducto = tipoProducto;
    }
    public UnidadesDeMedida getUnidadesDeMedida() {
        return this.unidadesDeMedida;
    }
    
    public void setUnidadesDeMedida(UnidadesDeMedida unidadesDeMedida) {
        this.unidadesDeMedida = unidadesDeMedida;
    }
    public String getDescripcion() {
        return this.descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public boolean isIncluyeVicera() {
        return this.incluyeVicera;
    }
    
    public void setIncluyeVicera(boolean incluyeVicera) {
        this.incluyeVicera = incluyeVicera;
    }
    public boolean isGenerarSubproducto() {
        return this.generarSubproducto;
    }
    
    public void setGenerarSubproducto(boolean generarSubproducto) {
        this.generarSubproducto = generarSubproducto;
    }
    public boolean isAplicaInventarioFisico() {
        return this.aplicaInventarioFisico;
    }
    
    public void setAplicaInventarioFisico(boolean aplicaInventarioFisico) {
        this.aplicaInventarioFisico = aplicaInventarioFisico;
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
    public Set<Productos> getProductosesForProductosCodigoHijo() {
        return this.productosesForProductosCodigoHijo;
    }
    
    public void setProductosesForProductosCodigoHijo(Set<Productos> productosesForProductosCodigoHijo) {
        this.productosesForProductosCodigoHijo = productosesForProductosCodigoHijo;
    }
    public Set<Productos> getProductosesForProductosCodigoPadre() {
        return this.productosesForProductosCodigoPadre;
    }
    
    public void setProductosesForProductosCodigoPadre(Set<Productos> productosesForProductosCodigoPadre) {
        this.productosesForProductosCodigoPadre = productosesForProductosCodigoPadre;
    }




}


