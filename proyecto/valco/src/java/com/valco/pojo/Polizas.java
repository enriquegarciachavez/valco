/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author Administrador
 */
public class Polizas {
    
    Integer codigo;
    Date fecha;
    String tipoPoliza;
    String estatus;
    Set<Conceptos> conceptos = new HashSet<Conceptos>(0);

    public Polizas() {
    }
    
    

    public Polizas(Integer codigo, Date fecha, String tipoPoliza, String estatus) {
        this.codigo = codigo;
        this.fecha = fecha;
        this.tipoPoliza = tipoPoliza;
        this.estatus = estatus;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getTipoPoliza() {
        return tipoPoliza;
    }

    public void setTipoPoliza(String tipoPoliza) {
        this.tipoPoliza = tipoPoliza;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public Set<Conceptos> getConceptos() {
        return conceptos;
    }

    public void setConceptos(Set<Conceptos> conceptos) {
        this.conceptos = conceptos;
    }
    
    
    
}
