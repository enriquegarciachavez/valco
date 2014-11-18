/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.sun.deploy.uitoolkit.impl.fx.ui.UITextArea;
import com.valco.dao.TipoProductoDAO;
import com.valco.pojo.TipoProducto;
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

public class TipoProductoMainBean {
    @ManagedProperty(value = "#{tipoproductoDao}")
    private TipoProductoDAO tipoproductoDao;
    List<TipoProducto> tipoproducto;
    TipoProducto tipoNuevo;
    TipoProducto tipoSeleccionado;
    UIInput descripcion;
    UITextArea observaciones;
    DataModel modeloTipoProducto;
    

    /**
     * Creates a new instance of TipoProductoMainBean
     */
    public TipoProductoMainBean() {
    }

    public DataModel getModeloTipoProducto() throws Exception {
        tipoproducto = tipoproductoDao.getTipoProducto();
        modeloTipoProducto = new ListDataModel(tipoproducto);
        return modeloTipoProducto;
    }

    public void setModeloTipoProducto(DataModel modeloTipoProducto) {
        this.modeloTipoProducto = modeloTipoProducto;
    }

    
    public TipoProductoDAO getTipoproductoDao() {
        return tipoproductoDao;
    }

    public void setTipoproductoDao(TipoProductoDAO tipoproductoDao) {
        this.tipoproductoDao = tipoproductoDao;
    }

    public List<TipoProducto> getTipoproducto() {
        return tipoproducto;
    }

    public void setTipoproducto(List<TipoProducto> tipoproducto) {
        this.tipoproducto = tipoproducto;
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

    public UITextArea getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(UITextArea observaciones) {
        this.observaciones = observaciones;
    }
    
    public void insertarTipoProducto() {
        try {
            tipoNuevo.setEstatus("ACTIVO");
            tipoproductoDao.insertarTipoProducto(tipoNuevo);
           
        } catch (Exception ex) {
            
        }
    }    
    
    public void borrarTipoProducto(){
        try {
            tipoproductoDao.borrarTipoProducto(tipoSeleccionado);
        } catch (Exception ex) {
          
        }
    }
    public void actualizarTipoProducto(){
        try {
            tipoproductoDao.actualizarTipoProducto(tipoSeleccionado);
        } catch (Exception ex) {
            
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
                this.tipoproductoDao.getTipoProductoXDescripcion(value.toString());
        if(tipopro != null){
            throw new ValidatorException(new FacesMessage("La descripcion que capturó ya existe")); 
        }
        
    }
     public void validarModificarDescripcion(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        TipoProducto tipopro = null;
        tipopro = 
                this.tipoproductoDao.getTipoProductoXDescripcion(value.toString());
        if(tipopro != null){
            if(tipopro.getCodigo()!= tipoSeleccionado.getCodigo())
            throw new ValidatorException(new FacesMessage("La descripción que capturó ya existe")); 
        }
        
    }
    
}
