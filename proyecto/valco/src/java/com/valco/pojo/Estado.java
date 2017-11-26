/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

/**
 *
 * @author Administrador
 */
public class Estado {
    
    private String codigo;
    private Pais pais;
    private String nombre;
    private Set<Municipio> municipios = new HashSet<Municipio>();
    private Set<Localidad> localidades = new HashSet<Localidad>();

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Pais getPais() {
        return pais;
    }

    public void setPais(Pais pais) {
        this.pais = pais;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Set<Municipio> getMunicipios() {
        return municipios;
    }

    public void setMunicipios(Set<Municipio> municipios) {
        this.municipios = municipios;
    }

    public Set<Localidad> getLocalidades() {
        return localidades;
    }

    public void setLocalidades(Set<Localidad> localidades) {
        this.localidades = localidades;
    }
    
    public boolean equals(Object o){
        if( o != null){
        if(((o instanceof Estado) && (((Estado) o).getCodigo().equals(this.getCodigo())))){
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
        return Objects.hash(codigo, nombre);
    }
    

}