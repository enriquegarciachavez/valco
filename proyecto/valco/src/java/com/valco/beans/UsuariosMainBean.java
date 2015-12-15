/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.UbicacionesDAO;
import com.valco.dao.UsuariosDAO;
import com.valco.pojo.Grupos;
import com.valco.pojo.Ubicaciones;
import com.valco.pojo.Usuarios;
import com.valco.utility.MsgUtility;
import static groovy.xml.dom.DOMCategory.text;
import java.awt.event.ActionEvent;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
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
public class UsuariosMainBean {

    @ManagedProperty(value = "#{usuariosDao}")
    private UsuariosDAO usuariosDao;

    @ManagedProperty(value = "#{ubicacionesDao}")
    private UbicacionesDAO ubicacionesDao;
    List<Usuarios> usuarios;
    List<Ubicaciones> ubicaciones;
    List<Grupos> grupos;
    Usuarios usuarioNuevo;
    Usuarios usuarioSeleccionado;
    DataModel modeloUsuarios;
    UIInput correo;
    UIInput nombre;
    UIInput apellidoPaterno;
    UIInput apellidoMaterno;
    UIInput password;

    /**
     * Creates a new instance of UsuariosMainBean
     */
    public UsuariosMainBean() {
    }
    
    

    public UsuariosDAO getUsuariosDao() {
        return usuariosDao;
    }

    public void setUsuariosDao(UsuariosDAO usuariosDao) {
        this.usuariosDao = usuariosDao;
    }

    public UbicacionesDAO getUbicacionesDao() {
        return ubicacionesDao;
    }

    public void setUbicacionesDao(UbicacionesDAO ubicacionesDao) {
        this.ubicacionesDao = ubicacionesDao;
    }

    public List<Usuarios> getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(List<Usuarios> usuarios) {
        this.usuarios = usuarios;
    }

    public List<Ubicaciones> getUbicaciones() {
        return ubicaciones;
    }

    public void setUbicaciones(List<Ubicaciones> ubicaciones) {
        this.ubicaciones = ubicaciones;
    }

    public Usuarios getUsuarioNuevo() {
        return usuarioNuevo;
    }

    public void setUsuarioNuevo(Usuarios usuarioNuevo) {
        this.usuarioNuevo = usuarioNuevo;
    }

    public Usuarios getUsuarioSeleccionado() {
        return usuarioSeleccionado;
    }

    public void setUsuarioSeleccionado(Usuarios usuarioSeleccionado) {
        this.usuarioSeleccionado = usuarioSeleccionado;
    }

    public DataModel getModeloUsuarios() {
        try {
            usuarios = usuariosDao.getUsuarios();
            modeloUsuarios = new ListDataModel(usuarios);
            return modeloUsuarios;
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            return modeloUsuarios;
        }
    }

    public void setModeloUsuarios(DataModel modeloUsuarios) {
        this.modeloUsuarios = modeloUsuarios;
    }

    public UIInput getCorreo() {
        return correo;
    }

    public void setCorreo(UIInput correo) {
        this.correo = correo;
    }

    public UIInput getNombre() {
        return nombre;
    }

    public void setNombre(UIInput nombre) {
        this.nombre = nombre;
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

    public UIInput getPassword() {
        return password;
    }

    public void setPassword(UIInput password) {
        this.password = password;
    }

    public void insertarUsuario() {
        try {
            usuarioNuevo.setEstatus("ACTIVO");
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(usuarioNuevo.getPassword().getBytes(StandardCharsets.UTF_8));
            String shaPass = bytesToHex(hash);
            usuarioNuevo.setPassword(shaPass);            
            usuariosDao.insertarUsuario(usuarioNuevo);
            MsgUtility.showInfoMeage("El usuario se insertó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void actualizarUsuario() {
        try {
            usuariosDao.actualizarUsuario(usuarioSeleccionado);
            MsgUtility.showInfoMeage("El usuario se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void borrarUsuario() {
        try {
            usuariosDao.borrarUsuario(usuarioSeleccionado);
            MsgUtility.showInfoMeage("El usuario se borró con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void limpiarIngresarForm() {
        correo.setValue(null);
        nombre.setValue(null);
        apellidoPaterno.setValue(null);
        apellidoMaterno.setValue(null);

    }

    public void inicializarUsuario() {
        this.usuarioNuevo = new Usuarios();
        limpiarIngresarForm();
    }

    @PostConstruct
    public void init() {
        try {
            
            this.ubicaciones = ubicacionesDao.getUbicaciones();
        } catch (Exception ex) {

        }
    }
    
    

    public void validarUsuarioSeleccionada(ActionEvent actionEvent) {

        if (usuarioSeleccionado == null) {
            MsgUtility.showErrorMeage("Debe seleccionar un usuario");
            FacesContext.getCurrentInstance().validationFailed();

        }

    }

    public void validarCorreo(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Usuarios correo = null;
        correo
                = this.usuariosDao.getUsuariosXCorreo(value.toString());
        if (correo != null) {
            throw new ValidatorException(new FacesMessage("El correo que capturó ya existe"));
        }

    }

    public void validarModificarCorreo(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Usuarios correo = null;
        correo
                = this.usuariosDao.getUsuariosXCorreo(value.toString());
        if (correo != null) {
            if (correo.getCodigo() != usuarioSeleccionado.getCodigo()) {
                throw new ValidatorException(new FacesMessage("El correo que capturó ya existe"));
            }
        }
    }
    
    private static String bytesToHex(byte[] bytes) {
        StringBuffer result = new StringBuffer();
        for (byte byt : bytes) {
            result.append(Integer.toString((byt & 0xff) + 0x100, 16).substring(1));
        }
        return result.toString();
    }

    public List<Grupos> getGrupos() {
        return grupos;
    }

    public void setGrupos(List<Grupos> grupos) {
        this.grupos = grupos;
    }
    
    

}
