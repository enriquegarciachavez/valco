/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ClienteDAO;
import com.valco.dao.CuentasContablesDAO;
import com.valco.dao.DireccionesDAO;
import com.valco.pojo.Clientes;
import com.valco.pojo.CodigoPostalView;
import com.valco.pojo.CuentasContables;
import com.valco.utility.MsgUtility;
import java.awt.event.ActionEvent;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
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
import org.primefaces.context.RequestContext;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class ClienteMainBean {

    @ManagedProperty(value = "#{clienteDao}")
    private ClienteDAO clienteDao;
    @ManagedProperty(value = "#{cuentascontablesDAO}")
    private CuentasContablesDAO cuentasContablesDAO;
    @ManagedProperty(value = "#{editarClienteBean}")
    private EditarClienteBean editarClienteBean;
    List<Clientes> clientes;
    Clientes clienteSeleccionado;
    Clientes clienteNuevo;
    DataModel modeloClientes;

    private List<String> colonias;

    /**
     * Creates a new instance of ClienteMainBean
     *
     * @return
     */
    @PostConstruct
    private void init() {
        try {
            clientes = clienteDao.getClientes();
            colonias = new ArrayList<>();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar los clientes");
        }
    }

    public void validarClienteSeleccionado(ActionEvent actionEvent) {

        if (clienteSeleccionado == null) {
            MsgUtility.showErrorMeage("Debe seleccionar un cliente");
            FacesContext.getCurrentInstance().validationFailed();
            return;
        }
        editarClienteBean.setModoOperacion("EDITAR");
        editarClienteBean.setCliente(clienteSeleccionado);
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
            Clientes clienteSeleccionado = editarClienteBean.getCliente();
            clienteSeleccionado.setUsoCFDI(editarClienteBean.getUsoSeleccionado().getCodigo());
            clienteDao.actualizarCliente(clienteSeleccionado);
            editarClienteBean.clean();
            MsgUtility.showInfoMeage("El cliente se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void insertarCliente() {
        try {
            Clientes clienteNuevo = editarClienteBean.getCliente();
            clienteNuevo.setUsoCFDI(editarClienteBean.getUsoSeleccionado().getCodigo());
            clienteDao.insertarCliente(clienteNuevo);
            MsgUtility.showInfoMeage("El cliente se ingresó con éxito");
            List<CuentasContables> cuentas = editarClienteBean.getCuentas();
            this.clientes.add(clienteNuevo);
            for (CuentasContables cuenta : cuentas) {
                cuenta.setClaveCliente(Integer.toString(clienteNuevo.getCodigo()));
            }
            cuentasContablesDAO.insertarCuentasContables(cuentas);
            editarClienteBean.clean();

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

    public ClienteMainBean() {

    }

    public String inicializarCliente() {
        this.clienteNuevo = new Clientes();
        editarClienteBean.setModoOperacion("AGREGAR");
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

    public CuentasContablesDAO getCuentasContablesDAO() {
        return cuentasContablesDAO;
    }

    public void setCuentasContablesDAO(CuentasContablesDAO cuentascontablesDAO) {
        this.cuentasContablesDAO = cuentascontablesDAO;
    }

    public List<String> getColonias() {
        return colonias;
    }

    public void setColonias(List<String> colonias) {
        this.colonias = colonias;
    }

    public EditarClienteBean getEditarClienteBean() {
        return editarClienteBean;
    }

    public void setEditarClienteBean(EditarClienteBean editarClienteBean) {
        this.editarClienteBean = editarClienteBean;
    }

}
