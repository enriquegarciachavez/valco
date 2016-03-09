/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.utility;

import com.valco.dao.ClienteDAO;
import com.valco.dao.ParametrosGeneralesDAO;
import com.valco.pojo.Clientes;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrador
 */
public class ClientesUtility {
    private static ParametrosGeneralesDAO parametrosGeneralesDao = new ParametrosGeneralesDAO();
    
    public static boolean isPublicoEnGeneral(Clientes cliente){
        int codigoCliente = getCodigoPublicoEnGeneral();
        
        if(cliente.getCodigo().equals(codigoCliente)){
            return true;
        }else{
            return false;
        }
        
    }
    
    public static int getCodigoPublicoEnGeneral(){
        
        String codigo = null;
        int codigoCliente = 1000;
        try {
            codigo = parametrosGeneralesDao.getParametroGeneralXClave("FA002");
        } catch (Exception ex) {
            codigo = "1000";
        }
        
        if(codigo != null && !codigo.equals("")){
            codigoCliente = Integer.parseInt(codigo);
        }
        
        return codigoCliente;
    }
    
    
    
}
