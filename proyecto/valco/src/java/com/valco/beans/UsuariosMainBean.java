/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.UbicacionesDAO;
import com.valco.dao.UsuariosDAO;
import com.valco.pojo.Ubicaciones;
import com.valco.pojo.Usuarios;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
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
public class UsuariosMainBean {
    
    @ManagedProperty(value = "#{usuariosDao}")
        private UsuariosDAO usuariosDao;
    
    @ManagedProperty(value = "#{ubicacionesDao}")
        private UbicacionesDAO ubicacionesDao;
    List<Usuarios> usuarios;
    List<Ubicaciones> ubicaciones;
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

    public DataModel getModeloUsuarios() throws Exception {
        usuarios = usuariosDao.getUsuarios();
        modeloUsuarios = new ListDataModel(usuarios);
        return modeloUsuarios;
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
            usuariosDao.insertarUsuario(usuarioNuevo);
        } catch (Exception ex) {
            
        }
    }
    
    
    public void actualizarUsuario() {
        try {
            usuariosDao.actualizarUsuario(usuarioSeleccionado);
        } catch (Exception ex) {
            
        }

    }

    public void borrarUsuario() {
        try {
            usuariosDao.borrarUsuario(usuarioSeleccionado);
        } catch (Exception ex) {
            
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
        limpiarIngresarForm();}
    
    @PostConstruct
    public void init(){
        try {
            this.ubicaciones = ubicacionesDao.getUbicaciones();
            } catch (Exception ex) {
            
        }
    }

     
    
}
