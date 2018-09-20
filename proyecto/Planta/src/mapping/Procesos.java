package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Procesos generated by hbm2java
 */
public class Procesos implements java.io.Serializable {

    private Integer codigo;
    private char letra;
    private Integer numero;
    private Date fechaInicio;
    private Date fechaFin;
    private BigDecimal costoManoObra;
    private BigDecimal costosIndirectos;
    private BigDecimal sobranteHueso;
    private String sobranteSebo;
    private BigDecimal costoFlete;
    private String estatus;
    private String observaciones;
    private Set<ProductosInventario> productosHijos = new HashSet<ProductosInventario>(0);
    private Set<ProductosInventario> productosPadres = new HashSet<ProductosInventario>(0);

    public Procesos() {
    }

    public Procesos(char letra, Date fechaInicio, String estatus) {
        this.letra = letra;
        this.fechaInicio = fechaInicio;
        this.estatus = estatus;
    }

    public Procesos(char letra, Integer numero, Date fechaInicio, Date fechaFin, BigDecimal costoManoObra, BigDecimal costosIndirectos, BigDecimal sobranteHueso, String sobranteSebo, BigDecimal costoFlete, String estatus, Set<ProductosInventario> productosHijos) {
        this.letra = letra;
        this.numero = numero;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.costoManoObra = costoManoObra;
        this.costosIndirectos = costosIndirectos;
        this.sobranteHueso = sobranteHueso;
        this.sobranteSebo = sobranteSebo;
        this.costoFlete = costoFlete;
        this.estatus = estatus;
        this.productosHijos = productosHijos;
    }

    public Integer getCodigo() {
        return this.codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public char getLetra() {
        return this.letra;
    }

    public void setLetra(char letra) {
        this.letra = letra;
    }

    public Integer getNumero() {
        return this.numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    public Date getFechaInicio() {
        return this.fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return this.fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public BigDecimal getCostoManoObra() {
        return this.costoManoObra;
    }

    public void setCostoManoObra(BigDecimal costoManoObra) {
        this.costoManoObra = costoManoObra;
    }

    public BigDecimal getCostosIndirectos() {
        return this.costosIndirectos;
    }

    public void setCostosIndirectos(BigDecimal costosIndirectos) {
        this.costosIndirectos = costosIndirectos;
    }

    public BigDecimal getSobranteHueso() {
        return this.sobranteHueso;
    }

    public void setSobranteHueso(BigDecimal sobranteHueso) {
        this.sobranteHueso = sobranteHueso;
    }

    public String getSobranteSebo() {
        return this.sobranteSebo;
    }

    public void setSobranteSebo(String sobranteSebo) {
        this.sobranteSebo = sobranteSebo;
    }

    public BigDecimal getCostoFlete() {
        return this.costoFlete;
    }

    public void setCostoFlete(BigDecimal costoFlete) {
        this.costoFlete = costoFlete;
    }

    public String getEstatus() {
        return this.estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public Set<ProductosInventario> getProductosHijos() {
        return productosHijos;
    }

    public void setProductosHijos(Set<ProductosInventario> productosHijos) {
        this.productosHijos = productosHijos;
    }

    public Set<ProductosInventario> getProductosPadres() {
        return productosPadres;
    }

    public void setProductosPadres(Set<ProductosInventario> productosPadres) {
        this.productosPadres = productosPadres;
    }

    public BigDecimal getPesoSalida() {
        BigDecimal total = BigDecimal.ZERO;
        for (ProductosInventario prod : productosHijos) {
            if ("ACTIVO".equals(estatus)) {
                total = total.add(prod.getPeso());
            }
        }
        return total;
    }

    public String toString() {
        return this.getLetra() + String.valueOf(numero)
                + new SimpleDateFormat("yyyyMMdd").format(this.getFechaInicio())
                + " - " + observaciones;
    }

}
