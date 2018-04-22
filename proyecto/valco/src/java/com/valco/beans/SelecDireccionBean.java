/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.DireccionesDAO;
import com.valco.pojo.CodigoPostalView;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class SelecDireccionBean {
    
    @ManagedProperty(value = "#{direccionesDAO}")
    private DireccionesDAO direccionesDAO;
    private int codigoPostal;
    private String pais;
    private String estado; 
    private String ciudad;
    private String colonia;
    private String calle;
    private int noExterior;
    private String noInterior;
    private List<String> colonias;

    /**
     * Creates a new instance of SelecDireccionBean
     */
    public SelecDireccionBean() {
        colonias = new ArrayList<>();
    }
    
    
    
    public void llenarDireccion() {
        try {
            List<CodigoPostalView> direcciones = direccionesDAO.getDireccionXCP(Integer.toString(getCodigoPostal()));
            if (direcciones.size() > 0) {
                CodigoPostalView direccion = direcciones.get(0);
                setPais(direccion.getPais());
                setEstado(direccion.getEstado());
                setCiudad(direccion.getMunicipio());
                colonias.clear();
                for (CodigoPostalView dir : direcciones) {
                    String colonia = new String(dir.getAsentamiento());
                    colonias.add(colonia);
                }

            }
        } catch (Exception ex) {
            Logger.getLogger(ClienteMainBean.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    public void clean(){
        setCodigoPostal(0);
        setPais("");
        setCiudad("");
        setEstado("");
        setColonia("");
        colonias.clear();
        setCalle("");
        setNoExterior(0);
        setNoInterior("");
    }

    public DireccionesDAO getDireccionesDAO() {
        return direccionesDAO;
    }

    public void setDireccionesDAO(DireccionesDAO direccionesDAO) {
        this.direccionesDAO = direccionesDAO;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getColonia() {
        return colonia;
    }

    public void setColonia(String colonia) {
        this.colonia = colonia;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getNoInterior() {
        return noInterior;
    }

    public void setNoInterior(String noInterior) {
        this.noInterior = noInterior;
    }

    public List<String> getColonias() {
        return colonias;
    }

    public void setColonias(List<String> colonias) {
        this.colonias = colonias;
    }

    public int getCodigoPostal() {
        return codigoPostal;
    }

    public void setCodigoPostal(int codigoPostal) {
        this.codigoPostal = codigoPostal;
    }

    public int getNoExterior() {
        return noExterior;
    }

    public void setNoExterior(int noExterior) {
        this.noExterior = noExterior;
    }
    
    
    
    
    
}
