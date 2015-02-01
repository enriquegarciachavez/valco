/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.NotasVentaDAO;
import com.valco.dao.RepartidoresDAO;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.Repartidores;
import com.valco.utility.MsgUtility;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

/**
 *
 * @author Administrador
 */
@ManagedBean
@ViewScoped
public class ConsultaNotasXRepartidorBean {

    /**
     * Creates a new instance of ConsultaNotasXRepartidorBean
     */
    public ConsultaNotasXRepartidorBean() {
    }
    
    @ManagedProperty(value="#{notadeVentaDao}")
            private NotasVentaDAO notadeVentaDao;
    @ManagedProperty(value="#{repartidoresDao}")
            private RepartidoresDAO repartidoresDao;
    private List<Repartidores> repartidores;
    private Repartidores repartidorSeleccionado;
    private Date fechaInicial;
    private Date fechaFinal;
    private String estatus;
    private List<NotasDeVenta> notas;
    
    @PostConstruct
    public void inicializar(){
        try{
            notas = new ArrayList<>();
            repartidorSeleccionado = new Repartidores();
            repartidores = repartidoresDao.getRepartidores();
        }catch(Exception ex){
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void consultarNotas() {
        try {
            notas = notadeVentaDao.getNotasDeVenta(repartidorSeleccionado, fechaInicial, fechaFinal, estatus);
            if(notas == null || notas.size() == 0){
                MsgUtility.showInfoMeage("No se encontraron notas con los criterios utilizados.");
            }
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public NotasVentaDAO getNotadeVentaDao() {
        return notadeVentaDao;
    }

    public void setNotadeVentaDao(NotasVentaDAO notadeVentaDao) {
        this.notadeVentaDao = notadeVentaDao;
    }

    public RepartidoresDAO getRepartidoresDao() {
        return repartidoresDao;
    }

    public void setRepartidoresDao(RepartidoresDAO repartidoresDao) {
        this.repartidoresDao = repartidoresDao;
    }

    public List<Repartidores> getRepartidores() {
        return repartidores;
    }

    public void setRepartidores(List<Repartidores> repartidores) {
        this.repartidores = repartidores;
    }

    public Repartidores getRepartidorSeleccionado() {
        return repartidorSeleccionado;
    }

    public void setRepartidorSeleccionado(Repartidores repartidorSeleccionado) {
        this.repartidorSeleccionado = repartidorSeleccionado;
    }

    public Date getFechaInicial() {
        return fechaInicial;
    }

    public void setFechaInicial(Date fechaInicial) {
        this.fechaInicial = fechaInicial;
    }

    public Date getFechaFinal() {
        return fechaFinal;
    }

    public void setFechaFinal(Date fechaFinal) {
        this.fechaFinal = fechaFinal;
    }

    public String getEstatus() {
        return estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public List<NotasDeVenta> getNotas() {
        return notas;
    }

    public void setNotas(List<NotasDeVenta> notas) {
        this.notas = notas;
    }
    
    
}
