/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.RepartidoresDAO;
import com.valco.pojo.Repartidores;
import com.valco.utility.MsgUtility;
import java.awt.event.ActionEvent;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.bean.ManagedProperty;
import javax.faces.component.UIInput;
import javax.faces.context.FacesContext;
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
    UIInput codigo;
    

    /**
     * Creates a new instance of RepartidoresMainBean
     */
    public RepartidoresMainBean() {
    }
    
    public DataModel getModeloRepartidores() {
        try {
            repartidores = repartidoresDao.getRepartidores();
            modeloRepartidores = new ListDataModel(repartidores);
            return modeloRepartidores;
        } catch (Exception ex) {
           MsgUtility.showErrorMeage(ex.getMessage());
           return modeloRepartidores;
        }
    }

    public UIInput getCodigo() {
        return codigo;
    }

    public void setCodigo(UIInput codigo) {
        this.codigo = codigo;
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

    public void validarRepartidorSeleccionada(ActionEvent actionEvent) {
       
            if(repartidorSeleccionado == null){
                MsgUtility.showErrorMeage("Debe seleccionar un repartidor");
                FacesContext.getCurrentInstance().validationFailed();
                
            }
            
       
    }
 
    public void insertarRepartidor() {
        try {
            repartidorNuevo.setEstatus("ACTIVO");
            repartidoresDao.insertarRepartidores(repartidorNuevo);
           MsgUtility.showInfoMeage("El repartidor se insertó con éxito");
        } catch (Exception ex) {
         MsgUtility.showErrorMeage(ex.getMessage());   
        }
    }    
    
    public void borrarRepartidor(){
        try {
            repartidoresDao.borrarRepartidor(repartidorSeleccionado);
            MsgUtility.showInfoMeage("El repartidor se borró con éxito");
        } catch (Exception ex) {
          MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    public void actualizarRepartidor(){
        try {
            repartidoresDao.actualizarRepartidor(repartidorSeleccionado);
            MsgUtility.showInfoMeage("El repartidor se actualizó con éxito");
        } catch (Exception ex) {
           MsgUtility.showErrorMeage(ex.getMessage()); 
        }
        
    }
     public void inicializarRepartidor() {
         this.repartidorNuevo = new Repartidores();
        limpiarIngresarForm();}
    
     public void limpiarIngresarForm() {
        apellidoPaterno.setValue(null);
        apellidoMaterno.setValue(null);
        nombres.setValue(null);
        codigo.setValue("");
       
        }
}
