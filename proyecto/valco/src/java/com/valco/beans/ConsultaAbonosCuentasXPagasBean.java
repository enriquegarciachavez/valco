/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.AbonosCuentasXPagarDAO;
import com.valco.dao.OrdenesCompraDAO;
import com.valco.dao.ProveedorDAO;
import com.valco.pojo.AbonosCuentasXPagar;
import com.valco.pojo.OrdenesCompra;
import com.valco.pojo.Proveedores;
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
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class ConsultaAbonosCuentasXPagasBean {

    /**
     * Creates a new instance of ConsultaAbonosCuentasXPagasBean
     */
    
    @ManagedProperty(value = "#{abonoscuentaspagarDAO}")
        private AbonosCuentasXPagarDAO abonoscuentaspagarDAO;
    @ManagedProperty(value="#{ordenesCompraDao}")
            private OrdenesCompraDAO ordenesCompraDao;
    @ManagedProperty(value = "#{proveedorDAO}")
            private ProveedorDAO proveedorDAO;
    
    List<Proveedores> proveedor;
    List<OrdenesCompra> ordenes;
    List<AbonosCuentasXPagar> abonos;
    AbonosCuentasXPagar abonoNuevo;
    AbonosCuentasXPagar abonoSeleccionada;
    Proveedores proveedorSelecionado;
    OrdenesCompra ordenSeleccionado;
    Integer orden;
    private Date fechaInicial;
    private Date fechaFinal;
    
    
    public ConsultaAbonosCuentasXPagasBean() {
    }
    
    
    @PostConstruct
    public void init(){
        try {
            ordenes = new ArrayList<>();
            this.abonoSeleccionada = new AbonosCuentasXPagar();
            this.proveedor = proveedorDAO.getProveedorAPagar();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void consultarAbonos(){
        try{            
            ordenes = abonoscuentaspagarDAO.getOrdenesCompra(fechaInicial, fechaFinal, proveedorSelecionado, orden, null);
        }catch(Exception ex){
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    

    public Integer getOrden() {
        return orden;
    }

    public void setOrden(Integer orden) {
        this.orden = orden;
    }
    
    public AbonosCuentasXPagarDAO getAbonoscuentaspagarDAO() {
        return abonoscuentaspagarDAO;
    }

    public void setAbonoscuentaspagarDAO(AbonosCuentasXPagarDAO abonoscuentaspagarDAO) {
        this.abonoscuentaspagarDAO = abonoscuentaspagarDAO;
    }

    public OrdenesCompraDAO getOrdenesCompraDao() {
        return ordenesCompraDao;
    }

    public void setOrdenesCompraDao(OrdenesCompraDAO ordenesCompraDao) {
        this.ordenesCompraDao = ordenesCompraDao;
    }

    public ProveedorDAO getProveedorDAO() {
        return proveedorDAO;
    }

    public void setProveedorDAO(ProveedorDAO proveedorDAO) {
        this.proveedorDAO = proveedorDAO;
    }

    public List<Proveedores> getProveedor() {
        return proveedor;
    }

    public void setProveedor(List<Proveedores> proveedor) {
        this.proveedor = proveedor;
    }

    public List<OrdenesCompra> getOrdenes() {
        return ordenes;
    }

    public void setOrdenes(List<OrdenesCompra> ordenes) {
        this.ordenes = ordenes;
    }

    public List<AbonosCuentasXPagar> getAbonos() {
        return abonos;
    }

    public void setAbonos(List<AbonosCuentasXPagar> abonos) {
        this.abonos = abonos;
    }

    public AbonosCuentasXPagar getAbonoNuevo() {
        return abonoNuevo;
    }

    public void setAbonoNuevo(AbonosCuentasXPagar abonoNuevo) {
        this.abonoNuevo = abonoNuevo;
    }

    public AbonosCuentasXPagar getAbonoSeleccionada() {
        return abonoSeleccionada;
    }

    public void setAbonoSeleccionada(AbonosCuentasXPagar abonoSeleccionada) {
        this.abonoSeleccionada = abonoSeleccionada;
    }

    public Proveedores getProveedorSelecionado() {
        return proveedorSelecionado;
    }

    public void setProveedorSelecionado(Proveedores proveedorSelecionado) {
        this.proveedorSelecionado = proveedorSelecionado;
    }

    public OrdenesCompra getOrdenSeleccionado() {
        return ordenSeleccionado;
    }

    public void setOrdenSeleccionado(OrdenesCompra ordenSeleccionado) {
        this.ordenSeleccionado = ordenSeleccionado;
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
    
    
}
