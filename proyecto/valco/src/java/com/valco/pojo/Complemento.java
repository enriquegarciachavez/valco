/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import com.valco.utility.Pagos;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Karla
 */

@XmlAccessorType(XmlAccessType.FIELD)
public class Complemento {
    
    @XmlElement(namespace = "http://www.sat.gob.mx/Pagos", name="Pagos")
    private Pagos pagos;
    @XmlElement(namespace = "http://www.sat.gob.mx/TimbreFiscalDigital", name = "TimbreFiscalDigital")
    private TimbreFiscalDigital timbreFiscalDigital;

    public Pagos getPagos() {
        return pagos;
    }

    public void setPagos(Pagos pagos) {
        this.pagos = pagos;
    }

    public TimbreFiscalDigital getTimbreFiscalDigital() {
        return timbreFiscalDigital;
    }

    public void setTimbreFiscalDigital(TimbreFiscalDigital timbreFiscalDigital) {
        this.timbreFiscalDigital = timbreFiscalDigital;
    }  
}
