/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.CuentasContablesDAO;
import com.valco.pojo.CuentasContables;
import com.valco.utility.MsgUtility;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UISelectBoolean;
import javax.faces.context.FacesContext;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class CuentasContablesMainBean {
    
    @ManagedProperty(value = "#{cuentascontablesDAO}")
            private CuentasContablesDAO cuentascontablesDAO;
    List<CuentasContables> cuentasContables = new ArrayList<>();
    List<CuentasContables> cuentasFiltradas;
    CuentasContables cuentasSeleccionada = null;
    CuentasContables cuentasNueva = new CuentasContables();
    UISelectBoolean banco;

    /**
     * Creates a new instance of CuentasContablesMainBean
     */
    public CuentasContablesMainBean() {
    }
    
    @PostConstruct
    private void init(){
        try {
            cuentasContables = cuentascontablesDAO.getCuentasContables();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar las Cuentas");
        }
    }
    
    public void actualizarCuentasContables() {
        try {
            if(cuentasSeleccionada == null){
                throw new Exception("Debe seleccionar una cuenta para modificar");
            }
            cuentascontablesDAO.actualizarCuentaContable(cuentasSeleccionada);
            cuentasSeleccionada=null;
            MsgUtility.showInfoMeage("La cuenta se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }
    
    public void validarCuentaSeleccionada(ActionEvent actionEvent) {
       
            if(cuentasSeleccionada == null){
                MsgUtility.showErrorMeage("Debe seleccionar una cuenta");
                FacesContext.getCurrentInstance().validationFailed();
                
            }       
    }
    
    public void insertarCuentasContables() {
        try {
            cuentasNueva.setEstatus("ACTIVO");
            cuentascontablesDAO.insertarCuentaContable(cuentasNueva);
            this.cuentasContables.add(cuentasNueva);
            cuentasNueva = new CuentasContables();
            MsgUtility.showInfoMeage("La Cuenta se ingresó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    
    public void borrarCuentaContable() {
        try {
            cuentascontablesDAO.borrarCuentaContable(cuentasSeleccionada);
            this.cuentasContables.remove(cuentasSeleccionada);
            MsgUtility.showInfoMeage("La cuenta se borro con éxito");
        } catch (Exception ex) {
           MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    
    public CuentasContablesDAO getCuentascontablesDAO() {
        return cuentascontablesDAO;
    }

    public void setCuentascontablesDAO(CuentasContablesDAO cuentascontablesDAO) {
        this.cuentascontablesDAO = cuentascontablesDAO;
    }

    public List<CuentasContables> getCuentasContables() {
        return cuentasContables;
    }

    public void setCuentasContables(List<CuentasContables> cuentasContables) {
        this.cuentasContables = cuentasContables;
    }

    public CuentasContables getCuentasSeleccionada() {
        return cuentasSeleccionada;
    }

    public void setCuentasSeleccionada(CuentasContables cuentasSeleccionada) {
        this.cuentasSeleccionada = cuentasSeleccionada;
    }

    public CuentasContables getCuentasNueva() {
        return cuentasNueva;
    }

    public void setCuentasNueva(CuentasContables cuentasNueva) {
        this.cuentasNueva = cuentasNueva;
    }

    public List<CuentasContables> getCuentasFiltradas() {
        return cuentasFiltradas;
    }

    public void setCuentasFiltradas(List<CuentasContables> cuentasFiltradas) {
        this.cuentasFiltradas = cuentasFiltradas;
    }

    public UISelectBoolean getBanco() {
        return banco;
    }

    public void setBanco(UISelectBoolean banco) {
        this.banco = banco;
    }
    
    
   
    
}
