/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author Administrador
 */
public class CodigoPostal {
  
    private String codigo;
    private Estado estado;
    private Localidad localidad;
    private Municipio municipio;
    private Set<Colonia> colonias = new HashSet<Colonia>();

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Estado getEstado() {
        return estado;
    }

    public void setEstado(Estado estado) {
        this.estado = estado;
    }

    public Localidad getLocalidad() {
        return localidad;
    }

    public void setLocalidad(Localidad localidad) {
        this.localidad = localidad;
    }

    public Municipio getMunicipio() {
        return municipio;
    }

    public void setMunicipio(Municipio municipio) {
        this.municipio = municipio;
    }

    public Set<Colonia> getColonias() {
        return colonias;
    }

    public void setColonias(Set<Colonia> colonias) {
        this.colonias = colonias;
    }
    
    
}
