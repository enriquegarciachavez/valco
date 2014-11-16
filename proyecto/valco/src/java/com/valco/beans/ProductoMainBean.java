/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ProductoDAO;
import com.valco.dao.TipoProductoDAO;
import com.valco.dao.UnidadesDeMedidaDAO;
import com.valco.pojo.Productos;
import com.valco.pojo.TipoProducto;
import com.valco.pojo.UnidadesDeMedida;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIInput;
import javax.faces.component.UISelectBoolean;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class ProductoMainBean {
    
    @ManagedProperty(value = "#{productoDao}")
            private ProductoDAO productoDao;
    @ManagedProperty(value = "#{unidadesdemedidaDao}")
            private UnidadesDeMedidaDAO unidadesdemedidaDao;
    @ManagedProperty(value = "#{tipoproductoDao}")
            private TipoProductoDAO tipoproductoDao;
    List<Productos> productos;
    List<TipoProducto> tipoProducto;
    List<UnidadesDeMedida> unidadesDeMedida;
    Productos productoNuevo;
    Productos productoSeleccionado;
    DataModel modeloProducto;
    UIInput descripcion;
    UISelectBoolean incluyeViscera;
    UISelectBoolean generarSubproducto;
    UISelectBoolean aplicaInventarioFisico;
    
    
    /**
     * Creates a new instance of ProductoMainBean
     */
    public ProductoMainBean() {
    }

    public UnidadesDeMedidaDAO getUnidadesdemedidaDao() {
        return unidadesdemedidaDao;
    }

    public void setUnidadesdemedidaDao(UnidadesDeMedidaDAO unidadesdemedidaDao) {
        this.unidadesdemedidaDao = unidadesdemedidaDao;
    }

    public TipoProductoDAO getTipoproductoDao() {
        return tipoproductoDao;
    }

    public void setTipoproductoDao(TipoProductoDAO tipoproductoDao) {
        this.tipoproductoDao = tipoproductoDao;
    }
    
    

    public ProductoDAO getProductoDao() {
        return productoDao;
    }

    public void setProductoDao(ProductoDAO productoDao) {
        this.productoDao = productoDao;
    }

    public List<Productos> getProductos() {
        return productos;
    }

    public void setProductos(List<Productos> productos) {
        this.productos = productos;
    }

    public List<TipoProducto> getTipoProducto() {
        return tipoProducto;
    }

    public void setTipoProducto(List<TipoProducto> tipoProducto) {
        this.tipoProducto = tipoProducto;
    }

    public List<UnidadesDeMedida> getUnidadesDeMedida() {
        return unidadesDeMedida;
    }

    public void setUnidadesDeMedida(List<UnidadesDeMedida> unidadesDeMedida) {
        this.unidadesDeMedida = unidadesDeMedida;
    }

    public Productos getProductoNuevo() {
        return productoNuevo;
    }

    public void setProductoNuevo(Productos productoNuevo) {
        this.productoNuevo = productoNuevo;
    }

    public Productos getProductoSeleccionado() {
        return productoSeleccionado;
    }

    public void setProductoSeleccionado(Productos productoSeleccionado) {
        this.productoSeleccionado = productoSeleccionado;
    }

    public DataModel getModeloProducto() throws Exception {
       productos = productoDao.getProductos();
        modeloProducto = new ListDataModel(productos);
        return modeloProducto;
    }

    public void setModeloProducto(DataModel modeloProducto) {
        this.modeloProducto = modeloProducto;
    }

    public UIInput getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(UIInput descripcion) {
        this.descripcion = descripcion;
    }

    public UISelectBoolean getIncluyeViscera() {
        return incluyeViscera;
    }

    public void setIncluyeViscera(UISelectBoolean incluyeViscera) {
        this.incluyeViscera = incluyeViscera;
    }

    public UISelectBoolean getGenerarSubproducto() {
        return generarSubproducto;
    }

    public void setGenerarSubproducto(UISelectBoolean generarSubproducto) {
        this.generarSubproducto = generarSubproducto;
    }

    public UISelectBoolean getAplicaInventarioFisico() {
        return aplicaInventarioFisico;
    }

    public void setAplicaInventarioFisico(UISelectBoolean aplicaInventarioFisico) {
        this.aplicaInventarioFisico = aplicaInventarioFisico;
    }
    
    public void actualizarProducto() {
        try {
            productoDao.actualizarProducto(productoSeleccionado);
        } catch (Exception ex) {
            
        }

    }

    public void insertarProducto() {
        try {
            productoNuevo.setEstatus("ACTIVO");
            productoDao.insertarProducto(productoNuevo);
        } catch (Exception ex) {
            
        }
    }

    public void borrarProducto() {
        try {
            productoDao.borrarProducto(productoSeleccionado);
        } catch (Exception ex) {
            
        }
    }
    
    public void limpiarIngresarForm() {
        descripcion.setValue(null);
        incluyeViscera.setValue(false);
        generarSubproducto.setValue(false);
        aplicaInventarioFisico.setValue(false);
    }
    
    
    public void inicializarProducto() {
        this.productoNuevo = new Productos();
        limpiarIngresarForm();}
    
    @PostConstruct
    public void init(){
        try {
            this.unidadesDeMedida = unidadesdemedidaDao.getUnidadesDeMedida();
            this.tipoProducto = tipoproductoDao.getTipoProducto();
        } catch (Exception ex) {
            
        }
    }
    
}
