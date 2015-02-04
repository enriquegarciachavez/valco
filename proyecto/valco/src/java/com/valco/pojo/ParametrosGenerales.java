/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

/**
 *
 * @author Administrador
 */
public class ParametrosGenerales implements java.io.Serializable{
    private Integer codigo;
    private String estatus;
    private String clave;
    private String valor;
    
    public ParametrosGenerales(){
        
    }
    
    public ParametrosGenerales(Integer codigo, String estatus, String clave, String valor){
        this.codigo = codigo;
        this.estatus = estatus;
        this.clave = clave;
        this.valor = valor;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }
    
    
}
