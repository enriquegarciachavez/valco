/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.sun.xml.rpc.processor.modeler.j2ee.xml.string;
import com.valco.dao.ClienteDAO;
import com.valco.dao.FacturasDAO;
import com.valco.dao.NotasVentaDAO;
import com.valco.pojo.Clientes;
import com.valco.pojo.Facturas;
import com.valco.pojo.NotasDeVenta;
import com.valco.utility.MsgUtility;
import https.test_paxfacturacion_com_mx._453.WcfRecepcionASMX;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import org.primefaces.model.DualListModel;

/**
 *
 * @author Administrador
 */
@ManagedBean
@ViewScoped
public class CreacionFacturaBean {
    @ManagedProperty(value="#{notadeVentaDao}")
    private NotasVentaDAO notasDeVentaDao;
    @ManagedProperty(value="#{clienteDao}")
    private ClienteDAO clienteDao;
    @ManagedProperty(value="#{facturasDao}")
    private FacturasDAO facturasDao;
    private DualListModel<NotasDeVenta> notasDeVenta;
    private List<Clientes> clientes;
    private Clientes clienteSeleccionado;
    private Double iva;
    private String metodoPago;
    private String observaciones;
    /**
     * Creates a new instance of CreacionFacturaBean
     */
    public CreacionFacturaBean() {
    }
    
    @PostConstruct
    public void inicializar(){
        try{
            notasDeVenta = new DualListModel();
            clientes = clienteDao.getClientes();
        }catch(Exception ex){
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void consultarNotasXCliente(){
        try {
            List<NotasDeVenta> notasDisponibles = notasDeVentaDao.getNotasDeVentaXCliente(clienteSeleccionado);
            List<NotasDeVenta> notasSeleccionadas = new ArrayList<>();
            notasDeVenta.setSource(notasDisponibles);
            notasDeVenta.setTarget(notasSeleccionadas);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void facturar(){
        try{
            if(notasDeVenta.getTarget().isEmpty()){
                MsgUtility.showInfoMeage("Debe de seleccionar una nota de venta para facturar.");
                return;
            }
            for(NotasDeVenta nota : notasDeVenta.getTarget()){
                Facturas factura = new Facturas();
                factura.setFecha(new Date());
                factura.setEstatus("ACTIVO");
                factura.setFormaPago(metodoPago);
                factura.setIva(new BigDecimal(iva));
                factura.setObservaciones(observaciones);
                factura.setSubtotal(nota.getTotal());
                factura.setTotal(new BigDecimal(nota.getTotal().doubleValue()*(iva+1)));
                factura.setXml(metodoPago);
                nota.setFacturas(factura);
            }
            facturasDao.insertarFacturasYActualizarNotas(notasDeVenta.getTarget());
            MsgUtility.showInfoMeage("Las facturas se generaron corectamente.");
        }catch(Exception e){
            MsgUtility.showErrorMeage(e.getMessage());
        }
    }

    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }

    public ClienteDAO getClienteDao() {
        return clienteDao;
    }

    public void setClienteDao(ClienteDAO clienteDao) {
        this.clienteDao = clienteDao;
    }

    public DualListModel<NotasDeVenta> getNotasDeVenta() {
        return notasDeVenta;
    }

    public void setNotasDeVenta(DualListModel<NotasDeVenta> notasDeVenta) {
        this.notasDeVenta =  notasDeVenta;
    }

    public List<Clientes> getClientes() {
        return clientes;
    }

    public void setClientes(List<Clientes> clientes) {
        this.clientes = clientes;
    }

    public Clientes getClienteSeleccionado() {
        return clienteSeleccionado;
    }

    public void setClienteSeleccionado(Clientes clienteSeleccionado) {
        this.clienteSeleccionado = clienteSeleccionado;
    }

    public Double getIva() {
        return iva;
    }

    public void setIva(Double iva) {
        this.iva = iva;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public FacturasDAO getFacturasDao() {
        return facturasDao;
    }

    public void setFacturasDao(FacturasDAO facturasDao) {
        this.facturasDao = facturasDao;
    }
    
    
    
}
