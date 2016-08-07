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
public interface DAO {

    public Collection getElements() throws Exception;

    public Object getElementsByCodeOrDesc(String criteria) throws Exception;

    public Object[] getElementsArray();

   

}
