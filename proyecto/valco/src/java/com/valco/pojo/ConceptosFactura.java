package com.valco.pojo;
// Generated 8/02/2015 10:57:24 AM by Hibernate Tools 4.3.1

import com.valco.pojo.Facturas;
import java.math.BigDecimal;

/**
 * ConceptosFactura generated by hbm2java
 */
public class ConceptosFactura implements java.io.Serializable {

    private Integer codigo;
    private Facturas facturas;
    private BigDecimal cantidad;
    private int clave;
    private String descripcion;
    private String unidad;
    private BigDecimal precioUnitario;
    private BigDecimal importeTotal;

    public ConceptosFactura() {
    }

    public ConceptosFactura(Facturas facturas, BigDecimal cantidad, int clave, String descripcion, String unidad, BigDecimal precioUnitario, BigDecimal importeTotal) {
        this.facturas = facturas;
        this.cantidad = cantidad;
        this.clave = clave;
        this.descripcion = descripcion;
        this.unidad = unidad;
        this.precioUnitario = precioUnitario;
        this.importeTotal = importeTotal;
    }

    public Integer getCodigo() {
        return this.codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public Facturas getFacturas() {
        return this.facturas;
    }

    public void setFacturas(Facturas facturas) {
        this.facturas = facturas;
    }

    public BigDecimal getCantidad() {
        return this.cantidad;
    }

    public void setCantidad(BigDecimal cantidad) {
        this.cantidad = cantidad;
    }

    public int getClave() {
        return this.clave;
    }

    public void setClave(int clave) {
        this.clave = clave;
    }

    public String getDescripcion() {
        return this.descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getUnidad() {
        return this.unidad;
    }

    public void setUnidad(String unidad) {
        this.unidad = unidad;
    }

    public BigDecimal getPrecioUnitario() {
        return this.precioUnitario;
    }

    public void setPrecioUnitario(BigDecimal precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public BigDecimal getImporteTotal() {
        return this.importeTotal;
    }

    public void setImporteTotal(BigDecimal importeTotal) {
        this.importeTotal = importeTotal;
    }

    public boolean equals(Object o) {
        if (o != null) {
            if ((o instanceof ConceptosFactura) && (((ConceptosFactura) o).getClave()== this.getClave())) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    
    public int hashCode(){
        return this.clave;
    }

}
