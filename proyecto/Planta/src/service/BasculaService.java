/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

/**
 *
 * @author Karla
 */
public interface BasculaService {
    public void imprimitCodigoBarras(String producto, String peso, String codigoBarras);
    public String armarCodigoBarras(String letra, int codigoProducto, int peso, int consecutivo);
}
