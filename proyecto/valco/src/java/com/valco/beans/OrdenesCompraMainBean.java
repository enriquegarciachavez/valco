/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.OrdenesCompraDAO;
import com.valco.dao.ProductoDAO;
import com.valco.pojo.OrdenesCompra;
import com.valco.pojo.ProductosInventario;
import com.valco.utility.MsgUtility;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class OrdenesCompraMainBean {

    private List<OrdenesCompra> ordenesCompra;
    private List<ProductosInventario> produuctosInventario;
    private List<ProductosInventario> produuctosInventarioAgrupados;
    @ManagedProperty(value = "#{ordenesCompraDao}")
    private OrdenesCompraDAO ordenesCompraDao = new OrdenesCompraDAO();
    private ProductoDAO productoDao = new ProductoDAO();
    OrdenesCompra ordenSeleccionado;
    OrdenesCompra ordenNuevo;
    private ProductosInventario productoSeleccionadoAgrupado;

    /**
     * Creates a new instance of OrdenesCompraMainBean
     */
    public OrdenesCompraMainBean() {
        try {
            this.ordenesCompra = ordenesCompraDao.getOrdenesCompra();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    @PostConstruct

    private void init() {

    }

    public void obtenerProductosXOrdenAgrupados() {
        try {
            this.produuctosInventarioAgrupados
                    = this.ordenesCompraDao.getProductosInventarioAgrupadoXOrden(ordenSeleccionado);
            this.produuctosInventario=this.ordenesCompraDao.getProductosInventarioXOrden(ordenSeleccionado);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void guardarPrecio(){
        try {
            for(ProductosInventario agrupado : this.produuctosInventarioAgrupados){
                for(ProductosInventario producto : this.produuctosInventario){
                    if(producto.getProductosHasProveedores().equals(agrupado.getProductosHasProveedores())){
                        producto.setPrecio(agrupado.getPrecio()); 
                    }
                }
            }
            this.productoDao.actualizarProductosInventario(produuctosInventario);
            MsgUtility.showInfoMeage("Se actualizo la orden correctamente");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    public List<OrdenesCompra> getOrdenesCompra() {
        return ordenesCompra;
    }

    public void setOrdenesCompra(List<OrdenesCompra> ordenesCompra) {
        this.ordenesCompra = ordenesCompra;
    }

    public List<ProductosInventario> getProduuctosInventario() {
        return produuctosInventario;
    }

    public void setProduuctosInventario(List<ProductosInventario> produuctosInventario) {
        this.produuctosInventario = produuctosInventario;
    }

    public List<ProductosInventario> getProduuctosInventarioAgrupados() {
        return produuctosInventarioAgrupados;
    }

    public void setProduuctosInventarioAgrupados(List<ProductosInventario> produuctosInventarioAgrupados) {
        this.produuctosInventarioAgrupados = produuctosInventarioAgrupados;
    }

    public OrdenesCompraDAO getOrdenesCompraDao() {
        return ordenesCompraDao;
    }

    public void setOrdenesCompraDao(OrdenesCompraDAO ordenesCompraDao) {
        this.ordenesCompraDao = ordenesCompraDao;
    }

    public ProductoDAO getProductoDao() {
        return productoDao;
    }

    public void setProductoDao(ProductoDAO productoDao) {
        this.productoDao = productoDao;
    }

    public OrdenesCompra getOrdenSeleccionado() {
        return ordenSeleccionado;
    }

    public void setOrdenSeleccionado(OrdenesCompra ordenSeleccionado) {
        this.ordenSeleccionado = ordenSeleccionado;
    }

    public OrdenesCompra getOrdenNuevo() {
        return ordenNuevo;
    }

    public void setOrdenNuevo(OrdenesCompra ordenNuevo) {
        this.ordenNuevo = ordenNuevo;
    }

    public ProductosInventario getProductoSeleccionadoAgrupado() {
        return productoSeleccionadoAgrupado;
    }

    public void setProductoSeleccionadoAgrupado(ProductosInventario productoSeleccionadoAgrupado) {
        this.productoSeleccionadoAgrupado = productoSeleccionadoAgrupado;
    }

}
