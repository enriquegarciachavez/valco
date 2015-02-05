/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ParametrosGeneralesDAO;
import com.valco.pojo.ParametrosGenerales;
import com.valco.utility.MsgUtility;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIInput;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class ParametrosGeneralesMainBean {
    
    @ManagedProperty(value = "#{parametrosGeneralesDAO}")
    private ParametrosGeneralesDAO parametrosGeneralesDAO;
    List<ParametrosGenerales> parametros;
    ParametrosGenerales parametroSeleccionado;
    ParametrosGenerales parametroNuevo;
    DataModel modeloParametros;
    UIInput clave;
    UIInput valor;
    UIInput estatus;
   

    /**
     * Creates a new instance of ParametrosGeneralesMainBean
     */
    public ParametrosGeneralesMainBean() {
    }

    public ParametrosGeneralesDAO getParametrosGeneralesDAO() {
        return parametrosGeneralesDAO;
    }

    public void setParametrosGeneralesDAO(ParametrosGeneralesDAO parametrosGeneralesDAO) {
        this.parametrosGeneralesDAO = parametrosGeneralesDAO;
    }

    public List<ParametrosGenerales> getParametros() {
        return parametros;
    }

    public void setParametros(List<ParametrosGenerales> parametros) {
        this.parametros = parametros;
    }

    public ParametrosGenerales getParametroSeleccionado() {
        return parametroSeleccionado;
    }

    public void setParametroSeleccionado(ParametrosGenerales parametroSeleccionado) {
        this.parametroSeleccionado = parametroSeleccionado;
    }

    public ParametrosGenerales getParametroNuevo() {
        return parametroNuevo;
    }

    public void setParametroNuevo(ParametrosGenerales parametroNuevo) {
        this.parametroNuevo = parametroNuevo;
    }

    public DataModel getModeloParametros() {
        try {
            parametros = parametrosGeneralesDAO.getParametrosGenerales();
            modeloParametros = new ListDataModel(parametros);
            return modeloParametros;
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            return modeloParametros;
        }
        
    }

    public void setModeloParametros(DataModel modeloParametros) {
        this.modeloParametros = modeloParametros;
    }

    public UIInput getClave() {
        return clave;
    }

    public void setClave(UIInput clave) {
        this.clave = clave;
    }

    public UIInput getValor() {
        return valor;
    }

    public void setValor(UIInput valor) {
        this.valor = valor;
    }

    public UIInput getEstatus() {
        return estatus;
    }

    public void setEstatus(UIInput estatus) {
        this.estatus = estatus;
    }
    
   
    
     public String inicializarParametro() {
        this.parametroNuevo = new ParametrosGenerales();
        limpiarIngresarForm();
        return null;
    }
     
      public void limpiarIngresarForm() {
        clave.setValue(null);
        valor.setValue(null);
        
        
    }
     
         
     public void actualizarParametro() {
        try {
            parametrosGeneralesDAO.actualizarParametro(parametroSeleccionado);
            MsgUtility.showInfoMeage("El parametro se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }
     
     public void insertarParametro() {
        try {
            parametroNuevo.setEstatus("ACTIVO");
            parametrosGeneralesDAO.insertarParametro(parametroNuevo);
            MsgUtility.showInfoMeage("El parametro se ingresó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
     
     public void borrarParametro() {
        try {
            parametrosGeneralesDAO.borrarParametro(parametroSeleccionado);
            MsgUtility.showInfoMeage("El parametro se borro con éxito");
        } catch (Exception ex) {
           MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
     
     
    
}
