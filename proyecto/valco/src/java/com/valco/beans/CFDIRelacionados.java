/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Karla
 */
@XmlAccessorType(XmlAccessType.FIELD)
public class CFDIRelacionados {
    @XmlAttribute (name="TipoRelacion")
    private String tipoRelacion;
    @XmlElement (namespace = "http://www.sat.gob.mx/cfd/3", name="CfdiRelacionado")
    private List<CFDIRelacionado> cdiRelacionado = new ArrayList<>();

    public String getTipoRelacion() {
        return tipoRelacion;
    }

    public void setTipoRelacion(String tipoRelacion) {
        this.tipoRelacion = tipoRelacion;
    }

    public List<CFDIRelacionado> getCdiRelacionado() {
        return cdiRelacionado;
    }

    public void setCdiRelacionado(List<CFDIRelacionado> cdiRelacionado) {
        this.cdiRelacionado = cdiRelacionado;
    }
    
    
    
}
