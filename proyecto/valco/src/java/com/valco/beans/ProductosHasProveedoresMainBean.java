/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ProductoDAO;
import com.valco.dao.ProductosHasProveedoresDAO;
import com.valco.dao.ProveedorDAO;
import com.valco.pojo.Productos;
import com.valco.pojo.ProductosHasProveedores;
import com.valco.pojo.Proveedores;
import com.valco.utility.MsgUtility;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class ProductosHasProveedoresMainBean {

    @ManagedProperty(value = "#{productosHasProveedoresDAO}")
    private ProductosHasProveedoresDAO productosHasProveedoresDAO;
    @ManagedProperty(value = "#{productoDao}")
    private ProductoDAO productoDao;
    @ManagedProperty(value = "#{proveedorDAO}")
    private ProveedorDAO proveedorDAO;
    List<Productos> productos = new ArrayList<>();
    List<Proveedores> proveedores = new ArrayList<>();
    List<ProductosHasProveedores> productosHasProveedores = new ArrayList<>();
    List<ProductosHasProveedores> productosHasProveedoresFiltrados;
    ProductosHasProveedores productosHasProveedoresSeleccionado = null;
    ProductosHasProveedores productosHasProveedoresNuevo = new ProductosHasProveedores();

    /**
     * Creates a new instance of ProductosHasProveedoresMainBean
     */
    public ProductosHasProveedoresMainBean() {
    }

    @PostConstruct
    private void init() {
        try {
            productosHasProveedores = productosHasProveedoresDAO.getProductosHasProveedores();
            productos = productoDao.getProductos();
            proveedores = proveedorDAO.getProveedores();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar las familias");
        }
    }

    public void actualizarProductosHasProveedores() {
        try {
            if (productosHasProveedoresSeleccionado == null) {
                throw new Exception("Debe seleccionar un productos has proveedor para modificar");
            }
            productosHasProveedoresDAO.actualizarProductosHasProveedores(productosHasProveedoresSeleccionado);
            productosHasProveedoresSeleccionado = null;
            MsgUtility.showInfoMeage("El producto has proveedor se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void validarProductosHasProveedoresSeleccionado(ActionEvent actionEvent) {

        if (productosHasProveedoresSeleccionado == null) {
            MsgUtility.showErrorMeage("Debe seleccionar un producto has proveedor");
            FacesContext.getCurrentInstance().validationFailed();

        }

    }

    public void insertarProductosHasProveedores() {
        try {
            productosHasProveedoresDAO.insertarProductosHasProveedores(productosHasProveedoresNuevo);
            this.productosHasProveedores.add(productosHasProveedoresNuevo);
            productosHasProveedoresNuevo = new ProductosHasProveedores();
            MsgUtility.showInfoMeage("El producto has proveedor se ingresó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void borrarProductosHasProveedores() {
        try {
            productosHasProveedoresDAO.borrarProductosHasProveedores(productosHasProveedoresSeleccionado);
            this.productosHasProveedores.remove(productosHasProveedoresSeleccionado);
            MsgUtility.showInfoMeage("El producto has proveedor se borro con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
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

    public List<Productos> getProductos() {
        return productos;
    }

    public void setProductos(List<Productos> productos) {
        this.productos = productos;
    }

    public List<Proveedores> getProveedores() {
        return proveedores;
    }

    public void setProveedores(List<Proveedores> proveedores) {
        this.proveedores = proveedores;
    }
    
    
    public ProductosHasProveedoresDAO getProductosHasProveedoresDAO() {
        return productosHasProveedoresDAO;
    }

    public void setProductosHasProveedoresDAO(ProductosHasProveedoresDAO productosHasProveedoresDAO) {
        this.productosHasProveedoresDAO = productosHasProveedoresDAO;
    }

    public List<ProductosHasProveedores> getProductosHasProveedores() {
        return productosHasProveedores;
    }

    public void setProductosHasProveedores(List<ProductosHasProveedores> productosHasProveedores) {
        this.productosHasProveedores = productosHasProveedores;
    }

    public List<ProductosHasProveedores> getProductosHasProveedoresFiltrados() {
        return productosHasProveedoresFiltrados;
    }

    public void setProductosHasProveedoresFiltrados(List<ProductosHasProveedores> productosHasProveedoresFiltrados) {
        this.productosHasProveedoresFiltrados = productosHasProveedoresFiltrados;
    }

    public ProductosHasProveedores getProductosHasProveedoresSeleccionado() {
        return productosHasProveedoresSeleccionado;
    }

    public void setProductosHasProveedoresSeleccionado(ProductosHasProveedores productosHasProveedoresSeleccionado) {
        this.productosHasProveedoresSeleccionado = productosHasProveedoresSeleccionado;
    }

    public ProductosHasProveedores getProductosHasProveedoresNuevo() {
        return productosHasProveedoresNuevo;
    }

    public void setProductosHasProveedoresNuevo(ProductosHasProveedores productosHasProveedoresNuevo) {
        this.productosHasProveedoresNuevo = productosHasProveedoresNuevo;
    }

}
