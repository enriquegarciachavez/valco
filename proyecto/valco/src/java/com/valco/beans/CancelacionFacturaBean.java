/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.FacturasDAO;
import com.valco.pojo.Facturas;
import com.valco.utility.MsgUtility;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

/**
 *
 * @author Administrador
 */
@ManagedBean
@ViewScoped
public class CancelacionFacturaBean {
public Integer noFactura;
public Integer noNota;
public List<Facturas> facturasDisponibles;
public Facturas facturaSeleccionada;
@ManagedProperty(value="#{facturasDao}")
private FacturasDAO facturasDao;
private DataModel facturasModel;

    /**
     * Creates a new instance of CancelacionFacturaBean
     */
    public CancelacionFacturaBean() {
    }
    
    public void buscar() {
        try {
            this.facturasDisponibles = this.facturasDao.getFacturas(noFactura, noNota);
            facturasModel = new ListDataModel(this.facturasDisponibles);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void cancelar() {
        this.facturaSeleccionada.setEstatus("CANCELADA");
        MsgUtility.showInfoMeage("La factura se canceló correctamente.");
        try {
            this.facturasDao.actualizarFactura(facturaSeleccionada);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public Integer getNoFactura() {
        return noFactura;
    }

    public void setNoFactura(Integer noFactura) {
        this.noFactura = noFactura;
    }

    public Integer getNoNota() {
        return noNota;
    }

    public void setNoNota(Integer noNota) {
        this.noNota = noNota;
    }

    public List<Facturas> getFacturasDisponibles() {
        return facturasDisponibles;
    }

    public void setFacturasDisponibles(List<Facturas> facturasDisponibles) {
        this.facturasDisponibles = facturasDisponibles;
    }

    public Facturas getFacturaSeleccionada() {
        return facturaSeleccionada;
    }

    public void setFacturaSeleccionada(Facturas facturaSeleccionada) {
        this.facturaSeleccionada = facturaSeleccionada;
    }

    public FacturasDAO getFacturasDao() {
        return facturasDao;
    }

    public void setFacturasDao(FacturasDAO facturasDao) {
        this.facturasDao = facturasDao;
    }

    public DataModel getFacturasModel() {
        return facturasModel;
    }

    public void setFacturasModel(DataModel facturasModel) {
        this.facturasModel = facturasModel;
    }
    
    
    
}
