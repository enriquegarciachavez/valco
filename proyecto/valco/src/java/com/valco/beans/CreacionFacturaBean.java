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
import com.valco.pojo.Impuestos;
import com.valco.pojo.NotasDeVenta;
import com.valco.utility.FacturasUtility;
import com.valco.utility.MsgUtility;
import https.test_paxfacturacion_com_mx._453.WcfRecepcionASMX;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
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
    private Set<Impuestos> impuestosDisponibles;
    private Set<Impuestos> impuestosSeleccionados;
    /**
     * Creates a new instance of CreacionFacturaBean
     */
    public CreacionFacturaBean() {
    }
    
    @PostConstruct
    public void inicializar(){
        try{
            impuestosDisponibles = new HashSet();
            Impuestos impuesto = new Impuestos();
            impuesto.setImpuesto("IVA");
            impuesto.setTasa(new BigDecimal(16.00).setScale(2, RoundingMode.HALF_EVEN));
            impuesto.setImporte(new BigDecimal("0.160000").setScale(6, RoundingMode.HALF_EVEN));
            impuestosDisponibles.add(impuesto);
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
            List<Facturas> facturas = new ArrayList<>();
            for(NotasDeVenta nota : notasDeVenta.getTarget()){
                Facturas factura = new Facturas();
                factura.setFecha(new Date());
                factura.setEstatus("ACTIVO");
                factura.setSerie("A");
                factura.setFormaPago(metodoPago);
                factura.setMetodoPago("EFECTIVO");
                factura.setImpuestoses(this.impuestosSeleccionados);
                factura.setObservaciones(observaciones);
                factura.setSubtotal(nota.getTotal());
                factura.setTotal(nota.getTotal());
                factura.setXml(metodoPago);
                factura.setLugar("CHIHUAHUA,CHIHUAHUA,MEXICO");
                factura.setMoneda("MXN");
                factura.setBanco("Santander");
                factura.setCondicionPago("contado");
                factura.setIva(BigDecimal.ZERO);
                factura.setNoSeieCertEmisor("20001000000100005867");
                factura.setFolio(1);
                nota.setFacturas(factura);
                nota.setClientes(clienteSeleccionado);
                factura.setNotasDeVenta(nota);
                factura.setConceptosFacturas(FacturasUtility.convierteProductosAConceptos(nota.getProductosInventarios().iterator()));
                String xml = FacturasUtility.facturar(factura);
                FacturasUtility.agregarDatosDeTimbrado(factura,xml);
                FacturasUtility.guardaXml(nota.getClientes().getRfc()+"-"+facturasDao.getConsecutivo()+".xml", xml, "C:/SAT/");
                facturas.add(factura);
            }
            facturasDao.insertarFacturasYActualizarNotas(notasDeVenta.getTarget());
            for(Facturas factura: facturas){
                FacturasUtility.guardaPdf(factura.getCodigo(),factura.getNotasDeVenta().getClientes().getRfc()+"-"+factura.getCodigo()+".pdf" ,"C:/SAT/");
            }
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

    public Set<Impuestos> getImpuestosDisponibles() {
        return impuestosDisponibles;
    }

    public void setImpuestosDisponibles(Set<Impuestos> impuestosDisponibles) {
        this.impuestosDisponibles = impuestosDisponibles;
    }

    public Set<Impuestos> getImpuestosSeleccionados() {
        return impuestosSeleccionados;
    }

    public void setImpuestosSeleccionados(Set<Impuestos> impuestosSeleccionados) {
        this.impuestosSeleccionados = impuestosSeleccionados;
    }

    
    
    
    
    
}
