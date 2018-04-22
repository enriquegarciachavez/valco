/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.math.BigDecimal;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;

/**
 *
 * @author Karla
 */
@XmlAccessorType(XmlAccessType.FIELD)
public class DocRelacionado {
    @XmlAttribute(name="IdDocumento")
    private String idDocumento;
    @XmlAttribute(name="Serie")
    private String serie;
    @XmlAttribute(name="Folio")
    private String folio;
    @XmlAttribute(name="MonedaDR")
    private String moneda;
    @XmlAttribute(name="TipoCambioDR")
    private String tipoCambio;
    @XmlAttribute(name="MetodoDePagoDR")
    private String metodoPago;
    @XmlAttribute(name="NumParcialidad")
    private Integer numParcialidad;
    @XmlAttribute(name="ImpSaldoAnt")
    private String impSaldoAnt;
    @XmlAttribute(name="ImpPagado")
    private BigDecimal impPagado;
    @XmlAttribute(name="ImpSaldoInsoluto")
    private String impSaldoInsoluto;

    public String getIdDocumento() {
        return idDocumento;
    }

    public void setIdDocumento(String idDocumento) {
        this.idDocumento = idDocumento;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getMoneda() {
        return moneda;
    }

    public void setMoneda(String moneda) {
        this.moneda = moneda;
    }

    public String getTipoCambio() {
        return tipoCambio;
    }

    public void setTipoCambio(String tipoCambio) {
        this.tipoCambio = tipoCambio;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public Integer getNumParcialidad() {
        return numParcialidad;
    }

    public void setNumParcialidad(Integer numParcialidad) {
        this.numParcialidad = numParcialidad;
    }

    public String getImpSaldoAnt() {
        return impSaldoAnt;
    }

    public void setImpSaldoAnt(String impSaldoAnt) {
        this.impSaldoAnt = impSaldoAnt;
    }

    public BigDecimal getImpPagado() {
        return impPagado;
    }

    public void setImpPagado(BigDecimal impPagado) {
        this.impPagado = impPagado;
    }

    

    public String getImpSaldoInsoluto() {
        return impSaldoInsoluto;
    }

    public void setImpSaldoInsoluto(String impSaldoInsoluto) {
        this.impSaldoInsoluto = impSaldoInsoluto;
    }

    
    
    
    
    
    
    
}
