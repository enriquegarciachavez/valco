/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ProductoDAO;
import com.valco.dao.ProveedorDAO;
import com.valco.dao.TransferenciasDAO;
import com.valco.dao.UbicacionesDAO;
import com.valco.dao.UsuariosDAO;
import com.valco.pojo.ProductosInventario;
import com.valco.pojo.Tranferencias;
import com.valco.pojo.Ubicaciones;
import com.valco.pojo.Usuarios;
import com.valco.utility.MsgUtility;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;
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
public class RecepcionTransferenciasBean {

    @ManagedProperty(value = "#{productoDao}")
    private ProductoDAO productoDao;
    @ManagedProperty(value = "#{proveedorDAO}")
    private ProveedorDAO proveedorDAO;
    @ManagedProperty(value = "#{ubicacionesDao}")
    private UbicacionesDAO ubicacionesDao;
    @ManagedProperty(value = "#{usuariosDao}")
    private UsuariosDAO usuariosDao;
    @ManagedProperty(value = "#{transferenciasDAO}")
    private TransferenciasDAO transferenciasDao;
    private List<ProductosInventario> productosInventario;
    private List<Ubicaciones> ubicaciones;
    private Ubicaciones ubicacionSeleccionado;
    private String codigoDeBarras;
    /**
     * Creates a new instance of RecepcionTransferenciasBean
     */
    public RecepcionTransferenciasBean() {
    }
    
    @PostConstruct
    public void init(){
        try {
            productosInventario = new ArrayList<ProductosInventario>();
            ubicaciones = ubicacionesDao.getUbicaciones();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar los proveedores.");
        }
    }
    
    public void agregarProducto() throws Exception{
        ProductosInventario producto = null;
        try {
            producto = 
                    productoDao.getProductosXCodigoBarrastransferencia(codigoDeBarras);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar el producto");
        }
        if(producto == null){
            MsgUtility.showWarnMeage("No se encontró el producto buscado");
        }else{
            if(!producto.getEstatus().equals("EN TRANSFERENCIA")){
                MsgUtility.showWarnMeage("El producto buscado no se encuentra en transferencia");
            }else{
                productosInventario.add(producto);
            }
        }
        
    }
    
    public void recibirProductoTransferido() throws Exception{
        if(productosInventario == null || productosInventario.isEmpty()){
            MsgUtility.showInfoMeage("Debe seleccionar almenos un producto para transferir");
            return;
        }
        Set<Tranferencias> transferencias = new HashSet();
        for(ProductosInventario producto : productosInventario){
            producto.setEstatus("ACTIVO");
            producto.setUbicaciones(producto.getTranferencias().getUbicacionesByDestino());
            transferencias.add(producto.getTranferencias());
        }
        try{
        transferenciasDao.recibirProductoTransferido(productosInventario);
        productosInventario.clear();
        MsgUtility.showInfoMeage("El producto se recibio correctamente");
        }catch(Exception e){
            MsgUtility.showErrorMeage("Ocurrió un error al transferir los productos.");
            return;
        }
        try{
            transferenciasDao.actualizarTransferencias(transferencias);
        }catch(Exception e){
            MsgUtility.showErrorMeage("Ocurrió un error al actualizar los datos de la transferencia.");
            return;
        }
    }

    public ProductoDAO getProductoDao() {
        return productoDao;
    }

    public void setProductoDao(ProductoDAO productoDao) {
        this.productoDao = productoDao;
    }

    public ProveedorDAO getProveedorDAO() {
        return proveedorDAO;
    }

    public void setProveedorDAO(ProveedorDAO proveedorDAO) {
        this.proveedorDAO = proveedorDAO;
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

    public TransferenciasDAO getTransferenciasDao() {
        return transferenciasDao;
    }

    public void setTransferenciasDao(TransferenciasDAO transferenciasDao) {
        this.transferenciasDao = transferenciasDao;
    }

    public List<ProductosInventario> getProductosInventario() {
        return productosInventario;
    }

    public void setProductosInventario(List<ProductosInventario> productosInventario) {
        this.productosInventario = productosInventario;
    }

    public List<Ubicaciones> getUbicaciones() {
        return ubicaciones;
    }

    public void setUbicaciones(List<Ubicaciones> ubicaciones) {
        this.ubicaciones = ubicaciones;
    }

    public Ubicaciones getUbicacionSeleccionado() {
        return ubicacionSeleccionado;
    }

    public void setUbicacionSeleccionado(Ubicaciones ubicacionSeleccionado) {
        this.ubicacionSeleccionado = ubicacionSeleccionado;
    }

    public String getCodigoDeBarras() {
        return codigoDeBarras;
    }

    public void setCodigoDeBarras(String codigoDeBarras) {
        this.codigoDeBarras = codigoDeBarras;
    }
    
    
}
