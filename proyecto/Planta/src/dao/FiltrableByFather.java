/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.Collection;

/**
 *
 * @author Administrador
 */
public interface FiltrableByFather  {

    public Collection getElementsByFather(Object father) throws Exception;

    public Object[] getElementsByFatherArray(Object father);
    
    public Object getElementByFatherAndCriteria(Object father, String criteria) throws Exception;

}
