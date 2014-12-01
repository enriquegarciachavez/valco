/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ProductoDAO;
import com.valco.dao.ProveedorDAO;
import com.valco.dao.RepartidoresDAO;
import com.valco.dao.UbicacionesDAO;
import com.valco.dao.UsuariosDAO;
import com.valco.pojo.OrdenesCompra;
import com.valco.pojo.ProductosHasProveedores;
import com.valco.pojo.ProductosInventario;
import com.valco.pojo.Proveedores;
import com.valco.pojo.Repartidores;
import com.valco.utility.MsgUtility;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.inject.Named;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

/**
 *
 * @author Karlitha
 */
@ViewScoped
@ManagedBean
public class AsignacionProductoRepartidor {

    @ManagedProperty(value = "#{productoDao}")
    private ProductoDAO productoDao;
    @ManagedProperty(value = "#{repartidoresDao}")
    private RepartidoresDAO repartidoresDao;
    @ManagedProperty(value = "#{ubicacionesDao}")
    private UbicacionesDAO ubicacionesDao;
    @ManagedProperty(value = "#{usuariosDao}")
    private UsuariosDAO usuariosDao;
    private List<ProductosInventario> productosInventario;
    private List<Repartidores> repartidores;
    private Repartidores repartidorSeleccionado;
    private String codigoDeBarras;
    /**
     * Creates a new instance of asignacionProductoRepartidor
     */
    public AsignacionProductoRepartidor() {
    }
    
    @PostConstruct
    public void init(){
        try {
            productosInventario = new ArrayList<ProductosInventario>();
            repartidores = repartidoresDao.getRepartidores();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar los proveedores.");
        }
    }
    
    public void agregarProducto() throws Exception{
        ProductosInventario producto = null;
        try {
            producto = 
                    productoDao.getProductosXCodigoBarras(codigoDeBarras);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar el producto");
        }
        if(producto == null){
            MsgUtility.showWarnMeage("No se encontró el producto buscado");
        }else{
            if(!producto.getEstatus().equals("ACTIVO")){
                MsgUtility.showWarnMeage("El producto buscado no se encuentra en inventario");
            }else{
                productosInventario.add(producto);
            }
        }
        
    }
    
    public void recibirProductos() throws Exception{
        for(ProductosInventario producto : productosInventario){
            producto.setRepartidor(repartidorSeleccionado);
            producto.setEstatus("EN RUTA");
        }
        try{
        productoDao.actualizarProductosInventario(productosInventario);
        productosInventario.clear();
        MsgUtility.showInfoMeage("El producto se asignó correctamente");
        }catch(Exception e){
            MsgUtility.showErrorMeage("Ocurrió un error al recibir los productos.");
        }
    }

    public ProductoDAO getProductoDao() {
        return productoDao;
    }

    public void setProductoDao(ProductoDAO productoDao) {
        this.productoDao = productoDao;
    }

    public List<ProductosInventario> getProductosInventario() {
        return productosInventario;
    }

    public void setProductosInventario(List<ProductosInventario> productosInventario) {
        this.productosInventario = productosInventario;
    }

    public List<Repartidores> getRepartidores() {
        return repartidores;
    }

    public void setRepartidores(List<Repartidores> repartidores) {
        this.repartidores = repartidores;
    }

    

    public String getCodigoDeBarras() {
        return codigoDeBarras;
    }

    public void setCodigoDeBarras(String codigoDeBarras) {
        this.codigoDeBarras = codigoDeBarras;
    }

    public RepartidoresDAO getRepartidoresDao() {
        return repartidoresDao;
    }

    public void setRepartidoresDao(RepartidoresDAO repartidoresDao) {
        this.repartidoresDao = repartidoresDao;
    }

    public Repartidores getRepartidorSeleccionado() {
        return repartidorSeleccionado;
    }

    public void setRepartidorSeleccionado(Repartidores repartidorSeleccionado) {
        this.repartidorSeleccionado = repartidorSeleccionado;
    }

    public UbicacionesDAO getUbicacionesDao() {
        return ubicacionesDao;
    }

    public void setUbicacionesDao(UbicacionesDAO ubicacionesDao) {
        this.ubicacionesDao = ubicacionesDao;
    }

    public UsuariosDAO getUsuariosDao() {
        return usuariosDao;
    }

    public void setUsuariosDao(UsuariosDAO usuariosDao) {
        this.usuariosDao = usuariosDao;
    }
    
    
    
}
