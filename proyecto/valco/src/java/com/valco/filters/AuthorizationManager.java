/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.filters;

/**
 *
 * @author 10015097
 */
public interface AuthorizationManager {
    
    public boolean isUserAuthorized(String user,String uri);
    
}
