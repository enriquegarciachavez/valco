/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.FamiliasDAO;
import com.valco.dao.SubfamiliasDAO;
import com.valco.pojo.Familias;
import com.valco.pojo.Subfamilias;
import com.valco.utility.MsgUtility;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class SubfamiliasMainBean {

    @ManagedProperty(value = "#{subfamiliasDAO}")
    private SubfamiliasDAO subfamiliasDAO;
    List<Subfamilias> subfamilias = new ArrayList<>();
    List<Subfamilias> subfamiliasFiltradas;
    Subfamilias subfamiliaSeleccionada = null;
    Subfamilias subfamiliaNueva = new Subfamilias();
    List<Familias> familias = new ArrayList<>();
    @ManagedProperty(value = "#{familiasDAO}")
    private FamiliasDAO familiasDAO;
    Familias familiaSeleccionada = new Familias();
    

    /**
     * Creates a new instance of SubfamiliasMainBean
     */
    public SubfamiliasMainBean() {
    }

    @PostConstruct
    private void init() {
        try {
            familias = familiasDAO.getFamilias();
            subfamilias = subfamiliasDAO.getSubfamilias();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar las subfamilias");
        }
    }

    public void actualizarSubfamilia() {
        try {
            if (subfamiliaSeleccionada == null) {
                throw new Exception("Debe seleccionar una subfamilia para modificar");
            }
            subfamiliasDAO.actualizarSubfamilia(subfamiliaSeleccionada);
            subfamiliaSeleccionada = null;
            MsgUtility.showInfoMeage("La subfamilia se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void validarSubfamiliaSeleccionada(ActionEvent actionEvent) {

        if (subfamiliaSeleccionada == null) {
            MsgUtility.showErrorMeage("Debe seleccionar una subfamilia");
            FacesContext.getCurrentInstance().validationFailed();

        }
    }

    public void insertarSubfamilia() {
        try {
            subfamiliaNueva.setEstatus("ACTIVO");
            subfamiliasDAO.insertarSubfamilia(subfamiliaNueva);
            this.subfamilias.add(subfamiliaNueva);
            subfamiliaNueva = new Subfamilias();
            MsgUtility.showInfoMeage("La subfamilia se ingresó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void borrarSubfamilia() {
        try {
            subfamiliasDAO.borrarSubfamilia(subfamiliaSeleccionada);
            this.subfamilias.remove(subfamiliaSeleccionada);
            MsgUtility.showInfoMeage("La subfamilia se borro con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public SubfamiliasDAO getSubfamiliasDAO() {
        return subfamiliasDAO;
    }

    public void setSubfamiliasDAO(SubfamiliasDAO subfamiliasDAO) {
        this.subfamiliasDAO = subfamiliasDAO;
    }

    public List<Subfamilias> getSubfamilias() {
        return subfamilias;
    }

    public void setSubfamilias(List<Subfamilias> subfamilias) {
        this.subfamilias = subfamilias;
    }

    public List<Subfamilias> getSubfamiliasFiltradas() {
        return subfamiliasFiltradas;
    }

    public void setSubfamiliasFiltradas(List<Subfamilias> subfamiliasFiltradas) {
        this.subfamiliasFiltradas = subfamiliasFiltradas;
    }

    public Subfamilias getSubfamiliaSeleccionada() {
        return subfamiliaSeleccionada;
    }

    public void setSubfamiliaSeleccionada(Subfamilias subfamiliaSeleccionada) {
        this.subfamiliaSeleccionada = subfamiliaSeleccionada;
    }

    public Subfamilias getSubfamiliaNueva() {
        return subfamiliaNueva;
    }

    public void setSubfamiliaNueva(Subfamilias subfamiliaNueva) {
        this.subfamiliaNueva = subfamiliaNueva;
    }

    public List<Familias> getFamilias() {
        return familias;
    }

    public void setFamilias(List<Familias> familias) {
        this.familias = familias;
    }

    public FamiliasDAO getFamiliasDAO() {
        return familiasDAO;
    }

    public void setFamiliasDAO(FamiliasDAO familiasDAO) {
        this.familiasDAO = familiasDAO;
    }

    public Familias getFamiliaSeleccionada() {
        return familiaSeleccionada;
    }

    public void setFamiliaSeleccionada(Familias familiaSeleccionada) {
        this.familiaSeleccionada = familiaSeleccionada;
    }
    
    
}
