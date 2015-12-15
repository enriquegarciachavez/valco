/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.pojo.UnidadesDeMedida;
import com.valco.dao.UnidadesDeMedidaDAO;
import com.valco.utility.MsgUtility;
import java.awt.event.ActionEvent;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.faces.validator.ValidatorException;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class UnidadesDeMedidaMainBean {
    
    @ManagedProperty(value = "#{unidadesdemedidaDao}")
    private UnidadesDeMedidaDAO unidadesdemedidaDao;
    List<UnidadesDeMedida> unidadesdemedida;
    UnidadesDeMedida unidadNuevo;
    UnidadesDeMedida unidadSeleccionado;
    DataModel modeloUnidad;
    UIInput descripcion;
    UIInput abreviacion;

    /**
     * Creates a new instance of UnidadesDeMedidaMainBean
     */
    public UnidadesDeMedidaMainBean() {
    }

    public UnidadesDeMedidaDAO getUnidadesdemedidaDao() {
        return unidadesdemedidaDao;
    }

    public void setUnidadesdemedidaDao(UnidadesDeMedidaDAO unidadesdemedidaDao) {
        this.unidadesdemedidaDao = unidadesdemedidaDao;
    }

    public List<UnidadesDeMedida> getUnidadesdemedida() {
        return unidadesdemedida;
    }

    public void setUnidadesdemedida(List<UnidadesDeMedida> unidadesdemedida) {
        this.unidadesdemedida = unidadesdemedida;
    }

    public UnidadesDeMedida getUnidadNuevo() {
        return unidadNuevo;
    }

    public void setUnidadNuevo(UnidadesDeMedida unidadNuevo) {
        this.unidadNuevo = unidadNuevo;
    }

    public UnidadesDeMedida getUnidadSeleccionado() {
        return unidadSeleccionado;
    }

    public void setUnidadSeleccionado(UnidadesDeMedida unidadSeleccionado) {
        this.unidadSeleccionado = unidadSeleccionado;
    }

    public DataModel getModeloUnidad()  {
        try {
            unidadesdemedida = unidadesdemedidaDao.getUnidadesDeMedida();
            modeloUnidad = new ListDataModel(unidadesdemedida);
            return modeloUnidad;
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            return modeloUnidad;
        }
    }

    public void setModeloUnidad(DataModel modeloUnidad) {
        this.modeloUnidad = modeloUnidad;
    }

    public UIInput getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(UIInput descripcion) {
        this.descripcion = descripcion;
    }

    public void setAbreviacion(UIInput Abreviacion) {
        this.abreviacion = Abreviacion;
    }

    public UIInput getAbreviacion() {
        return abreviacion;
    }

    
    

    public void insertarUnidad() {
        try {
            unidadNuevo.setEstatus("ACTIVO");
            unidadesdemedidaDao.insertarUnidadesDeMedida(unidadNuevo);
           MsgUtility.showInfoMeage("La unidad se insertó con éxito");
        } catch (Exception ex) {
          MsgUtility.showErrorMeage(ex.getMessage());  
        }
    }    
    
    public void borrarUnidad(){
        try {
            unidadesdemedidaDao.borrarUnidadesDeMedida(unidadSeleccionado);
            MsgUtility.showInfoMeage("La unidad se borró con éxito");
        } catch (Exception ex) {
          MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    public void actualizarUnidad(){
        try {
            unidadesdemedidaDao.actualizarUnidadesDeMedida(unidadSeleccionado);
            MsgUtility.showInfoMeage("La unidad se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        
    }
     public void inicializarUnidad() {
         this.unidadNuevo = new UnidadesDeMedida();
        limpiarIngresarForm();}
    
     public void limpiarIngresarForm() {
        
        }
     
     // Descripcion
     public void validarDescripcion(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        UnidadesDeMedida descripcion = null;
        descripcion = 
                this.unidadesdemedidaDao.getUnidadesXDescripcion(value.toString());
        if(descripcion != null){
            throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe")); 
        }
     }
        
    public void validarModificarDescripcion(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        UnidadesDeMedida descripcion = null;
        descripcion = 
                this.unidadesdemedidaDao.getUnidadesXDescripcion(value.toString());
        if(descripcion != null){
            if(descripcion.getCodigo() != unidadSeleccionado.getCodigo()){
        
            throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe")); 
        }
        }  
    }
    
    //Abreviacion
    public void validarAbreviacion(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        UnidadesDeMedida abreviacion = null;
        abreviacion = 
                this.unidadesdemedidaDao.getUnidadesXAbreviacion(value.toString());
        if(abreviacion != null){
            throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe")); 
        }
     }
    
    public void validarModificarAbreviacion(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        UnidadesDeMedida abreviacion = null;
        abreviacion = 
                this.unidadesdemedidaDao.getUnidadesXAbreviacion(value.toString());
        if(abreviacion != null){
            if(abreviacion.getCodigo() != unidadSeleccionado.getCodigo()){
        
            throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe")); 
        }
        }  
    }
    
    public void validarUnidadSeleccionada(ActionEvent actionEvent) {
       
            if(unidadSeleccionado == null){
                MsgUtility.showErrorMeage("Debe seleccionar una unidad");
                FacesContext.getCurrentInstance().validationFailed();
                
            }
            
       
    }
     
     
     
}
