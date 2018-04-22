/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ClienteDAO;
import com.valco.pojo.Clientes;
import com.valco.pojo.CuentasContables;
import com.valco.pojo.UsoCFDI;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.ValidatorException;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class EditarClienteBean {

    @ManagedProperty(value = "#{clienteDao}")
    private ClienteDAO clienteDao;
    @ManagedProperty(value = "#{selecDireccionBean}")
    private SelecDireccionBean selecDireccionBean;
    @ManagedProperty(value = "#{cuentasBancariasBean}")
    private CuentasBancariasBean cuentasBancariasBean;
    private Clientes cliente;
    private String modoOperacion;
    private UsoCFDI usoSeleccionado;

    /**
     * Creates a new instance of EditarClienteBean
     */
    public EditarClienteBean() {
        cliente = new Clientes();
    }

    public void validarRazonSocial(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Clientes razon = null;
        razon = this.clienteDao.getClientesXRazonSocial(value.toString());
        if (razon != null) {
            if ("AGREGAR".equals(modoOperacion) || !razon.getCodigo().equals(cliente.getCodigo())) {
                throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe"));
            }
        }
    }

    public void clean() {
        selecDireccionBean.clean();
        cuentasBancariasBean.clean();
        cliente = new Clientes();
    }

    public List<CuentasContables> getCuentas() {
        return cuentasBancariasBean.getCuentas();
    }

    public Clientes getCliente() {
        cliente.setEstatus("ACTIVO");
        cliente.setCodigoPostal(selecDireccionBean.getCodigoPostal());
        cliente.setPais(selecDireccionBean.getPais());
        cliente.setEstado(selecDireccionBean.getEstado());
        cliente.setCiudad(selecDireccionBean.getCiudad());
        cliente.setColonia(selecDireccionBean.getColonia());
        cliente.setCalle(selecDireccionBean.getCalle());
        cliente.setNumeroExterior(selecDireccionBean.getNoExterior());
        cliente.setNumeroInterior(selecDireccionBean.getNoInterior());
        return cliente;
    }

    public void setCliente(Clientes cliente) {
        this.cliente = cliente;
        usoSeleccionado = new UsoCFDI(cliente.getUsoCFDI());
        selecDireccionBean.setCodigoPostal(cliente.getCodigoPostal());
        selecDireccionBean.setPais(cliente.getPais());
        selecDireccionBean.setEstado(cliente.getEstado());
        selecDireccionBean.setCiudad(cliente.getCiudad());
        selecDireccionBean.setColonia(cliente.getColonia());
        selecDireccionBean.setCalle(cliente.getCalle());
        selecDireccionBean.setNoExterior(cliente.getNumeroExterior());
        selecDireccionBean.setNoInterior(cliente.getNumeroInterior());
        selecDireccionBean.llenarDireccion();

    }

    public ClienteDAO getClienteDao() {
        return clienteDao;
    }

    public void setClienteDao(ClienteDAO clienteDao) {
        this.clienteDao = clienteDao;
    }

    public SelecDireccionBean getSelecDireccionBean() {
        return selecDireccionBean;
    }

    public void setSelecDireccionBean(SelecDireccionBean selecDireccionBean) {
        this.selecDireccionBean = selecDireccionBean;
    }

    public CuentasBancariasBean getCuentasBancariasBean() {
        return cuentasBancariasBean;
    }

    public void setCuentasBancariasBean(CuentasBancariasBean cuentasBancariasBean) {
        this.cuentasBancariasBean = cuentasBancariasBean;
    }

    public String getModoOperacion() {
        return modoOperacion;
    }

    public void setModoOperacion(String modoOperacion) {
        this.modoOperacion = modoOperacion;
    }

    public UsoCFDI getUsoSeleccionado() {
        return usoSeleccionado;
    }

    public void setUsoSeleccionado(UsoCFDI usoSeleccionado) {
        this.usoSeleccionado = usoSeleccionado;
    }
    
    

}
