/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ProductoDAO;
import com.valco.dao.ProveedorDAO;
import com.valco.dao.UbicacionesDAO;
import com.valco.dao.UsuariosDAO;
import com.valco.pojo.OrdenesCompra;
import com.valco.pojo.ProductosHasProveedores;
import com.valco.pojo.ProductosInventario;
import com.valco.pojo.Proveedores;
import com.valco.utility.MsgUtility;
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

/**
 *
 * @author Karlitha
 */
@ManagedBean
@ViewScoped
public class ProductoNoVendido {

    @ManagedProperty(value = "#{productoDao}")
    private ProductoDAO productoDao;
    @ManagedProperty(value = "#{proveedorDAO}")
    private ProveedorDAO proveedorDAO;
    @ManagedProperty(value = "#{ubicacionesDao}")
    private UbicacionesDAO ubicacionesDao;
    @ManagedProperty(value = "#{usuariosDao}")
    private UsuariosDAO usuariosDao;
    private List<ProductosInventario> productosInventario;
    private List<Proveedores> proveedores;
    private Proveedores proveedorSeleccionado;
    private String codigoDeBarras;
    /**
     * Creates a new instance of productoNoVendido
     */
    public ProductoNoVendido() {
    }
    
    @PostConstruct
    public void init(){
        try {
            productosInventario = new ArrayList<ProductosInventario>();
            proveedores = proveedorDAO.getProveedores();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar los proveedores.");
        }
    }
    
    public void agregarProducto(){
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
            if(!producto.getEstatus().equals("EN RUTA")){
                MsgUtility.showWarnMeage("El producto buscado no se encuentra en ruta");
            }else{
                productosInventario.add(producto);
            }
        }
        
    }
    
    public void recibirProductos() throws Exception{
        if(productosInventario == null || productosInventario.isEmpty()){
            MsgUtility.showWarnMeage("Debe ingresar productos no vendidos.");
        }else{
            for(ProductosInventario producto : productosInventario){
                producto.setEstatus("ACTIVO");
            }
        }
        try{
        productoDao.actualizarProductosInventario(productosInventario);
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

    public List<Proveedores> getProveedores() {
        return proveedores;
    }

    public void setProveedores(List<Proveedores> proveedores) {
        this.proveedores = proveedores;
    }

    public String getCodigoDeBarras() {
        return codigoDeBarras;
    }

    public void setCodigoDeBarras(String codigoDeBarras) {
        this.codigoDeBarras = codigoDeBarras;
    }

    public ProveedorDAO getProveedorDAO() {
        return proveedorDAO;
    }

    public void setProveedorDAO(ProveedorDAO proveedorDAO) {
        this.proveedorDAO = proveedorDAO;
    }

    public Proveedores getProveedorSeleccionado() {
        return proveedorSeleccionado;
    }

    public void setProveedorSeleccionado(Proveedores proveedorSeleccionado) {
        this.proveedorSeleccionado = proveedorSeleccionado;
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
