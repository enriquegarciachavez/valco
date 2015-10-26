/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.FacturasDAO;
import java.io.IOException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import org.omnifaces.util.Faces;
import org.primefaces.context.RequestContext;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class NotaCreditoMainBean {
    @ManagedProperty(value="#{facturasDao}")
private FacturasDAO facturasDao;
    private Date fechaInicial;
    private Date fechaFinal;
    

    /**
     * Creates a new instance of NotaCreditoMainBean
     */
    public NotaCreditoMainBean() {
    }
    
    public void mostrarXls(){
        try {
            Faces.redirect("/valco/ReportesXls?reporte=%s&FECHA_INICIODate=%s&FECHA_FINDate=%s", 
                    "//pagina//reportes//notasdecredito//NotasCredito.jrxml"
                   + fechaInicial.toString(),
                    fechaFinal.toString());
        } catch (IOException ex) {
            Logger.getLogger(ReporteFacturasXCobrarBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void mostrarPdf(){
        String url = "/valco/ReportesPdf?reporte="
                + "//pagina//reportes//notasdecredito//NotasCredito.jrxml"
                + "&FECHA_INICIODate="+fechaInicial.toString()
                + "&FECHA_FINDate="+fechaFinal.toString();
        RequestContext.getCurrentInstance().execute("window.open('"+url+"');");
    }

    public FacturasDAO getFacturasDao() {
        return facturasDao;
    }

    public void setFacturasDao(FacturasDAO facturasDao) {
        this.facturasDao = facturasDao;
    }

    public Date getFechaInicial() {
        return fechaInicial;
    }

    public void setFechaInicial(Date fechaInicial) {
        this.fechaInicial = fechaInicial;
    }

    public Date getFechaFinal() {
        return fechaFinal;
    }

    public void setFechaFinal(Date fechaFinal) {
        this.fechaFinal = fechaFinal;
    }
 
    
}
