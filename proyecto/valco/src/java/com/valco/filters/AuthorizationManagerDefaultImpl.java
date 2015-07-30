/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.filters;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Pattern;
import com.valco.dao.UsuariosAccesosDAO;
import com.valco.pojo.Accesos;
import com.valco.pojo.Usuarios;
import com.valco.pojo.UsuariosAccesos;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author 10015097
 */
public class AuthorizationManagerDefaultImpl implements AuthorizationManager {

    //Contains role mappings.
    //private Properties roleMappings;
    private Usuarios usuario;
    private Accesos acceso;
    private UsuariosAccesos usuarioAcceso;
    private List listUsuarioAcceso;
    private UsuariosAccesosDAO usuariosAccesosDAO;

    public AuthorizationManagerDefaultImpl() {
        usuariosAccesosDAO = new UsuariosAccesosDAO();  
    }

    @Override
    public boolean isUserAuthorized(String user, String uri) {
        boolean matchFound = false;
        boolean authorized = false;

        try {
            listUsuarioAcceso = usuariosAccesosDAO.getUsuariosAccesos(user,uri);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        Iterator i = listUsuarioAcceso.iterator();

        //Loop through user roles, exit once match is found.
        while ((!authorized) && (i.hasNext())) {
            UsuariosAccesos ua = (UsuariosAccesos) i.next();
            //Pattern match.  '*' should be interpreted as a wildcard for any ASCII character.
            
            String mapPattern = ((String) ua.getAccesos().getUrl().replaceAll("\\*", ".*"));
            matchFound = Pattern.matches(mapPattern, uri);

            if (matchFound && user.contains(ua.getUsuarios().getCorreo())) {
                authorized = true;
            }
        }
        return authorized;
    }

}
