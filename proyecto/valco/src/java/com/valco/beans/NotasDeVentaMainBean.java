/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.NotasVentaDAO;
import com.valco.pojo.NotasDeVenta;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.bean.ViewScoped;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.faces.validator.ValidatorException;
import org.primefaces.context.RequestContext;
import static sun.net.www.http.HttpClient.New;

/**
 *
 * @author Karlitha
 */
@ManagedBean
@ViewScoped
public class NotasDeVentaMainBean {
@ManagedProperty(value="#{notadeVentaDao}")
private NotasVentaDAO notasDeVentaDao;
private List<NotasDeVenta> notasDeVenta;
private NotasDeVenta notaSeleccionada;
private NotasDeVenta notaNueva;

    public NotasDeVenta getNotaNueva() {
        return notaNueva;
    }

    public void setNotaNueva(NotasDeVenta notaNueva) {
        this.notaNueva = notaNueva;
    }

    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }

    public List<NotasDeVenta> getNotasDeVenta() {
        return notasDeVenta;
    }

    public void setNotasDeVenta(List<NotasDeVenta> notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }

    public NotasDeVenta getNotaSeleccionada() {
        return notaSeleccionada;
    }

    public void setNotaSeleccionada(NotasDeVenta notaSeleccionada) {
        this.notaSeleccionada = notaSeleccionada;
    }

    public DataModel getModeloNotas() throws Exception {
        notasDeVenta = notasDeVentaDao.getNotasDeVenta();
        modeloNotas = new ListDataModel(notasDeVenta);
        return modeloNotas;
    }

    public void setModeloNotas(DataModel modeloNotas) {
        this.modeloNotas = modeloNotas;
    }
    
    public void consultaXFolio() throws Exception{
	NotasDeVenta aux = new NotasDeVenta();
        aux = 
                this.notasDeVentaDao.getNotaDeVentaXFolio(notaNueva.getFolio());
        if(aux == null){
            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor")); 
        }else{
            this.notaNueva = aux;
        }
    }
    
DataModel modeloNotas;
    /**
     * Creates a new instance of NotasDeVentaMainBean
     */
    public NotasDeVentaMainBean() {
        this.notaNueva = new NotasDeVenta();
    }
    
}
