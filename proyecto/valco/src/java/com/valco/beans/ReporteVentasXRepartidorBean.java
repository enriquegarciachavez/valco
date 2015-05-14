/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.RepartidoresDAO;
import com.valco.pojo.Repartidores;
import com.valco.utility.MsgUtility;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import org.omnifaces.util.Faces;
import org.primefaces.context.RequestContext;

/**
 *
 * @author Administrador
 */
@ManagedBean
@ViewScoped
public class ReporteVentasXRepartidorBean {
private Date fechaInicial;
private Date fechaFinal;
private List<Repartidores> repartidores;
private Repartidores repartidorSeleccionado;
@ManagedProperty(value = "#{repartidoresDao}")
private RepartidoresDAO repartidoresDao;
    /**
     * Creates a new instance of ReporteVentasXRepartidorBean
     */
    public ReporteVentasXRepartidorBean() {
    }
    
    @PostConstruct
    public void init(){
        try {
            this.repartidores = this.repartidoresDao.getRepartidores();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar los repartidores");
        }
    }
    
    public void mostrarXls(){
        try {
            Faces.redirect("/valco/ReportesXls?reporte=%s&fechaInicialDate=%s&fechaFinalDate=%s&codigoRepartidorInt=%s",
                    "//pagina//reportes//ventas por repartidor//VentasXRepartidor.jrxml",
                    fechaInicial.toString(),
                    fechaFinal.toString(),
                    repartidorSeleccionado.getCodigo().toString());
        } catch (IOException ex) {
            Logger.getLogger(ReporteVentasConFacturaBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void mostrarPdf(){
        String url = "/valco/ReportesPdf?reporte="
                + "//pagina//reportes//ventas por repartidor//VentasXRepartidor.jrxml"
                + "&fechaInicialDate="+fechaInicial.toString()
                + "&fechaFinalDate="+fechaFinal.toString()
                + "&codigoRepartidorInt="+repartidorSeleccionado.getCodigo();
        
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

    public RepartidoresDAO getRepartidoresDao() {
        return repartidoresDao;
    }

    public void setRepartidoresDao(RepartidoresDAO repartidoresDao) {
        this.repartidoresDao = repartidoresDao;
    }

    public List<Repartidores> getRepartidores() {
        return repartidores;
    }

    public void setRepartidores(List<Repartidores> repartidores) {
        this.repartidores = repartidores;
    }

    public Repartidores getRepartidorSeleccionado() {
        return repartidorSeleccionado;
    }

    public void setRepartidorSeleccionado(Repartidores repartidorSeleccionado) {
        this.repartidorSeleccionado = repartidorSeleccionado;
    }
    
    
}
