/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.FamiliasDAO;
import com.valco.pojo.Familias;
import com.valco.utility.MsgUtility;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import javax.faces.validator.ValidatorException;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class FamiliasMainBean {
    
    @ManagedProperty(value = "#{familiasDAO}")
    private FamiliasDAO familiasDAO;
    List<Familias> familias = new ArrayList<>();
    List<Familias> familiasFiltradas;
    Familias familiaSeleccionada = null;
    Familias familiaNueva = new Familias();
    
    
    

    /**
     * Creates a new instance of FamiliasMainBean
     */
    public FamiliasMainBean() {
    }
    
    @PostConstruct
    private void init(){
        try {
            familias = familiasDAO.getFamilias();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar las familias");
        }
    }
    public void actualizarFamilia() {
        try {
            if(familiaSeleccionada == null){
                throw new Exception("Debe seleccionar una familia para modificar");
            }
            familiasDAO.actualizarFamilia(familiaSeleccionada);
            familiaSeleccionada=null;
            MsgUtility.showInfoMeage("La familia se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }
    public void validarFamiliaSeleccionada(ActionEvent actionEvent) {
       
            if(familiaSeleccionada == null){
                MsgUtility.showErrorMeage("Debe seleccionar una familia");
                FacesContext.getCurrentInstance().validationFailed();
                
            }
            
       
    }
    
    public void insertarFamilia() {
        try {
            familiaNueva.setEstatus("ACTIVO");
            familiasDAO.insertarFamilia(familiaNueva);
            this.familias.add(familiaNueva);
            familiaNueva = new Familias();
            MsgUtility.showInfoMeage("La familia se ingresó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void borrarFamilia() {
        try {
            familiasDAO.borrarFamilia(familiaSeleccionada);
            this.familias.remove(familiaSeleccionada);
            MsgUtility.showInfoMeage("La familia se borro con éxito");
        } catch (Exception ex) {
           MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public FamiliasDAO getFamiliasDAO() {
        return familiasDAO;
    }

    public void setFamiliasDAO(FamiliasDAO familiasDAO) {
        this.familiasDAO = familiasDAO;
    }

    public List<Familias> getFamilias() {
        return familias;
    }

    public void setFamilias(List<Familias> familias) {
        this.familias = familias;
    }

    public Familias getFamiliaSeleccionada() {
        return familiaSeleccionada;
    }

    public void setFamiliaSeleccionada(Familias familiaSeleccionada) {
        this.familiaSeleccionada = familiaSeleccionada;
    }

    public Familias getFamiliaNueva() {
        return familiaNueva;
    }

    public void setFamiliaNueva(Familias familiaNueva) {
        this.familiaNueva = familiaNueva;
    }

    public List<Familias> getFamiliasFiltradas() {
        return familiasFiltradas;
    }

    public void setFamiliasFiltradas(List<Familias> familiasFiltradas) {
        this.familiasFiltradas = familiasFiltradas;
    }
    
    
    
    
}
