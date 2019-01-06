/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ProductoDAO;
import com.valco.pojo.InventarioGlobal;
import com.valco.utility.MsgUtility;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import org.primefaces.context.RequestContext;

/**
 *
 * @author Administrador
 */
@ManagedBean
@ViewScoped
public class InventarioMainBean {

    List<InventarioGlobal> inventariosGlobales = new ArrayList<>();
    @ManagedProperty(value = "#{productoDao}")
    private ProductoDAO productoDao;

    /**
     * Creates a new instance of InventarioMainBean
     */
    public InventarioMainBean() {
        
        
    }
    
    @PostConstruct
    public void init(){
        try {
            this.inventariosGlobales = productoDao.getInventarioGlobal();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void imprimirInventarioGlobal(){
        String url = "/valco/ReportesPdf?reporte="+
                        "//pagina//reportes//planta//InventarioGlobal.jrxml";
                    RequestContext.getCurrentInstance().execute("window.open('"+url+"');");
    }
    
    public void imprimirInventarioDetallado(){
        String url = "/valco/ReportesPdf?reporte="+
                        "//pagina//reportes//planta//InventarioGlobalDetallado.jrxml";
                    RequestContext.getCurrentInstance().execute("window.open('"+url+"');");
    }

    public List<InventarioGlobal> getInventariosGlobales() {
        return inventariosGlobales;
    }

    public void setInventariosGlobales(List<InventarioGlobal> inventariosGlobales) {
        this.inventariosGlobales = inventariosGlobales;
    }

    public ProductoDAO getProductoDao() {
        return productoDao;
    }

    public void setProductoDao(ProductoDAO productoDao) {
        this.productoDao = productoDao;
    }
    
    

}
