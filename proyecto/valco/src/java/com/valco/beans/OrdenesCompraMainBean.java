/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.OrdenesCompraDAO;
import com.valco.dao.ProductoDAO;
import com.valco.pojo.OrdenesCompra;
import com.valco.pojo.ProductosHasProveedores;
import com.valco.pojo.ProductosInventario;
import com.valco.pojo.ProductosInventarioAgrupados;
import com.valco.utility.MsgUtility;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import org.primefaces.event.FlowEvent;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class OrdenesCompraMainBean {

    private List<OrdenesCompra> ordenesCompra;
    private List<ProductosInventario> produuctosInventario;
    private List<ProductosInventarioAgrupados> produuctosInventarioAgrupados;
    @ManagedProperty(value = "#{ordenesCompraDao}")
    private OrdenesCompraDAO ordenesCompraDao = new OrdenesCompraDAO();
    private ProductoDAO productoDao = new ProductoDAO();
    OrdenesCompra ordenSeleccionado;
    OrdenesCompra ordenNuevo;
    private ProductosInventarioAgrupados productoSeleccionadoAgrupado;
    private List<ProductosHasProveedores> productosProveedor;
    private List<ProductosInventarioAgrupados> produuctosInventarioAgrupadosModificados = new ArrayList<>();
    

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
            this.productosProveedor=this.productoDao.getProductosXProveedor(ordenSeleccionado.getProveedores());
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void guardarPrecio(){
        try {
            List<ProductosInventario> productosFinales = new ArrayList<>();
            for(ProductosInventarioAgrupados agrupado : this.produuctosInventarioAgrupadosModificados){
                for(ProductosInventario producto : agrupado.getProductos()){
                    
                        producto.setPrecio(agrupado.getPrecio()); 
                        producto.setProductosHasProveedores(agrupado.getProducto());
                    
                }
                productosFinales.addAll(agrupado.getProductos());
            }
            this.productoDao.actualizarProductosInventario(productosFinales);
            produuctosInventarioAgrupados.clear();
            produuctosInventarioAgrupados.addAll(produuctosInventarioAgrupadosModificados);
            produuctosInventarioAgrupadosModificados.clear();
            MsgUtility.showInfoMeage("Se actualizo la orden correctamente");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public String onFlowProcess(FlowEvent event) {
      if(event.getNewStep().equals("modificarPrecio")){
          List<ProductosInventarioAgrupados> productosAuxiliar = new ArrayList<ProductosInventarioAgrupados>();
          List<ProductosInventarioAgrupados> productosAuxiliar2 = new ArrayList<ProductosInventarioAgrupados>();
          productosAuxiliar.addAll(produuctosInventarioAgrupados);
          productosAuxiliar2.addAll(produuctosInventarioAgrupados);
          for(ProductosInventarioAgrupados productoAgrupado: productosAuxiliar){
              if (productoAgrupado.getProducto().equals(productoAgrupado.getProductoModificado())){
                  produuctosInventarioAgrupadosModificados.add(productoAgrupado);
                  productosAuxiliar2.remove(productoAgrupado);
                  
              }
          }
          outerloop:
          for(ProductosInventarioAgrupados productoAgrupado: productosAuxiliar2){
              for(ProductosInventarioAgrupados productoAgrupadoModificado: produuctosInventarioAgrupadosModificados){
                  if(productoAgrupado.getProductoModificado().equals(productoAgrupadoModificado.getProductoModificado())){
                      productoAgrupadoModificado.setPeso(productoAgrupadoModificado.getPeso().add(productoAgrupado.getPeso()));
                      productoAgrupadoModificado.getProductos().addAll(productoAgrupado.getProductos());
                      break outerloop;
                  }
                  
              }
              produuctosInventarioAgrupadosModificados.add(productoAgrupado);
              
          }
          
          
      }
      return event.getNewStep();
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

    public List<ProductosInventarioAgrupados> getProduuctosInventarioAgrupados() {
        return produuctosInventarioAgrupados;
    }

    public void setProduuctosInventarioAgrupados(List<ProductosInventarioAgrupados> produuctosInventarioAgrupados) {
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

    public ProductosInventarioAgrupados getProductoSeleccionadoAgrupado() {
        return productoSeleccionadoAgrupado;
    }

    public void setProductoSeleccionadoAgrupado(ProductosInventarioAgrupados productoSeleccionadoAgrupado) {
        this.productoSeleccionadoAgrupado = productoSeleccionadoAgrupado;
    }

    public List<ProductosHasProveedores> getProductosProveedor() {
        return productosProveedor;
    }

    public void setProductosProveedor(List<ProductosHasProveedores> productosProveedor) {
        this.productosProveedor = productosProveedor;
    }

    public List<ProductosInventarioAgrupados> getProduuctosInventarioAgrupadosModificados() {
        return produuctosInventarioAgrupadosModificados;
    }

    public void setProduuctosInventarioAgrupadosModificados(List<ProductosInventarioAgrupados> produuctosInventarioAgrupadosModificados) {
        this.produuctosInventarioAgrupadosModificados = produuctosInventarioAgrupadosModificados;
    }
    
    

}
