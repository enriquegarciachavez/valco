/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ClienteDAO;
import com.valco.dao.NotasVentaDAO;
import com.valco.pojo.Clientes;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.ProductosInventario;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.faces.validator.ValidatorException;

/**
 *
 * @author Karlitha
 */
    @ManagedBean
    @ViewScoped
    public class NotasDeVentaMainBean {
    @ManagedProperty(value="#{notadeVentaDao}")
    private NotasVentaDAO notasDeVentaDao;
    @ManagedProperty(value="#{clienteDao}")
    private ClienteDAO clienteDao;
    private List<NotasDeVenta> notasDeVenta;
    private NotasDeVenta notaSeleccionada;
    private NotasDeVenta notaNueva;
    private List<ProductosInventario> productosDisponibles;
    DataModel modeloNotas;
    
    public NotasDeVentaMainBean() {
        this.productosSeleccionados = new ArrayList<ProductosInventario>();
        this.notaNueva = new NotasDeVenta();
    }
    
    @PostConstruct
    public void init(){
        try {
            this.clientes = clienteDao.getClientes();
            this.productosDisponibles = notasDeVentaDao.getProductosDisponibles();
        } catch (Exception ex) {
            Logger.getLogger(NotasDeVentaMainBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public DataModel getModeloNotas() throws Exception {
        notasDeVenta = notasDeVentaDao.getNotasDeVenta();
        modeloNotas = new ListDataModel(notasDeVenta);
        return modeloNotas;
    }
    
    public void consultaXFolio() throws Exception{
	NotasDeVenta aux = new NotasDeVenta();
        aux = 
                this.notasDeVentaDao.getNotaDeVentaXFolio(notaNueva.getFolio());
        if(aux == null){
            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor")); 
        }else{
            this.notaNueva = aux;
        }
    }
    
    public void validaEstatusActivo(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        NotasDeVenta aux = new NotasDeVenta();
        aux = 
                this.notasDeVentaDao.getNotaDeVentaXFolio((int)value);
        if(aux == null){
            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor")); 
        }else{
            this.notaNueva = aux;
            if(notaNueva == null || notaNueva.getEstatus() == null || !notaNueva.getEstatus().equals("ACTIVO")){
            throw new ValidatorException(new FacesMessage("La nota de venta no no se encuentra activa")); 
        }
        }
    }
    public void ingresarNotaVendida(){
        for(ProductosInventario producto: productosSeleccionados){
            producto.setNotasDeVenta(notaNueva);
            this.notaNueva.getProductosInventarios().add(producto);
        }
        try {
            this.notaNueva.setEstatus("ASIGNADA");
            this.notasDeVentaDao.actualizarNotaDeVenta(notaNueva);
        } catch (Exception ex) {
            FacesContext.getCurrentInstance().addMessage(null,
                    new FacesMessage("Ocurriò un error al guardar la nota de venta"));
        }
    }
    
    public double getTotalSeleccionado(){
        double total = 0.00;
        if(productosSeleccionados == null || productosSeleccionados.isEmpty()){
            return 0.0;
        }else{
            for(ProductosInventario producto : productosSeleccionados){
                total += producto.getPrecio().doubleValue()*producto.getPeso().doubleValue();
            }
            return total;
        }
    }
    
    public List<ProductosInventario> getProductosDisponiblesModificar() {
        for(ProductosInventario producto: notaNueva.getProductosInventariosList()){
            productosDisponibles.add(producto);
        }
        return productosDisponibles;
    }
    
    public List<ProductosInventario> getProductosDisponibles() {
        return productosDisponibles;
    }

    public void setProductosDisponibles(List<ProductosInventario> productosDisponibles) {
        this.productosDisponibles = productosDisponibles;
    }

    public List<ProductosInventario> getProductosSeleccionados() {
        return productosSeleccionados;
    }

    public void setProductosSeleccionados(List<ProductosInventario> productosSeleccionados) {
        this.productosSeleccionados = productosSeleccionados;
    }
    List<Clientes> clientes;
    private List<ProductosInventario> productosSeleccionados;

    

    public ClienteDAO getClienteDao() {
        return clienteDao;
    }

    public void setClienteDao(ClienteDAO clienteDao) {
        this.clienteDao = clienteDao;
    }

    public List<Clientes> getClientes() {
        return clientes;
    }

    public void setClientes(List<Clientes> clientes) {
        this.clientes = clientes;
    }

    public NotasDeVenta getNotaNueva() {
        return notaNueva;
    }

    public void setNotaNueva(NotasDeVenta notaNueva) {
        this.notaNueva = notaNueva;
    }

    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }

    public List<NotasDeVenta> getNotasDeVenta() {
        return notasDeVenta;
    }

    public void setNotasDeVenta(List<NotasDeVenta> notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }

    public NotasDeVenta getNotaSeleccionada() {
        return notaSeleccionada;
    }

    public void setNotaSeleccionada(NotasDeVenta notaSeleccionada) {
        this.notaSeleccionada = notaSeleccionada;
    }

    public void setModeloNotas(DataModel modeloNotas) {
        this.modeloNotas = modeloNotas;
    }
    
    
    


    
}
