/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.AbonosCuentasXPagarDAO;
import com.valco.dao.OrdenesCompraDAO;
import com.valco.dao.ProveedorDAO;
import com.valco.pojo.AbonosCuentasXPagar;
import com.valco.pojo.CuentasXPagar;
import com.valco.pojo.OrdenesCompra;
import com.valco.pojo.OrdenesCompraView;
import com.valco.pojo.Proveedores;
import com.valco.utility.MsgUtility;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIInput;
import javax.faces.context.FacesContext;
import org.primefaces.context.RequestContext;
import org.primefaces.event.SelectEvent;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class AbonosCuentasXPagarMainBean {
    private Date date;
    @ManagedProperty(value = "#{abonoscuentaspagarDAO}")
        private AbonosCuentasXPagarDAO abonoscuentaspagarDAO;
    
    @ManagedProperty(value = "#{proveedorDAO}")
            private ProveedorDAO proveedorDAO;
    
    @ManagedProperty(value = "#{ordenescompraDAO}")
            private OrdenesCompraDAO ordenescompraDAO;
    
    
    List<AbonosCuentasXPagar> abonos;
    List<Proveedores> proveedor;
    List<OrdenesCompraView> ordenes;
    AbonosCuentasXPagar abonoNuevo;
    AbonosCuentasXPagar abonoSeleccionado;
    Proveedores proveedorNuevo;
    Proveedores proveedorSelecionado;
    CuentasXPagar cuentaNuevo;
    CuentasXPagar cuentaSeleccionado;
    OrdenesCompra ordenNuevo;
    OrdenesCompra ordenSeleccionado;
    
    Date fecha;
     /**
     * Creates a new instance of AbonosCuentasXPagarMainBean
     */
    public AbonosCuentasXPagarMainBean() {
       
    }
    
    @PostConstruct
    public void init(){
        try {
            this.date = new Date();
            this.abonoSeleccionado = new AbonosCuentasXPagar();
            this.proveedor = proveedorDAO.getOdenesProveedores();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void obtenerOrdenes(){
        try {
            this.ordenes= abonoscuentaspagarDAO.getOrdenesComprasViewXProveedor(proveedorSelecionado.getCodigo());
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        
    }
    
    public void insertarAbono() {
        try {
            if (ordenSeleccionado == null){
                throw new Exception("Debe Seleccionar una orden para realizar el Abono");
            }
            abonoSeleccionado.setEstatus("ACTIVO");
            abonoSeleccionado.setCuentasXPagar(ordenSeleccionado.getCuentaXPagar());
            abonoscuentaspagarDAO.insertarAbono(abonoSeleccionado);
            ordenSeleccionado.getCuentaXPagar().getAbonosCuentasXPagars().add(abonoSeleccionado);
            MsgUtility.showInfoMeage("El abono se insertó con éxito");
           
            
        } catch (Exception ex) {
          MsgUtility.showErrorMeage(ex.getMessage());  
        }  
}
    
    public void actualizarAbono() {
        try {
            if (ordenSeleccionado == null){
                throw new Exception("Debe Seleccionar una orden para cancelar el Abono");
            }
            abonoSeleccionado.setEstatus("CANCELADO");
            abonoscuentaspagarDAO.actualizarAbono(abonoSeleccionado);
            MsgUtility.showInfoMeage("El abono se canceló con éxito");
            
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }
    public void onDateSelect(SelectEvent event) {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        facesContext.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Date Selected", format.format(event.getObject())));
    }
     
    public void click() {
        RequestContext requestContext = RequestContext.getCurrentInstance();
         
        requestContext.update("form:display");
        requestContext.execute("PF('dlg').show()");
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public List<OrdenesCompraView> getOrdenes() {
        return ordenes;
    }

    public void setOrdenes(List<OrdenesCompraView> ordenes) {
        this.ordenes = ordenes;
    }


    

    
    public OrdenesCompra getOrdenNuevo() {
        return ordenNuevo;
    }

    public void setOrdenNuevo(OrdenesCompra ordenNuevo) {
        this.ordenNuevo = ordenNuevo;
    }

    public OrdenesCompra getOrdenSeleccionado() {
        return ordenSeleccionado;
    }

    public void setOrdenSeleccionado(OrdenesCompra ordenSeleccionado) {
        this.ordenSeleccionado = ordenSeleccionado;
    }
    

    public CuentasXPagar getCuentaNuevo() {
        return cuentaNuevo;
    }

    public void setCuentaNuevo(CuentasXPagar cuentaNuevo) {
        this.cuentaNuevo = cuentaNuevo;
    }

    public CuentasXPagar getCuentaSeleccionado() {
        return cuentaSeleccionado;
    }

    public void setCuentaSeleccionado(CuentasXPagar cuentaSeleccionado) {
        this.cuentaSeleccionado = cuentaSeleccionado;
    }
    

    public AbonosCuentasXPagarDAO getAbonoscuentaspagarDAO() {
        return abonoscuentaspagarDAO;
    }

    public void setAbonoscuentaspagarDAO(AbonosCuentasXPagarDAO abonoscuentaspagarDAO) {
        this.abonoscuentaspagarDAO = abonoscuentaspagarDAO;
    }

    public ProveedorDAO getProveedorDAO() {
        return proveedorDAO;
    }

    public void setProveedorDAO(ProveedorDAO proveedorDAO) {
        this.proveedorDAO = proveedorDAO;
    }

    public List<AbonosCuentasXPagar> getAbonos() {
        return abonos;
    }

    public void setAbonos(List<AbonosCuentasXPagar> abonos) {
        this.abonos = abonos;
    }

    public List<Proveedores> getProveedor() {
        return proveedor;
    }

    public void setProveedor(List<Proveedores> proveedor) {
        this.proveedor = proveedor;
    }

    public AbonosCuentasXPagar getAbonoNuevo() {
        return abonoNuevo;
    }

    public void setAbonoNuevo(AbonosCuentasXPagar abonoNuevo) {
        this.abonoNuevo = abonoNuevo;
    }

    public AbonosCuentasXPagar getAbonoSeleccionado() {
        return abonoSeleccionado;
    }

    public void setAbonoSeleccionado(AbonosCuentasXPagar abonoSeleccionado) {
        this.abonoSeleccionado = abonoSeleccionado;
    }

    public Proveedores getProveedorNuevo() {
        return proveedorNuevo;
    }

    public void setProveedorNuevo(Proveedores proveedorNuevo) {
        this.proveedorNuevo = proveedorNuevo;
    }

    public Proveedores getProveedorSelecionado() {
        return proveedorSelecionado;
    }

    public void setProveedorSelecionado(Proveedores proveedorSelecionado) {
        this.proveedorSelecionado = proveedorSelecionado;
    }



    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public OrdenesCompraDAO getOrdenescompraDAO() {
        return ordenescompraDAO;
    }

    public void setOrdenescompraDAO(OrdenesCompraDAO ordenescompraDAO) {
        this.ordenescompraDAO = ordenescompraDAO;
    }
    
    
    
    
}
