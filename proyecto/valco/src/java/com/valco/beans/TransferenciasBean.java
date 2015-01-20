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
import com.valco.pojo.OrdenesCompra;
import com.valco.pojo.ProductosHasProveedores;
import com.valco.pojo.ProductosInventario;
import com.valco.pojo.Proveedores;
import com.valco.pojo.Tranferencias;
import com.valco.pojo.Ubicaciones;
import com.valco.pojo.Usuarios;
import com.valco.utility.MsgUtility;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.bean.ViewScoped;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class TransferenciasBean {

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
     * Creates a new instance of TransferenciasBean
     */
    public TransferenciasBean() {
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
    
    public void transferirProductos() throws Exception{
        if(productosInventario == null || productosInventario.isEmpty()){
            MsgUtility.showInfoMeage("Debe seleccionar almenos un producto para transferir");
            return;
        }
        Tranferencias transferencia = new Tranferencias();
        transferencia.setEstatus("EN PROCESO");
        transferencia.setFechaEnvio(new Date());
        transferencia.setUbicacionesByDestino(ubicacionSeleccionado);
        transferencia.setUbicacionesBySalida(productosInventario.get(0).getUbicaciones());
        Usuarios usuario = new Usuarios();
        usuario.setCodigo(1);
        transferencia.setUsuario(usuario);
        if(Objects.equals(transferencia.getUbicacionesBySalida().getCodigo(), transferencia.getUbicacionesByDestino().getCodigo())){
            MsgUtility.showInfoMeage("Debe seleccionar una ubicación de destino diferente a la ubicación de salida.");
            return;
        }
        for(ProductosInventario producto : productosInventario){
            producto.setEstatus("EN TRANSFERENCIA");
            producto.setTranferencias(transferencia);
        }
        try{
        transferenciasDao.Transferir(transferencia, productosInventario);
        productosInventario.clear();
        MsgUtility.showInfoMeage("El producto se envió correctamente");
        }catch(Exception e){
            MsgUtility.showErrorMeage("Ocurrió un error al transferir los productos.");
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

    public TransferenciasDAO getTransferenciasDao() {
        return transferenciasDao;
    }

    public void setTransferenciasDao(TransferenciasDAO transferenciasDao) {
        this.transferenciasDao = transferenciasDao;
    }

}
