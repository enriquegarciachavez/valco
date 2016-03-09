/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ClienteDAO;
import com.valco.pojo.Clientes;
import com.valco.utility.MsgUtility;
import java.awt.event.ActionEvent;
import java.io.Serializable;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.component.UISelectBoolean;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.faces.validator.ValidatorException;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class ClienteMainBean {

    @ManagedProperty(value = "#{clienteDao}")
    private ClienteDAO clienteDao;
    List<Clientes> clientes;
    Clientes clienteSeleccionado;
    Clientes clienteNuevo;
    DataModel modeloClientes;
    UIInput razonSocial;
    UIInput apellidoPaterno;
    UIInput apellidoMaterno;
    UIInput nombres;
    UIInput direccion;
    UIInput colonia;
    UIInput numeroInterior;
    UIInput numeroExterior;
    UIInput codigoPostal;
    UIInput ciudad;
    UIInput estado;
    UIInput pais;
    UIInput limiteCredito;
    UIInput rfc;
    UIInput correoElectronico;
    UISelectBoolean incobrable;
    UISelectBoolean foreano;
    UIInput cuentaBancaria;
    UIInput banco;

    /**
     * Creates a new instance of ClienteMainBean
     *
     * @return
     */
    
    @PostConstruct
    private void init(){
        try {
            clientes = clienteDao.getClientes();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar los clientes");
        }
    }
    
    public void validarClienteSeleccionado(ActionEvent actionEvent) {
       
            if(clienteSeleccionado == null){
                MsgUtility.showErrorMeage("Debe seleccionar un cliente");
                FacesContext.getCurrentInstance().validationFailed();
                
            }
    }
    
     public DataModel getClientesModel() {
        try {
            modeloClientes = new ListDataModel(clientes);
            return modeloClientes;
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            return modeloClientes;
        }
    }
     
      public void actualizarCliente() {
        try {
            clienteDao.actualizarCliente(clienteSeleccionado);
            MsgUtility.showInfoMeage("El cliente se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void insertarCliente() {
        try {
            clienteNuevo.setEstatus("ACTIVO");
            clienteDao.insertarCliente(clienteNuevo);
            this.clientes.add(clienteNuevo);
            MsgUtility.showInfoMeage("El cliente se ingresó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void borrarCliente() {
        try {
            clienteDao.borrarCliente(clienteSeleccionado);
            this.clientes.remove(clienteSeleccionado);
            MsgUtility.showInfoMeage("El cliente se borro con éxito");
        } catch (Exception ex) {
           MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void validarRazonSocial(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Clientes razon = null;
        razon = 
                this.clienteDao.getClientesXRazonSocial(value.toString());
        if(razon != null){
            throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe")); 
        }
        
    }
    
    public void validarModificarRazonSocial(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Clientes razon = null;
        razon
                = this.clienteDao.getClientesXRazonSocial(value.toString());
        if (razon != null) {
            if (!razon.getCodigo().equals(clienteSeleccionado.getCodigo())) {
                throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe"));
            }
        }

    }

    public void limpiarIngresarForm() {
        apellidoPaterno.setValue(null);
        apellidoMaterno.setValue(null);
        nombres.setValue(null);
        direccion.setValue(null);
        colonia.setValue(null);
        numeroInterior.setValue(null);
        numeroExterior.setValue("");
        codigoPostal.setValue(null);
        ciudad.setValue(null);
        estado.setValue(null);
        pais.setValue(null);
        limiteCredito.setValue(null);
        rfc.setValue(null);
        correoElectronico.setValue(null);
        incobrable.setValue(false);
        foreano.setValue(false);
        cuentaBancaria.setValue(null);
        banco.setValue(null);

    }
    
    public UIInput getApellidoPaterno() {
        return apellidoPaterno;
    }

    public void setApellidoPaterno(UIInput apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }

    public UIInput getApellidoMaterno() {
        return apellidoMaterno;
    }

    public void setApellidoMaterno(UIInput apellidoMaterno) {
        this.apellidoMaterno = apellidoMaterno;
    }

    public UIInput getNombres() {
        return nombres;
    }

    public void setNombres(UIInput nombres) {
        this.nombres = nombres;
    }

    public UIInput getDireccion() {
        return direccion;
    }

    public void setDireccion(UIInput direccion) {
        this.direccion = direccion;
    }

    public UIInput getColonia() {
        return colonia;
    }

    public void setColonia(UIInput colonia) {
        this.colonia = colonia;
    }

    public UIInput getNumeroInterior() {
        return numeroInterior;
    }

    public void setNumeroInterior(UIInput numeroInterior) {
        this.numeroInterior = numeroInterior;
    }

    public UIInput getNumeroExterior() {
        return numeroExterior;
    }

    public void setNumeroExterior(UIInput numeroExterior) {
        this.numeroExterior = numeroExterior;
    }

    public UIInput getCodigoPostal() {
        return codigoPostal;
    }

    public void setCodigoPostal(UIInput codigoPostal) {
        this.codigoPostal = codigoPostal;
    }

    public UIInput getCiudad() {
        return ciudad;
    }

    public void setCiudad(UIInput ciudad) {
        this.ciudad = ciudad;
    }

    public UIInput getEstado() {
        return estado;
    }

    public void setEstado(UIInput estado) {
        this.estado = estado;
    }

    public UIInput getPais() {
        return pais;
    }

    public void setPais(UIInput pais) {
        this.pais = pais;
    }

    public UIInput getLimiteCredito() {
        return limiteCredito;
    }

    public void setLimiteCredito(UIInput limiteCredito) {
        this.limiteCredito = limiteCredito;
    }

    public UIInput getRfc() {
        return rfc;
    }

    public void setRfc(UIInput rfc) {
        this.rfc = rfc;
    }

    public UIInput getCorreoElectronico() {
        return correoElectronico;
    }

    public void setCorreoElectronico(UIInput correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    public UISelectBoolean getIncobrable() {
        return incobrable;
    }

    public void setIncobrable(UISelectBoolean incobrable) {
        this.incobrable = incobrable;
    }

    public UISelectBoolean getForeano() {
        return foreano;
    }

    public void setForeano(UISelectBoolean foreano) {
        this.foreano = foreano;
    }

    public UIInput getCuentaBancaria() {
        return cuentaBancaria;
    }

    public void setCuentaBancaria(UIInput cuentaBancaria) {
        this.cuentaBancaria = cuentaBancaria;
    }

    public UIInput getBanco() {
        return banco;
    }

    public void setBanco(UIInput banco) {
        this.banco = banco;
    }

    public UIInput getRazonSocial() {
        return razonSocial;
    }

    public void setRazonSocial(UIInput razonSocial) {
        this.razonSocial = razonSocial;
    }

    public ClienteMainBean() {

    }

    public String inicializarCliente() {
        this.clienteNuevo = new Clientes();
        limpiarIngresarForm();
        return null;
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

   

}
