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
public class Pais {
    
    private String codigo;
    private String descripcion;
    private String formatoCodigoPostal;
    private String formatoRit;
    private String validacionRit;
    private String agrupaciones;
    private Set<Estado> estados = new HashSet<Estado>();

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getFormatoCodigoPostal() {
        return formatoCodigoPostal;
    }

    public void setFormatoCodigoPostal(String formatoCodigoPostal) {
        this.formatoCodigoPostal = formatoCodigoPostal;
    }

    public Set<Estado> getEstados() {
        return estados;
    }

    public void setEstados(Set<Estado> estados) {
        this.estados = estados;
    }

    public String getFormatoRit() {
        return formatoRit;
    }

    public void setFormatoRit(String formatoRit) {
        this.formatoRit = formatoRit;
    }

    public String getValidacionRit() {
        return validacionRit;
    }

    public void setValidacionRit(String validacionRit) {
        this.validacionRit = validacionRit;
    }

    public String getAgrupaciones() {
        return agrupaciones;
    }

    public void setAgrupaciones(String agrupaciones) {
        this.agrupaciones = agrupaciones;
    }
    
    public boolean equals(Object o){
        if( o != null){
        if(((o instanceof Pais) && (((Pais) o).getCodigo().equals(this.getCodigo())))){
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
        return Objects.hash(codigo, descripcion);
    }
    
}
