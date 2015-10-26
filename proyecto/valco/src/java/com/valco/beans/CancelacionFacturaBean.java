/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.FacturasDAO;
import com.valco.pojo.Devoluciones;
import com.valco.pojo.Facturas;
import com.valco.pojo.NotasCredito;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.ProductosInventario;
import com.valco.utility.MsgUtility;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

/**
 *
 * @author Administrador
 */
@ManagedBean
@ViewScoped
public class CancelacionFacturaBean {
public Integer noFactura;
public Integer noNota;
public List<Facturas> facturasDisponibles;
public Facturas facturaSeleccionada;
@ManagedProperty(value="#{facturasDao}")
private FacturasDAO facturasDao;

private List<NotasDeVenta> notasDeVenta;
private NotasDeVenta notaSeleccionada;
private NotasCredito notaNueva = new NotasCredito();
private ProductosInventario productoSeleccionado;



    /**
     * Creates a new instance of CancelacionFacturaBean
     */
    public CancelacionFacturaBean() {
    }
    
    public void consultarNotasDeVentaXFactura(){
    try {
        this.notasDeVenta = this.facturasDao.getNotasXFactura(facturaSeleccionada);
        System.out.println("HOA");
    } catch (Exception ex) {
        MsgUtility.showErrorMeage(ex.getMessage());
    }
        
            
    }
    
    public void buscar() {
        try {
            this.facturasDisponibles = this.facturasDao.getFacturas(noFactura, noNota);

        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void cancelar() {
        this.facturaSeleccionada.setEstatus("CANCELADA");
        MsgUtility.showInfoMeage("La factura se canceló correctamente.");
        try {
            this.facturasDao.actualizarFactura(facturaSeleccionada);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void crearNota(){
        List<ProductosInventario> productos = new ArrayList<>();
        List<Devoluciones> devoluciones = new ArrayList<>();
        notaNueva.setFecha(new Date());
        notaNueva.setFactura(facturaSeleccionada);
        for(NotasDeVenta nota: this.notasDeVenta){
            for(ProductosInventario producto: nota.getProductosInventarios()){
                if (producto.getDevuelto()){
                    if (producto.getMalEstado()){
                        producto.setEstatus("MALESTADO");
                        productos.add(producto);
                    }else{
                        if(producto.getDevolucionTotal()){
                            producto.setEstatus("ACTIVO");
                            Devoluciones devolucion= new Devoluciones();
                            devolucion.setDevolucionTotal(Boolean.TRUE);
                            devolucion.setPeso(producto.getPeso());
                            devolucion.setProductosInventario(producto);
                            devolucion.setNotasCredito(notaNueva);
                            devoluciones.add(devolucion);
                            productos.add(producto);
                            
                        }else {
                            Devoluciones devolucion= new Devoluciones();
                            devolucion.setDevolucionTotal(Boolean.FALSE);
                            devolucion.setPeso(producto.getCantidadDevuelta());
                            devolucion.setProductosInventario(producto);
                            devolucion.setNotasCredito(notaNueva);
                            devoluciones.add(devolucion);
                        }
                    }
                }
            }
        }
    try {
        this.facturasDao.crearNotadeCredito(notaNueva, productos, devoluciones);
    } catch (Exception ex) {
        MsgUtility.showErrorMeage(ex.getMessage());
    }
    }

    public Integer getNoFactura() {
        return noFactura;
    }

    public void setNoFactura(Integer noFactura) {
        this.noFactura = noFactura;
    }

    public Integer getNoNota() {
        return noNota;
    }

    public void setNoNota(Integer noNota) {
        this.noNota = noNota;
    }

    public List<Facturas> getFacturasDisponibles() {
        return facturasDisponibles;
    }

    public void setFacturasDisponibles(List<Facturas> facturasDisponibles) {
        this.facturasDisponibles = facturasDisponibles;
    }

    public Facturas getFacturaSeleccionada() {
        return facturaSeleccionada;
    }

    public void setFacturaSeleccionada(Facturas facturaSeleccionada) {
        this.facturaSeleccionada = facturaSeleccionada;
    }

    public FacturasDAO getFacturasDao() {
        return facturasDao;
    }

    public void setFacturasDao(FacturasDAO facturasDao) {
        this.facturasDao = facturasDao;
    }

    public List<NotasDeVenta> getNotasDeVenta() {
        return notasDeVenta;
    }

    public void setNotasDeVenta(List<NotasDeVenta> notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }

    public NotasCredito getNotaNueva() {
        return notaNueva;
    }

    public void setNotaNueva(NotasCredito notaNueva) {
        this.notaNueva = notaNueva;
    }

    public ProductosInventario getProductoSeleccionado() {
        return productoSeleccionado;
    }

    public void setProductoSeleccionado(ProductosInventario productoSeleccionado) {
        this.productoSeleccionado = productoSeleccionado;
    }

    public NotasDeVenta getNotaSeleccionada() {
        return notaSeleccionada;
    }

    public void setNotaSeleccionada(NotasDeVenta notaSeleccionada) {
        this.notaSeleccionada = notaSeleccionada;
    }
    
    
    
}
