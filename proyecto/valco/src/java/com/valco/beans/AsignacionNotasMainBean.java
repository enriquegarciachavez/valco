/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.NotasVentaDAO;
import com.valco.dao.RepartidoresDAO;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.Repartidores;
import com.valco.pojo.Usuarios;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class AsignacionNotasMainBean {
    
    @ManagedProperty(value="#{notadeVentaDao}")
            private NotasVentaDAO notadeVentaDao;
    @ManagedProperty(value="#{repartidoresDao}")
            private RepartidoresDAO repartidoresDao;
    List<NotasDeVenta> notasDeVenta;
    List<Repartidores> repartidores;
    Repartidores repartidor;
    NotasDeVenta asignacionNuevo;
    NotasDeVenta asignacionSeleccionado;
    Integer folioInicial;
    Integer folioFinal;
    DataModel modeloAsignacion;
    

    /**
     * Creates a new instance of AsignacionNotasMainBean
     */
    public AsignacionNotasMainBean() {
    }

    public Repartidores getRepartidor() {
        return repartidor;
    }

    public void setRepartidor(Repartidores repartidor) {
        this.repartidor = repartidor;
    }

    public Integer getFolioInicial() {
        return folioInicial;
    }

    public void setFolioInicial(Integer folioInicial) {
        this.folioInicial = folioInicial;
    }

    public Integer getFolioFinal() {
        return folioFinal;
    }

    public void setFolioFinal(Integer folioFinal) {
        this.folioFinal = folioFinal;
    }

    
    

    public NotasVentaDAO getNotadeVentaDao() {
        return notadeVentaDao;
    }

    public void setNotadeVentaDao(NotasVentaDAO notadeVentaDao) {
        this.notadeVentaDao = notadeVentaDao;
    }

    public RepartidoresDAO getRepartidoresDao() {
        return repartidoresDao;
    }

    public void setRepartidoresDao(RepartidoresDAO repartidoresDao) {
        this.repartidoresDao = repartidoresDao;
    }

    public List<NotasDeVenta> getNotasDeVenta() {
        return notasDeVenta;
    }

    public void setNotasDeVenta(List<NotasDeVenta> notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }

   

    public List<Repartidores> getRepartidores() {
        return repartidores;
    }

    public void setRepartidores(List<Repartidores> repartidores) {
        this.repartidores = repartidores;
    }

    

    public NotasDeVenta getAsignacionNuevo() {
        return asignacionNuevo;
    }

    public void setAsignacionNuevo(NotasDeVenta asignacionNuevo) {
        this.asignacionNuevo = asignacionNuevo;
    }

    public NotasDeVenta getAsignacionSeleccionado() {
        return asignacionSeleccionado;
    }

    public void setAsignacionSeleccionado(NotasDeVenta asignacionSeleccionado) {
        this.asignacionSeleccionado = asignacionSeleccionado;
    }

    public DataModel getModeloAsignacion() throws Exception {
        notasDeVenta = notadeVentaDao.getAsignacionNotasDeVenta();
        modeloAsignacion = new ListDataModel(notasDeVenta);
        return modeloAsignacion;
    }

    public void setModeloAsignacion(DataModel modeloAsignacion) {
        this.modeloAsignacion = modeloAsignacion;
    }
    
    @PostConstruct
    public void init(){
        try {
          this.repartidores = repartidoresDao.getRepartidores();
        } catch (Exception ex) {
            
        }
    }
    public void asignarNotas(){
      List<NotasDeVenta> notas = new ArrayList<NotasDeVenta>() ;
        if (folioFinal < folioInicial) {
            FacesMessage msg = null;
            msg = new FacesMessage("El Folio final debe ser mayor que el folio inicial");
            FacesContext.getCurrentInstance().addMessage(null, msg);
            return;
        }
        
      for(int x =folioInicial;x<=folioFinal; x++){
          Usuarios usuario=new Usuarios();
          usuario.setCodigo(1);
          NotasDeVenta notaNueva = new NotasDeVenta();
          notaNueva.setEstatus("ACTIVO");
          notaNueva.setFolio(x);
          notaNueva.setRepartidores(repartidor);
          notaNueva.setUsuarios(usuario);
          notas.add(notaNueva);
          
      }
        try {
            notadeVentaDao.insertarNotas(notas);
        } catch (Exception ex) {
            FacesMessage msg = null;
            msg = new FacesMessage(ex.getMessage());
            FacesContext.getCurrentInstance().addMessage(null, msg);
            
        }
      
    }
    
}