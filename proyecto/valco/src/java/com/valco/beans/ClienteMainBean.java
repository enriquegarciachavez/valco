/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ClienteDAO;
import com.valco.pojo.Clientes;
import java.awt.event.ActionEvent;
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
    Clientes clienteNuevo;
    DataModel modeloClientes;

    /**
     * Creates a new instance of ClienteMainBean
     * @return 
     */
    
    
    
    public ClienteMainBean() {
        clienteNuevo=new Clientes();
        
    }
    public DataModel getClientesModel() throws Exception{
        clientes = clienteDao.getClientes();
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
    
    public Clientes getClienteNuevo() {
        return clienteNuevo;
    }

    public void setClienteNuevo(Clientes clienteNuevo) {
        this.clienteNuevo = clienteNuevo;
    }
    
    public void actualizarCliente(){
        try {
            clienteDao.actualizarCliente(clienteSeleccionado);
        } catch (Exception ex) {
            Logger.getLogger(ClienteMainBean.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    public void insertarCliente() {
        try {
            clienteNuevo.setEstatus("ACTIVO");
            clienteDao.insertarCliente(clienteNuevo);
        } catch (Exception ex) {
            Logger.getLogger(ClienteMainBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void borrarCliente(){
        try {
            clienteDao.borrarCliente(clienteSeleccionado);
        } catch (Exception ex) {
            Logger.getLogger(ClienteMainBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
