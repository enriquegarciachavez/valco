/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.pojo.ProveedoresCodigo;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

/**
 *
 * @author Administrador
 */
@ManagedBean
@ViewScoped
public class ProveedoresCodigosBean {

    private ProveedoresCodigo codigoNuevo;
    private ProveedoresCodigo codigoSeleccionado;
    private List<ProveedoresCodigo> codigos;

    public ProveedoresCodigosBean() {
        codigos = new ArrayList<ProveedoresCodigo>();
        codigoNuevo = new ProveedoresCodigo();
    }
    
    public void insertarCodigo(){
        ProveedoresCodigo codigo = new ProveedoresCodigo();
        
        codigo.setDecimales(codigoNuevo.getDecimales());
        codigo.setLongMaxima(codigoNuevo.getLongMaxima());
        codigo.setLongMinima(codigoNuevo.getLongMinima());
        codigo.setPosicionCodigoFinal(codigoNuevo.getPosicionCodigoFinal());
        codigo.setPosicionCodigoInicial(codigoNuevo.getPosicionCodigoInicial());
        codigo.setPosicionPesoFinal(codigoNuevo.getPosicionPesoFinal());
        codigo.setPosicionPesoInicial(codigoNuevo.getPosicionPesoInicial());
        if(!codigos.contains(codigo)){
            codigos.add(codigo);
        }
        codigoNuevo = new ProveedoresCodigo();
    }
    
    public void eliminarCodigo(){
        codigos.remove(codigoSeleccionado);
    }

    public ProveedoresCodigo getCodigoNuevo() {
        return codigoNuevo;
    }

    public void setCodigoNuevo(ProveedoresCodigo codigoNuevo) {
        this.codigoNuevo = codigoNuevo;
    }

    public ProveedoresCodigo getCodigoSeleccionado() {
        return codigoSeleccionado;
    }

    public void setCodigoSeleccionado(ProveedoresCodigo codigoSeleccionado) {
        this.codigoSeleccionado = codigoSeleccionado;
    }

    public List<ProveedoresCodigo> getCodigos() {
        return codigos;
    }

    public void setCodigos(List<ProveedoresCodigo> codigos) {
        this.codigos = codigos;
    }

}
