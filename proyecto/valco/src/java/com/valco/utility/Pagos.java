/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.utility;

import com.valco.pojo.AbonosCuentasXCobrar;
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
public class Pagos {
    @XmlAttribute (name="Version")    
    private String version;
    @XmlElement(name="Pago", namespace = "http://www.sat.gob.mx/Pagos")
    private List<AbonosCuentasXCobrar> pagos;

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public List<AbonosCuentasXCobrar> getPagos() {
        return pagos;
    }

    public void setPagos(List<AbonosCuentasXCobrar> pagos) {
        this.pagos = pagos;
    }
    
    
    
}
