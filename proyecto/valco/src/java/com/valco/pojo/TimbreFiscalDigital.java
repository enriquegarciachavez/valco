/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;

/**
 *
 * @author Karla
 */
@XmlAccessorType(XmlAccessType.FIELD)
public class TimbreFiscalDigital {

    @XmlAttribute(name = "UUID")
    private String uuid;
    @XmlAttribute(name = "FechaTimbrado")
    private Date fechaTimbrado;
    @XmlAttribute(name = "SelloSAT")
    private String selloSat;
    @XmlAttribute(name = "NoCertificadoSAT")
    private String noCertificadoSat;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public Date getFechaTimbrado() {
        return fechaTimbrado;
    }

    public void setFechaTimbrado(Date fechaTimbrado) {
        this.fechaTimbrado = fechaTimbrado;
    }

    public String getSelloSat() {
        return selloSat;
    }

    public void setSelloSat(String selloSat) {
        this.selloSat = selloSat;
    }

    public String getNoCertificadoSat() {
        return noCertificadoSat;
    }

    public void setNoCertificadoSat(String noCertificadoSat) {
        this.noCertificadoSat = noCertificadoSat;
    }
    
    
}
