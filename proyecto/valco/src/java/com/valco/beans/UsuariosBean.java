/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

/**
 *
 * @author 10015097
 */
import com.valco.dao.UsuariosDAO;
import com.valco.pojo.Usuarios;

import java.io.Serializable;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

@ManagedBean
@ViewScoped

public class UsuariosBean implements Serializable {

    private UsuariosDAO usuariosDao;
    private Usuarios usuario;
    private List<Usuarios> usuarios;

    public UsuariosBean() {
    }

    @PostConstruct
    public void init() {
        usuariosDao = new UsuariosDAO();
        try {
            usuarios = usuariosDao.getUsuarios();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    public Usuarios getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuarios usuario) {
        this.usuario = usuario;
    }

    public List<Usuarios> getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(List<Usuarios> usuarios) {
        this.usuarios = usuarios;
    }

}
