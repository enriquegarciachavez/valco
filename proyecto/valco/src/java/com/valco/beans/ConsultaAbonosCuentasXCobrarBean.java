/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.AbonosCuentasXCobrarDAO;
import com.valco.dao.ClienteDAO;
import com.valco.dao.NotasVentaDAO;
import com.valco.pojo.AbonosCuentasXCobrar;
import com.valco.pojo.Clientes;
import com.valco.pojo.CuentasXCobrar;
import com.valco.pojo.NotasDeVenta;
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
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class ConsultaAbonosCuentasXCobrarBean {

    /**
     * Creates a new instance of ConsultaAbonosCuentasXCobrarBean
     */
    
    @ManagedProperty(value = "#{abonoscuentascobrarDAO}")
        private AbonosCuentasXCobrarDAO abonoscuentascobrarDAO;
    @ManagedProperty(value="#{notadeVentaDao}")
            private NotasVentaDAO notasDeVentaDao;
    @ManagedProperty(value = "#{clienteDao}")
            private ClienteDAO clienteDao;
    List<Clientes> clientes;
    List<NotasDeVenta> notas;
    List<AbonosCuentasXCobrar> abonos;
    AbonosCuentasXCobrar abonoNuevo;
    AbonosCuentasXCobrar abonoSeleccionada;
    Clientes clienteSelecionado;
    NotasDeVenta notaSeleccionado;
    Integer nota;
    private Date fechaInicial;
    private Date fechaFinal;
    
    public ConsultaAbonosCuentasXCobrarBean() {
    }
    
    @PostConstruct
    public void init(){
        try {
            notas = new ArrayList<>();
            this.abonoSeleccionada = new AbonosCuentasXCobrar();
            this.clientes = clienteDao.getClientesConAdeudo();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void consultarAbonos(){
        try{
            notas = abonoscuentascobrarDAO.getNotasDeVenta(fechaInicial, fechaFinal, clienteSelecionado, nota, null);
        }catch(Exception ex){
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public AbonosCuentasXCobrarDAO getAbonoscuentascobrarDAO() {
        return abonoscuentascobrarDAO;
    }

    public void setAbonoscuentascobrarDAO(AbonosCuentasXCobrarDAO abonoscuentascobrarDAO) {
        this.abonoscuentascobrarDAO = abonoscuentascobrarDAO;
    }

    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }

    public List<Clientes> getClientes() {
        return clientes;
    }

    public void setClientes(List<Clientes> clientes) {
        this.clientes = clientes;
    }

    public List<NotasDeVenta> getNotas() {
        return notas;
    }

    public void setNota(List<NotasDeVenta> nota) {
        this.notas = nota;
    }

    public List<AbonosCuentasXCobrar> getAbonos() {
        return abonos;
    }

    public void setAbonos(List<AbonosCuentasXCobrar> abonos) {
        this.abonos = abonos;
    }

    public AbonosCuentasXCobrar getAbonoNuevo() {
        return abonoNuevo;
    }

    public void setAbonoNuevo(AbonosCuentasXCobrar abonoNuevo) {
        this.abonoNuevo = abonoNuevo;
    }

    public AbonosCuentasXCobrar getAbonoSeleccionado() {
        return abonoSeleccionada;
    }

    public void setAbonoSeleccionado(AbonosCuentasXCobrar abonoSeleccionado) {
        this.abonoSeleccionada = abonoSeleccionado;
    }

    public Clientes getClienteSelecionado() {
        return clienteSelecionado;
    }

    public void setClienteSelecionado(Clientes clienteSelecionado) {
        this.clienteSelecionado = clienteSelecionado;
    }

    public NotasDeVenta getNotaSeleccionado() {
        return notaSeleccionado;
    }

    public void setNotaSeleccionado(NotasDeVenta notaSeleccionado) {
        this.notaSeleccionado = notaSeleccionado;
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

    public ClienteDAO getClienteDao() {
        return clienteDao;
    }

    public void setClienteDao(ClienteDAO clienteDao) {
        this.clienteDao = clienteDao;
    }

    public AbonosCuentasXCobrar getAbonoSeleccionada() {
        return abonoSeleccionada;
    }

    public void setAbonoSeleccionada(AbonosCuentasXCobrar abonoSeleccionada) {
        this.abonoSeleccionada = abonoSeleccionada;
    }

    public Integer getNota() {
        return nota;
    }

    public void setNota(Integer nota) {
        this.nota = nota;
    }
    
    
    
}
