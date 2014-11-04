/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ClienteDAO;
import com.valco.pojo.Clientes;
import java.io.Serializable;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.bean.ViewScoped;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class ClienteMainBean implements Serializable{
    @ManagedProperty(value="#{clienteDao}")
    private ClienteDAO clienteDao;
    List<Clientes> clientes;
    Clientes clienteSeleccionado;
    DataModel modeloClientes;

    /**
     * Creates a new instance of ClienteMainBean
     */
    public ClienteMainBean() {
        try {
            
            clientes= clienteDao.getClientes();
        } catch (Exception ex) {
            Logger.getLogger(ClienteMainBean.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    public DataModel getClientesModel(){
        modeloClientes= new ListDataModel(clientes);
        return modeloClientes;
    }

    public ClienteDAO getClienteDao() {
        return clienteDao;
    }

    public void setClienteDao(ClienteDAO clienteDao) {
        this.clienteDao = clienteDao;
    }

    public List<Clientes> getClientes() {
        return clientes;
    }

    public void setClientes(List<Clientes> clientes) {
        this.clientes = clientes;
    }

    public Clientes getClienteSeleccionado() {
        return clienteSeleccionado;
    }

    public void setClienteSeleccionado(Clientes clienteSeleccionado) {
        this.clienteSeleccionado = clienteSeleccionado;
    }

    public DataModel getModeloClientes() {
        return modeloClientes;
    }

    public void setModeloClientes(DataModel modeloClientes) {
        this.modeloClientes = modeloClientes;
    }
    
}
