/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.TipoProductoDAO;
import com.valco.pojo.TipoProducto;
import com.valco.utility.MsgUtility;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
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

public class TipoProductoMainBean {
    @ManagedProperty(value = "#{tipoproductoDao}")
    private TipoProductoDAO tipoProductoDao;
    List<TipoProducto> tipoProducto;
    TipoProducto tipoNuevo;
    TipoProducto tipoSeleccionado;
    UIInput descripcion;
    UIInput observaciones;
    DataModel modeloTipoProducto;
    

    /**
     * Creates a new instance of TipoProductoMainBean
     */
    public TipoProductoMainBean() {
    }
    
    @PostConstruct
    private void init(){
        try {
            tipoProducto = tipoProductoDao.getTipoProducto();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar los Productos");
        }
    }


    
    public void insertarTipoProducto() {
        try {
            tipoNuevo.setEstatus("ACTIVO");
            tipoProductoDao.insertarTipoProducto(tipoNuevo);
           MsgUtility.showInfoMeage("El tipo producto se insertó con éxito");
           
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            
        }
    }    
    
    public void borrarTipoProducto(){
        try {
            tipoProductoDao.borrarTipoProducto(tipoSeleccionado);
            MsgUtility.showInfoMeage("El tipo producto se borró con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
          
        }
    }
    public void actualizarTipoProducto(){
        try {
            tipoProductoDao.actualizarTipoProducto(tipoSeleccionado);
            MsgUtility.showInfoMeage("El tipo producto se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            
        }
        
    }
     public void inicializarTipo() {
         this.tipoNuevo = new TipoProducto();
        limpiarIngresarForm();}
    
     public void limpiarIngresarForm() {
        
       // observaciones.setValue(false);
        //observaciones.setText(null);
        }
     public void validarDescripcion(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        TipoProducto tipopro = null;
        tipopro = 
                this.tipoProductoDao.getTipoProductoXDescripcion(value.toString());
        if(tipopro != null){
            throw new ValidatorException(new FacesMessage("La descripcion que capturó ya existe")); 
        }
        
    }
     public void validarModificarDescripcion(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        TipoProducto tipopro = null;
        tipopro = 
                this.tipoProductoDao.getTipoProductoXDescripcion(value.toString());
        if(tipopro != null){
            if(tipopro.getCodigo()!= tipoSeleccionado.getCodigo())
            throw new ValidatorException(new FacesMessage("La descripción que capturó ya existe")); 
        }
        
    }

    public void setModeloTipoProducto(DataModel modeloTipoProducto) {
        this.modeloTipoProducto = modeloTipoProducto;
    }

    
    public TipoProductoDAO getTipoProductoDao() {
        return tipoProductoDao;
    }

    public void setTipoProductoDao(TipoProductoDAO tipoproductoDao) {
        this.tipoProductoDao = tipoproductoDao;
    }

    public List<TipoProducto> getTipoProducto() {
        return tipoProducto;
    }

    public void setTipoProducto(List<TipoProducto> tipoproducto) {
        this.tipoProducto = tipoproducto;
    }

    public TipoProducto getTipoProductoNuevo() {
        return tipoNuevo;
    }

    public void setTipoProductoNuevo(TipoProducto tipoProductoNuevo) {
        this.tipoNuevo = tipoProductoNuevo;
    }

    public TipoProducto getTipoProductoSeleccionado() {
        return tipoSeleccionado;
    }

    public void setTipoProductoSeleccionado(TipoProducto tipoProductoSeleccionado) {
        this.tipoSeleccionado = tipoProductoSeleccionado;
    }

    public UIInput getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(UIInput descripcion) {
        this.descripcion = descripcion;
    }

    public UIInput getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(UIInput observaciones) {
        this.observaciones = observaciones;
    }
    
}
