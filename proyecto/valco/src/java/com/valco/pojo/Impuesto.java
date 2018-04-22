/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;

/**
 *
 * @author Karla
 */
@XmlAccessorType(XmlAccessType.FIELD)
public class Impuesto {
    @XmlAttribute(name = "TotalImpuestosTrasladados")
    private BigDecimal totalImpuestosTrasladados;
    @XmlElementWrapper(namespace = "http://www.sat.gob.mx/cfd/3", name="Traslados")
    @XmlElement(namespace = "http://www.sat.gob.mx/cfd/3", name="Traslado")
    public List<Impuestos> impuestos = new ArrayList<>();

    public List<Impuestos> getImpuestos() {
        return impuestos;
    }

    public void setImpuestos(List<Impuestos> impuestos) {
        this.impuestos = impuestos;
    }

    public BigDecimal getTotalImpuestosTrasladados() {
        return totalImpuestosTrasladados;
    }

    public void setTotalImpuestosTrasladados(BigDecimal totalImpuestosTrasladados) {
        this.totalImpuestosTrasladados = totalImpuestosTrasladados;
    }
    
    
}
