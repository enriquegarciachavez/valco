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
public class RecepcionProductoBean {

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
     * Creates a new instance of asignacionProductoRepartidor
     */
    public RecepcionProductoBean() {
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
    
    public void agregarProducto() throws Exception{
        
        ProductosHasProveedores productoHasProveedores = null;
        
        String codigoProducto = 
                codigoDeBarras.substring(proveedorSeleccionado.getPosicionCodigoInicial(), 
                        proveedorSeleccionado.getPosicionCodigoFinal());
        String peso =
                codigoDeBarras.substring(proveedorSeleccionado.getPosicionPesoInicial(),
                        proveedorSeleccionado.getPosicionPesoFinal());
        try {
            productoHasProveedores =
                    productoDao.getProductoXProveYCodigo(proveedorSeleccionado, codigoProducto);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar el producto.");
        }
        
        if(productoHasProveedores == null){
            MsgUtility.showWarnMeage("No se encontro un producto con el código especificado");
        }else{
            ProductosInventario productoNuevo = new ProductosInventario();
            productoNuevo.setPeso(new BigDecimal(peso));
            productoNuevo.setCodigoBarras(codigoDeBarras);
            productoNuevo.setProductosHasProveedores(productoHasProveedores);
            productoNuevo.setPrecio(productoHasProveedores.getPrecioSugerido());
            productoNuevo.setUbicaciones(ubicacionesDao.getUbicaciones().get(0));
            productoNuevo.setEstatus("ACTIVO");
            productosInventario.add(productoNuevo);
        }
    }
    
    public void recibirProductos() throws Exception{
        OrdenesCompra orden = new OrdenesCompra();
        orden.setEstatus("ACTIVO");
        orden.setFecha(new Date());
        orden.setProveedores(proveedorSeleccionado);
        BigDecimal total = BigDecimal.ZERO;
        for(ProductosInventario producto : orden.getProductosInventarios()){
            total = total.add(producto.getPrecio().multiply(producto.getPeso()));
        }
        orden.setTotal(total);
        orden.setUsuarios(usuariosDao.getUsuarios().get(0));
        try{
        productoDao.recibirProductos(productosInventario, orden);
        productosInventario.clear();
        MsgUtility.showInfoMeage("El producto se entró al inventario correctamente");
        }catch(Exception e){
            MsgUtility.showErrorMeage("Ocurrió un error al recibir los productos.");
        }
    }
    
    public void listenerTest(){
        MsgUtility.showErrorMeage("Test fired.");
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
