/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.FacturasDAO;
import com.valco.pojo.FormaPago;
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
public class FormaPagoBean {

    @ManagedProperty(value = "#{facturasDao}")
    private FacturasDAO facturasDao;
    private List<FormaPago> formasPago = new ArrayList<>();

    /**
     * Creates a new instance of FormaPagoBean
     */
    public FormaPagoBean() {

    }

    @PostConstruct
    public void init() {

        try {
            formasPago = facturasDao.getFormasPago();
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

    public List<FormaPago> getFormasPago() {
        return formasPago;
    }

    public void setFormasPago(List<FormaPago> formasPago) {
        this.formasPago = formasPago;
    }

}
