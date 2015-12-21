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
import javax.servlet.GenericServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import org.omnifaces.util.Faces;
import static org.omnifaces.util.Faces.getServletContext;
import org.primefaces.context.RequestContext;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.request;

/**
 *
 * @author Administrador
 */
@ManagedBean
@RequestScoped
public class ReporteFacturasXCobrarBean{
    private String clienteInicial;
    private String clienteFinal;
    private Date fechaInicial;
    private Date fechaFinal;
    /**
     * Creates a new instance of ReporteFacturasXCobrarBean
     */
    public ReporteFacturasXCobrarBean() {
    }
    
    public void mostrarXls(){
        try {
            Faces.redirect("/valco/ReportesXls?reporte=%s&clienteInicialInt=%s&clienteFinalInt=%s&fechaInicialDate=%s&fechaFinalDate=%s", 
                    "//pagina//reportes//facturasxcobrar//FacturasXCobrarMain.jrxml"
                    ,clienteInicial,
                    clienteFinal,
                    fechaInicial.toString(),
                    fechaFinal.toString());
        } catch (IOException ex) {
            Logger.getLogger(ReporteFacturasXCobrarBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void mostrarPdf(){
        String url = "/valco/ReportesPdf?reporte="
                + "//pagina//reportes//facturasxcobrar//FacturasXCobrarMain.jrxml"
                + "&clienteInicialInt="+clienteInicial
                + "&clienteFinalInt="+clienteFinal
                + "&fechaInicialDate="+fechaInicial.toString()
                + "&fechaFinalDate="+fechaFinal.toString();
        RequestContext.getCurrentInstance().execute("window.open('"+url+"');");
    }

    public String getClienteInicial() {
        return clienteInicial;
    }

    public void setClienteInicial(String clienteInicial) {
        this.clienteInicial = clienteInicial;
    }

    public String getClienteFinal() {
        return clienteFinal;
    }

    public void setClienteFinal(String clienteFinal) {
        this.clienteFinal = clienteFinal;
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
