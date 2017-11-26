/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.util.Objects;

/**
 *
 * @author Administrador
 */
public class Colonia {

    private Integer codigo;
    private CodigoPostal codigoPostal;
    private String descripcion;

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public CodigoPostal getCodigoPostal() {
        return codigoPostal;
    }

    public void setCodigoPostal(CodigoPostal codigoPostal) {
        this.codigoPostal = codigoPostal;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public boolean equals(Object o){
        if( o != null){
        if((o instanceof Colonia) && (((Colonia) o).getCodigo().equals(this.getCodigo()))){
            return true;
        }else{
            return false;
           }
        }else{
            return false;
        }
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(codigo,descripcion);
    }

    
    
}
