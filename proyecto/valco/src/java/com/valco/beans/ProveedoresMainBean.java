/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ProveedorDAO;
import com.valco.pojo.Proveedores;
import java.util.List;
import java.util.logging.Level;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIInput;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class ProveedoresMainBean {

    @ManagedProperty(value = "#{proveedorDAO}")
    private ProveedorDAO proveedorDAO;
       List<Proveedores> proveedores;
    Proveedores proveedorSeleccionado;
    Proveedores proveedorNuevo;
    DataModel modeloProveedores;
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

    
    
    /**
     * Creates a new instance of ProveedoresMainBean
     */
    public ProveedoresMainBean() {
    }
    
    public void limpiarIngresarForm() {
        razonSocial.setValue(null);
        apellidoPaterno.setValue(null);
        apellidoMaterno.setValue(null);
        nombres.setValue(null);
        direccion.setValue(null);
        codigoPostal.setValue(null);
        ciudad.setValue(null);
        estado.setValue(null);
        rfc.setValue(null);
        posicionCodigoInicial.setValue(null);
        posicionCodigoFinal.setValue(null);
        posicionPesoInicial.setValue(null);
        posicionPesoFinal.setValue(null);
        
        

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

    public DataModel getModeloProveedores() throws Exception {
        proveedores = proveedorDAO.getProveedores();
        modeloProveedores = new ListDataModel(proveedores);
        return modeloProveedores;
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
    
    
    public void insertarProveedor() {
        try {
            proveedorNuevo.setEstatus("ACTIVO");
            proveedorDAO.insertarProveedor(proveedorNuevo);
           
        } catch (Exception ex) {
            
        }
    }
    public void borrarProveedor(){
        try {
            proveedorDAO.borrarProveedor(proveedorSeleccionado);
        } catch (Exception ex) {
          
        }
    }
    
     public void actualizarProveedor(){
        try {
            proveedorDAO.actualizarProveedor(proveedorSeleccionado);
        } catch (Exception ex) {
            
        }
        
    }
     public void inicializarProveedor() {
         this.proveedorNuevo = new Proveedores();
        limpiarIngresarForm();}
    
     
    
                

  
    

}
