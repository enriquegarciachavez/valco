/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.UbicacionesDAO;
import com.valco.pojo.Ubicaciones;
import java.util.List;
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
public class UbicacionesMainBean {
    
    @ManagedProperty(value = "#{ubicacionesDao}")
    private UbicacionesDAO ubicacionesDao;
    List<Ubicaciones> ubicaciones;
    Ubicaciones ubicacionNuevo;
    Ubicaciones ubicacionSelecionado;
    DataModel modeloUbicaciones;
    UIInput estado;
    UIInput ciudad;
    UIInput oficina;
    

    /**
     * Creates a new instance of UbicacionesMainBean
     */
    public UbicacionesMainBean() {
    }

    public UbicacionesDAO getUbicacionesDao() {
        return ubicacionesDao;
    }

    public void setUbicacionesDao(UbicacionesDAO ubicacionesDao) {
        this.ubicacionesDao = ubicacionesDao;
    }

    public List<Ubicaciones> getUbicaciones() {
        return ubicaciones;
    }

    public void setUbicaciones(List<Ubicaciones> ubicaciones) {
        this.ubicaciones = ubicaciones;
    }

    public Ubicaciones getUbicacionNuevo() {
        return ubicacionNuevo;
    }

    public void setUbicacionNuevo(Ubicaciones ubicacionNuevo) {
        this.ubicacionNuevo = ubicacionNuevo;
    }

    public Ubicaciones getUbicacionSelecionado() {
        return ubicacionSelecionado;
    }

    public void setUbicacionSelecionado(Ubicaciones ubicacionSelecionado) {
        this.ubicacionSelecionado = ubicacionSelecionado;
    }

    public DataModel getModeloUbicaciones() throws Exception {
        ubicaciones = ubicacionesDao.getUbicaciones();
        modeloUbicaciones = new ListDataModel(ubicaciones);
        return modeloUbicaciones;
    }

    public void setModeloUbicaciones(DataModel modeloUbicaciones) {
        this.modeloUbicaciones = modeloUbicaciones;
    }

    public UIInput getEstado() {
        return estado;
    }

    public void setEstado(UIInput estado) {
        this.estado = estado;
    }

    public UIInput getCiudad() {
        return ciudad;
    }

    public void setCiudad(UIInput ciudad) {
        this.ciudad = ciudad;
    }

    public UIInput getOficina() {
        return oficina;
    }

    public void setOficina(UIInput oficina) {
        this.oficina = oficina;
    }
    
     public void insertarUbicacion() {
        try {
            ubicacionNuevo.setEstatus("ACTIVO");
            ubicacionesDao.insertarUbicacion(ubicacionNuevo);
           
        } catch (Exception ex) {
            
        }
    }    
    
    public void borrarUbicacion(){
        try {
            ubicacionesDao.borrarUbicacion(ubicacionSelecionado);
        } catch (Exception ex) {
          
        }
    }
    public void actualizarUbicacion(){
        try {
            ubicacionesDao.actualizarUbicacion(ubicacionSelecionado);
        } catch (Exception ex) {
            
        }
        
    }
     public void inicializarUbicacion() {
         this.ubicacionNuevo = new Ubicaciones();
        limpiarIngresarForm();}
    
     public void limpiarIngresarForm() {
        estado.setValue(null);
        ciudad.setValue(null);
        
       
        }
     
    public void validarOficina(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Ubicaciones oficina = null;
        oficina
                = this.ubicacionesDao.getUbicacionesXOficina(value.toString());
        if (oficina != null) {
            throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe"));
        }

    }

    public void validarModificarOficina(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Ubicaciones oficina = null;
        oficina
                = this.ubicacionesDao.getUbicacionesXOficina(value.toString());
        if (oficina != null) {
            if (oficina.getCodigo() != ubicacionSelecionado.getCodigo()) {
                throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe"));
            }
        }
    }
    
    
    
}
