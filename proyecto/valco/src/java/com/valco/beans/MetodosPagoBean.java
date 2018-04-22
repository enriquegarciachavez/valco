/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.FacturasDAO;
import com.valco.pojo.MetodosPago;
import com.valco.utility.MsgUtility;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class MetodosPagoBean {

    @ManagedProperty(value = "#{facturasDao}")
    private FacturasDAO facturasDao;
    private List<MetodosPago> metodosPago = new ArrayList<>();

    /**
     * Creates a new instance of MetodosPagoBean
     */
    public MetodosPagoBean() {
    }

    @PostConstruct
    public void init() {
        try {
            metodosPago = facturasDao.getMetodosPago();
        } catch (Exception ex) {
            MsgUtility.showErrorMessage(ex.getMessage(), ex.getMessage());
        }
    }

    public FacturasDAO getFacturasDao() {
        return facturasDao;
    }

    public void setFacturasDao(FacturasDAO facturasDao) {
        this.facturasDao = facturasDao;
    }

    public List<MetodosPago> getMetodosPago() {
        return metodosPago;
    }

    public void setMetodosPago(List<MetodosPago> metodosPago) {
        this.metodosPago = metodosPago;
    }

}
