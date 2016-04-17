/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import dao.ParametrosGeneralesDAO;

/**
 *
 * @author Administrador
 */
public class ParametrosGeneralesUtility {
    private static ParametrosGeneralesDAO parametrosDao = new ParametrosGeneralesDAO();
    
    public static String getValor(String clave) throws Exception{
        return parametrosDao.getParametroGeneralXClave(clave);
    }
}
