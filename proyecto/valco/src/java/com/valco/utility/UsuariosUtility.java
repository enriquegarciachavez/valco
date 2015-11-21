/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.utility;

import com.valco.dao.UsuariosDAO;
import com.valco.pojo.Usuarios;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;

/**
 *
 * @author Karla
 */
public class UsuariosUtility {

    
    private static UsuariosDAO usuariosDao = new UsuariosDAO();

    public static Usuarios getUsuarioFirmado() {
        String correo = null;
        Usuarios usuario = new Usuarios();
        correo = FacesContext.getCurrentInstance().getExternalContext().getRemoteUser();
        try {
            usuario = usuariosDao.getUsuariosXCorreo(correo);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        return usuario;
    }

}
