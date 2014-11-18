/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.RepartidoresDAO;
import com.valco.pojo.Repartidores;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.bean.ManagedProperty;
import javax.faces.component.UIInput;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class RepartidoresMainBean {

    
    
    @ManagedProperty(value = "#{repartidoresDao}")
    private RepartidoresDAO repartidoresDao;
    List<Repartidores> repartidores;
    Repartidores repartidorSeleccionado;
    Repartidores repartidorNuevo;
    DataModel modeloRepartidores;
    UIInput apellidoPaterno;
    UIInput apellidoMaterno;
    UIInput nombres;
    

    /**
     * Creates a new instance of RepartidoresMainBean
     */
    public RepartidoresMainBean() {
    }
    
    public DataModel getModeloRepartidores() throws Exception {
        repartidores = repartidoresDao.getRepartidores();
        modeloRepartidores = new ListDataModel(repartidores);
        return modeloRepartidores;
    }

    public void setModeloRepartidores(DataModel modeloRepartidores) {
        this.modeloRepartidores = modeloRepartidores;
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

    public Repartidores getRepartidorNuevo() {
        return repartidorNuevo;
    }

    public void setRepartidorNuevo(Repartidores repartidorNuevo) {
        this.repartidorNuevo = repartidorNuevo;
    }

    public UIInput getApellidoPaterno() {
        return apellidoPaterno;
    }

    public void setApellidoPaterno(UIInput apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }

    public UIInput getApellidoMaterno() {
        return apellidoMaterno;
    }

    public void setApellidoMaterno(UIInput apellidoMaterno) {
        this.apellidoMaterno = apellidoMaterno;
    }

    public UIInput getNombres() {
        return nombres;
    }

    public void setNombres(UIInput nombres) {
        this.nombres = nombres;
    }

    
 
    public void insertarRepartidor() {
        try {
            repartidorNuevo.setEstatus("ACTIVO");
            repartidoresDao.insertarRepartidores(repartidorNuevo);
           
        } catch (Exception ex) {
            
        }
    }    
    
    public void borrarRepartidor(){
        try {
            repartidoresDao.borrarRepartidor(repartidorSeleccionado);
        } catch (Exception ex) {
          
        }
    }
    public void actualizarRepartidor(){
        try {
            repartidoresDao.actualizarRepartidor(repartidorSeleccionado);
        } catch (Exception ex) {
            
        }
        
    }
     public void inicializarRepartidor() {
         this.repartidorNuevo = new Repartidores();
        limpiarIngresarForm();}
    
     public void limpiarIngresarForm() {
        apellidoPaterno.setValue(null);
        apellidoMaterno.setValue(null);
        nombres.setValue(null);
       
        }
}