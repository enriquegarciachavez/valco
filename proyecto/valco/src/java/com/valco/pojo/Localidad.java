/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author Administrador
 */
public class Localidad implements Serializable{
    
    private String codigoLocalidad;
    private String codigoEstado;
    private Estado estado;
    private String Descripcion;
    private Set<CodigoPostal> codigosPostales = new HashSet<CodigoPostal>();

    public String getCodigoLocalidad() {
        return codigoLocalidad;
    }

    public void setCodigoLocalidad(String codigoLocalidad) {
        this.codigoLocalidad = codigoLocalidad;
    }

    public String getCodigoEstado() {
        return codigoEstado;
    }

    public void setCodigoEstado(String codigoEstado) {
        this.codigoEstado = codigoEstado;
    }

    

    public Estado getEstado() {
        return estado;
    }

    public void setEstado(Estado estado) {
        this.estado = estado;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public Set<CodigoPostal> getCodigosPostales() {
        return codigosPostales;
    }

    public void setCodigosPostales(Set<CodigoPostal> codigosPostales) {
        this.codigosPostales = codigosPostales;
    }
}
