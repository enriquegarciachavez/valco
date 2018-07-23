/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ProveedorDAO;
import com.valco.pojo.Proveedores;
import com.valco.pojo.ProveedoresCodigo;
import com.valco.utility.MsgUtility;
import java.awt.event.ActionEvent;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
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
public class ProveedoresMainBean implements Serializable {

    @ManagedProperty(value = "#{proveedorDAO}")
    private ProveedorDAO proveedorDAO;
    @ManagedProperty(value = "#{proveedoresCodigosBean}")
    private ProveedoresCodigosBean proveedoresCodigosBean;
    List<Proveedores> proveedores;
    Proveedores proveedorSeleccionado;
    Proveedores proveedorNuevo;
    private List<ProveedoresCodigo> codigosAEliminar;
    private List<ProveedoresCodigo> codigosNuevos;
    DataModel modeloProveedores;
    UIInput codigo;
    UIInput razonSocial;
    UIInput apellidoPaterno;
    UIInput apellidoMaterno;
    UIInput nombres;
    UIInput direccion;
    UIInput codigoPostal;
    UIInput ciudad;
    UIInput estado;
    UIInput rfc;
    UIInput posicionPesoInicial;
    UIInput posicionPesoFinal;
    UIInput posicionCodigoInicial;
    UIInput posicionCodigoFinal;
    UISelectBoolean abarrotes;

    /**
     * Creates a new instance of ProveedoresMainBean
     */
    public ProveedoresMainBean() {
    }

    public void limpiarIngresarForm() {
        codigo.setValue("");
        apellidoPaterno.setValue(null);
        apellidoMaterno.setValue(null);
        nombres.setValue(null);
        direccion.setValue(null);
        codigoPostal.setValue(null);
        ciudad.setValue(null);
        estado.setValue(null);
        rfc.setValue(null);
        abarrotes.setValue(false);

    }

    @PostConstruct
    public void init() {
        try {
            codigosAEliminar = new ArrayList<>();
            proveedores = proveedorDAO.getProveedores();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void validarProveedorSeleccionado(ActionEvent actionEvent) {

        if (proveedorSeleccionado == null) {
            MsgUtility.showErrorMeage("Debe seleccionar una familia");
            FacesContext.getCurrentInstance().validationFailed();
        }
        proveedoresCodigosBean.getCodigos().clear();
        proveedoresCodigosBean.getCodigos().addAll(proveedorSeleccionado.getProveedoresCodigos());
        codigosAEliminar.addAll(proveedorSeleccionado.getProveedoresCodigos());

    }

    public void insertarProveedor() {
        try {
            proveedorNuevo.setEstatus("ACTIVO");
            proveedorNuevo.getProveedoresCodigos().addAll(proveedoresCodigosBean.getCodigos());
            for(ProveedoresCodigo codigo: proveedorNuevo.getProveedoresCodigos()){
                codigo.setProveedor(proveedorNuevo);
            }
            proveedorDAO.insertarProveedor(proveedorNuevo);
            MsgUtility.showInfoMeage("El proveedor se insertó con éxito");
            this.proveedores.add(proveedorNuevo);
            proveedorNuevo= new Proveedores();
            proveedoresCodigosBean.setCodigos(new ArrayList<ProveedoresCodigo>());
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void borrarProveedor() {
        try {
            proveedorDAO.borrarProveedor(proveedorSeleccionado);
            MsgUtility.showInfoMeage("El cliente se borró con éxito");
            this.proveedores.remove(proveedorSeleccionado);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void actualizarProveedor() {
        try {
            codigosAEliminar.removeAll(proveedoresCodigosBean.getCodigos());
            proveedorSeleccionado.getProveedoresCodigos().clear();
            proveedorSeleccionado.getProveedoresCodigos().addAll(proveedoresCodigosBean.getCodigos());
            for(ProveedoresCodigo codigo: proveedorSeleccionado.getProveedoresCodigos()){
                codigo.setProveedor(proveedorSeleccionado);
            }
            for(ProveedoresCodigo codigo: codigosAEliminar){
                codigo.setProveedor(null);
            }
            proveedorDAO.actualizarProveedor(proveedorSeleccionado,codigosAEliminar);
            codigosAEliminar.clear();
            MsgUtility.showInfoMeage("El proveedor se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void inicializarProveedor() {
        proveedorNuevo = new Proveedores();
        proveedoresCodigosBean.setCodigos(new ArrayList<ProveedoresCodigo>());
    }

    public void validarRazonSocial(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Proveedores razon = null;
        razon
                = this.proveedorDAO.getProveedoresXRazonSocial(value.toString());
        if (razon != null) {
            throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe"));
        }

    }
    
    public void validarPesoFinal(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        int pesoFinal = (int) value;
        if (pesoFinal < (int)posicionPesoInicial.getValue() ){
            throw new ValidatorException(new FacesMessage("La Posición final del peso debe ser mayor a la posición inicial"));
            
        }

    }

    public void validarModificarRazonSocial(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Proveedores razon = null;
        razon
                = this.proveedorDAO.getProveedoresXRazonSocial(value.toString());
        if (razon != null) {
            if (razon.getCodigo() != proveedorSeleccionado.getCodigo()) {
                throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe"));
            }
        }
    }

    public UIInput getCodigo() {
        return codigo;
    }

    public void setCodigo(UIInput codigo) {
        this.codigo = codigo;
    }
    
    

    public ProveedorDAO getProveedorDAO() {
        return proveedorDAO;
    }

    public void setProveedorDAO(ProveedorDAO proveedorDAO) {
        this.proveedorDAO = proveedorDAO;
    }

    public List<Proveedores> getProveedores() {
        return proveedores;
    }

    public void setProveedores(List<Proveedores> proveedores) {
        this.proveedores = proveedores;
    }

    public Proveedores getProveedorSeleccionado() {
        return proveedorSeleccionado;
    }
    public void setProveedorSeleccionado(Proveedores proveedorSeleccionado) {
        this.proveedorSeleccionado = proveedorSeleccionado;
    }

    public Proveedores getProveedorNuevo() {
        return proveedorNuevo;
    }

    public void setProveedorNuevo(Proveedores proveedorNuevo) {
        this.proveedorNuevo = proveedorNuevo;
    }

    public DataModel getModeloProveedores() {
        try {
            modeloProveedores = new ListDataModel(proveedores);
            return modeloProveedores;
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            return modeloProveedores;
        }
    }

    public void setModeloProveedores(DataModel modeloProveedores) {
        this.modeloProveedores = modeloProveedores;
    }

    public UIInput getRazonSocial() {
        return razonSocial;
    }

    public void setRazonSocial(UIInput razonSocial) {
        this.razonSocial = razonSocial;
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

    public UIInput getRfc() {
        return rfc;
    }

    public void setRfc(UIInput rfc) {
        this.rfc = rfc;
    }

    public UIInput getPosicionPesoInicial() {
        return posicionPesoInicial;
    }

    public void setPosicionPesoInicial(UIInput posicionPesoInicial) {
        this.posicionPesoInicial = posicionPesoInicial;
    }

    public UIInput getPosicionPesoFinal() {
        return posicionPesoFinal;
    }

    public void setPosicionPesoFinal(UIInput posicionPesoFinal) {
        this.posicionPesoFinal = posicionPesoFinal;
    }

    public UIInput getPosicionCodigoInicial() {
        return posicionCodigoInicial;
    }

    public void setPosicionCodigoInicial(UIInput posicionCodigoInicial) {
        this.posicionCodigoInicial = posicionCodigoInicial;
    }

    public UIInput getPosicionCodigoFinal() {
        return posicionCodigoFinal;
    }

    public void setPosicionCodigoFinal(UIInput posicionCodigoFinal) {
        this.posicionCodigoFinal = posicionCodigoFinal;
    }

    public UISelectBoolean getAbarrotes() {
        return abarrotes;
    }

    public void setAbarrotes(UISelectBoolean abarrotes) {
        this.abarrotes = abarrotes;
    }

    public ProveedoresCodigosBean getProveedoresCodigosBean() {
        return proveedoresCodigosBean;
    }

    public void setProveedoresCodigosBean(ProveedoresCodigosBean proveedoresCodigosBean) {
        this.proveedoresCodigosBean = proveedoresCodigosBean;
    }
    
    

}
