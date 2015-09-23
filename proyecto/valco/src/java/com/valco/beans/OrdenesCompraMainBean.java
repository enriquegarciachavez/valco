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
import com.valco.pojo.Ubicaciones;
import com.valco.utility.MsgUtility;
import java.math.BigDecimal;
import java.text.DecimalFormat;
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
    ProductosInventario productoSeleccionado;
    private List<ProductosInventario> borrar= new ArrayList<>();
    ProductosInventario productoNuevo = new ProductosInventario();
    

    /**
     * Creates a new instance of OrdenesCompraMainBean
     */
    public OrdenesCompraMainBean() {
        try {
            productoNuevo.setPeso(BigDecimal.ZERO);
            this.ordenesCompra = ordenesCompraDao.getOrdenesCompra();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    @PostConstruct

    private void init() {

    }
    
    public void agregarProductoNuevo(){
        productoNuevo.setPrecio(BigDecimal.ZERO);
        productoNuevo.setOrdenesCompra(ordenSeleccionado);
        Ubicaciones ubicacion= new Ubicaciones();
        ubicacion.setCodigo(1);
        productoNuevo.setUbicaciones(ubicacion);
        productoNuevo.setEstatus("ACTIVO");
        produuctosInventario.add(productoNuevo);
        productoNuevo= new ProductosInventario();
        productoNuevo.setPeso(BigDecimal.ZERO);
        
    }
    
    public void borrarProducto(){
        this.borrar.add(productoSeleccionado);
        this.produuctosInventario.remove(productoSeleccionado);
        
    }

    public void obtenerProductosXOrdenAgrupados() {
        try {
            this.produuctosInventarioAgrupados
                    = this.ordenesCompraDao.getProductosInventarioAgrupadoXOrden(ordenSeleccionado);
            this.produuctosInventario = this.ordenesCompraDao.getProductosInventarioXOrden(ordenSeleccionado);
            this.productosProveedor = this.productoDao.getProductosXProveedor(ordenSeleccionado.getProveedores());
            this.borrar= new ArrayList<>();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            
        }

    }

    public void guardarPrecio() {
        try {
            List<ProductosInventario> productosFinales = new ArrayList<>();
            for (ProductosInventarioAgrupados agrupado : this.produuctosInventarioAgrupadosModificados) {
                for (ProductosInventario producto : agrupado.getProductos()) {

                    producto.setPrecio(agrupado.getPrecio());
                    producto.setProductosHasProveedores(agrupado.getProducto());

                }
                productosFinales.addAll(agrupado.getProductos());
            }
            this.productoDao.actualizarProductosInventario(productosFinales);
            this.ordenSeleccionado.setTotal(getPrecioTotal());
            this.ordenesCompraDao.actualizarOrdenesCompra(ordenSeleccionado);
            produuctosInventarioAgrupados.clear();
            produuctosInventarioAgrupados.addAll(produuctosInventarioAgrupadosModificados);
            produuctosInventarioAgrupadosModificados.clear();
            MsgUtility.showInfoMeage("Se actualizo la orden correctamente");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public String onFlowProcess(FlowEvent event) {
        if (event.getNewStep().equals("modificarPrecio")) {
            List<ProductosInventarioAgrupados> productosAuxiliar = new ArrayList<ProductosInventarioAgrupados>();
            List<ProductosInventarioAgrupados> productosAuxiliar2 = new ArrayList<ProductosInventarioAgrupados>();
            productosAuxiliar.addAll(produuctosInventarioAgrupados);
            productosAuxiliar2.addAll(produuctosInventarioAgrupados);
            produuctosInventarioAgrupadosModificados.clear();
            for (ProductosInventarioAgrupados productoAgrupado : productosAuxiliar) {
                if (productoAgrupado.getProducto().equals(productoAgrupado.getProductoModificado())) {
                    produuctosInventarioAgrupadosModificados.add(productoAgrupado);
                    productosAuxiliar2.remove(productoAgrupado);

                }
            }
            outerloop:
            for (ProductosInventarioAgrupados productoAgrupado : productosAuxiliar2) {
                for (ProductosInventarioAgrupados productoAgrupadoModificado : produuctosInventarioAgrupadosModificados) {
                    if (productoAgrupado.getProductoModificado().equals(productoAgrupadoModificado.getProductoModificado())) {
                        productoAgrupadoModificado.setPeso(productoAgrupadoModificado.getPeso().add(productoAgrupado.getPeso()));
                        productoAgrupadoModificado.getProductos().addAll(productoAgrupado.getProductos());
                        break outerloop;
                    }

                }
                produuctosInventarioAgrupadosModificados.add(productoAgrupado);

            }

        }else if (event.getNewStep().equals("modificarProducto")){
            produuctosInventarioAgrupados =new ArrayList<>();
            productosinventario : 
            for (ProductosInventario producto : produuctosInventario){
                ProductosInventarioAgrupados productoAgrupado = new ProductosInventarioAgrupados();
                productoAgrupado.setPeso(producto.getPeso());
                productoAgrupado.setPrecio(producto.getPrecio());
                productoAgrupado.setPrecioModificado(producto.getPrecio());
                productoAgrupado.setProducto(producto.getProductosHasProveedores());
                productoAgrupado.setProductoModificado(producto.getProductosHasProveedores());
                productoAgrupado.setProductos(new ArrayList<ProductosInventario>());
                
                productoAgrupado.getProductos().add(producto);
                
                if(!produuctosInventarioAgrupados.isEmpty()){
               
                for(ProductosInventarioAgrupados agrupadoCiclo : produuctosInventarioAgrupados){
                    if(agrupadoCiclo.getProducto().equals(productoAgrupado.getProducto())){
                        agrupadoCiclo.setPeso(agrupadoCiclo.getPeso().add(productoAgrupado.getPeso()));
                        agrupadoCiclo.getProductos().add(producto);
                        continue productosinventario ;
                        
                    }
                }
                }
                produuctosInventarioAgrupados.add(productoAgrupado);
                
                
            }
            
        }
        return event.getNewStep();
    }

    public BigDecimal getPesoTotal() {
       BigDecimal total = new BigDecimal("0.00");
       for(ProductosInventarioAgrupados producto : this.produuctosInventarioAgrupadosModificados){
           total= total.add(producto.getPeso());
       }
       return total;
    }
    
    public BigDecimal getPrecioTotal(){
        BigDecimal precio = new BigDecimal("0.00");
         precio= precio.setScale(2, BigDecimal.ROUND_HALF_UP);
       for(ProductosInventarioAgrupados producto : this.produuctosInventarioAgrupadosModificados){
           precio= precio.add(producto.getPeso().multiply(producto.getPrecio()).setScale(2, BigDecimal.ROUND_HALF_UP));
       }
       return precio;
    }
    
    public String getPrecioTotalFormateado(){
        return new DecimalFormat("###,###.##").format(getPrecioTotal().doubleValue());
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

    public ProductosInventario getProductoSeleccionado() {
        return productoSeleccionado;
    }

    public void setProductoSeleccionado(ProductosInventario productoSeleccionado) {
        this.productoSeleccionado = productoSeleccionado;
    }

    public List<ProductosInventario> getBorrar() {
        return borrar;
    }

    public void setBorrar(List<ProductosInventario> borrar) {
        this.borrar = borrar;
    }

    public ProductosInventario getProductoNuevo() {
        return productoNuevo;
    }

    public void setProductoNuevo(ProductosInventario productoNuevo) {
        this.productoNuevo = productoNuevo;
    }
    
    

}
