/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import org.omnifaces.util.Faces;
import org.primefaces.context.RequestContext;

/**
 *
 * @author Administrador
 */
@ManagedBean
@RequestScoped
public class ReporteVentasConFacturaBean {
    private Date fechaInicial;
    private Date fechaFinal;
    /**
     * Creates a new instance of ReporteVentasConFacturaBean
     */
    public ReporteVentasConFacturaBean() {
    }
    
    public void mostrarXls(){
        try {
            Faces.redirect("/valco/ReportesXls?reporte=%s&fechaInicialDate=%s&fechaFinalDate=%s",
                    "//pagina//reportes//ventas con factura//Facturas.jrxml",
                    fechaInicial.toString(),
                    fechaFinal.toString());
        } catch (IOException ex) {
            Logger.getLogger(ReporteVentasConFacturaBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void mostrarPdf(){
        String url = "/valco/ReportesPdf?reporte="
                + "//pagina//reportes//ventas con factura//Facturas.jrxml"
                + "&fecha_inicialDate="+fechaInicial.toString()
                + "&fecha_finalDate="+fechaFinal.toString();
        
        RequestContext.getCurrentInstance().execute("window.open('"+url+"');");
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
