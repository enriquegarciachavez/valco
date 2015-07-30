/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import javax.faces.bean.ManagedBean;
import com.valco.pojo.Usuarios;
import com.valco.pojo.Accesos;
import com.valco.pojo.UsuariosAccesos;
import com.valco.dao.UsuariosAccesosDAO;
import com.valco.utility.MsgUtility;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.bean.ViewScoped;
import javax.faces.event.ValueChangeEvent;

/**
 *
 * @author 10015097
 */
@ManagedBean
@ViewScoped
public class UsuariosAccesosBean implements java.io.Serializable {

    private UsuariosAccesosDAO usuariosAccesosDao;
    private UsuariosAccesos usuarioAcceso;
    private List<UsuariosAccesos> usuariosAccesos;
    private UsuariosAccesos[] selectedUsuariosAccesos;
    private List<UsuariosAccesos> listDeleteUsuariosAccesos;

    @PostConstruct
    public void init() {
        usuarioAcceso = new UsuariosAccesos();
        usuariosAccesosDao = new UsuariosAccesosDAO();
        try {
            usuariosAccesos = usuariosAccesosDao.getUsuariosAccesos();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    public Usuarios getUsuarios() {
        return usuarioAcceso.getUsuarios();
    }

    public void setUsuarios(Usuarios usuarios) {
        this.usuarioAcceso.setUsuarios(usuarios);
    }

    public Accesos getAccesos() {
        return usuarioAcceso.getAccesos();
    }

    public void setAccesos(Accesos accesos) {
        this.usuarioAcceso.setAccesos(accesos);
    }

    public UsuariosAccesos[] getSelectedUsuariosAccesos() {
        return selectedUsuariosAccesos;
    }

    public void setSelectedUsuariosAccesos(UsuariosAccesos[] selectedUsuariosAccesos) {
        this.selectedUsuariosAccesos = selectedUsuariosAccesos;
    }

    public void setUsuarioAcceso(UsuariosAccesos usuarioAcceso) {
        this.usuarioAcceso = usuarioAcceso;
    }

    public void setUsuariosAccesos(List<UsuariosAccesos> usuariosAccesos) {
        this.usuariosAccesos = usuariosAccesos;
    }

    public UsuariosAccesos getUsuarioAcceso() {
        return usuarioAcceso;
    }

    public List<UsuariosAccesos> getUsuariosAccesos() {
        return usuariosAccesos;
    }

}
