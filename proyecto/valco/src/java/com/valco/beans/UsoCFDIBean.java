/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ClienteDAO;
import com.valco.pojo.UsoCFDI;
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
public class UsoCFDIBean {

    @ManagedProperty(value = "#{clienteDao}")
    private ClienteDAO clienteDao;
    List<UsoCFDI> usos;

    public UsoCFDIBean() {

    }

    @PostConstruct
    private void init() {
        try {
            usos = clienteDao.getUsosCFDI();
        } catch (Exception ex) {
            MsgUtility.showErrorMessage("Error", ex.getMessage());
        }
    }

    public ClienteDAO getClienteDao() {
        return clienteDao;
    }

    public void setClienteDao(ClienteDAO clienteDao) {
        this.clienteDao = clienteDao;
    }

    public List<UsoCFDI> getUsos() {
        return usos;
    }

    public void setUsos(List<UsoCFDI> usos) {
        this.usos = usos;
    }

}
