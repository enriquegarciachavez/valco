/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ClienteDAO;
import com.valco.pojo.Clientes;
import com.valco.dao.AbonosCuentasXCobrarDAO;
import com.valco.dao.NotasVentaDAO;
import com.valco.pojo.AbonosCuentasXCobrar;
import com.valco.pojo.AbonosCuentasXPagar;
import com.valco.pojo.CuentasXCobrar;
import com.valco.pojo.CuentasXPagar;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.NotasDeVentaView;
import com.valco.utility.MsgUtility;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import org.primefaces.context.RequestContext;
import org.primefaces.event.SelectEvent;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class AbonosCuentasXCobrarMainBean {

    private Date date1;
    @ManagedProperty(value = "#{abonoscuentascobrarDAO}")
    private AbonosCuentasXCobrarDAO abonoscuentascobrarDAO;

    @ManagedProperty(value = "#{clienteDao}")
    private ClienteDAO clienteDao;
    @ManagedProperty(value = "#{notadeVentaDao}")
    private NotasVentaDAO notasDeVentaDao;
    List<Clientes> clientes;
    List<NotasDeVentaView> notas;
    List<AbonosCuentasXCobrar> abonos;
    AbonosCuentasXCobrar abonoNuevo;
    AbonosCuentasXCobrar abonoSeleccionado;
    CuentasXCobrar cuentaSeleccionado;
    CuentasXCobrar cuentaNuevo;
    Clientes clienteSelecionado;
    NotasDeVentaView notaSeleccionado;

    Date fecha;

    /**
     * Creates a new instance of CuentasXCobrarMainBean
     */
    public AbonosCuentasXCobrarMainBean() {

    }

    @PostConstruct
    public void init() {
        try {
            notas = new ArrayList<>();
            this.date1 = new Date();
            this.abonoSeleccionado = new AbonosCuentasXCobrar();
            this.clientes = clienteDao.getClientesConAdeudo();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void obtenerNotas (){
        
        try {
            this.notas  = notasDeVentaDao.getNotasDeVentaViewXCliente(clienteSelecionado);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        
    }
    
    public void obtenerAbonos(){
        try {
            if(notaSeleccionado == null){
                throw new Exception("Debe seleccionar una nota para cancelar abonos");
            }
            this.abonos = this.abonoscuentascobrarDAO.getAbonosXCuentasXCobrar(notaSeleccionado.getCuentaXCobrar());
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void insertarAbono() {
        try {
            if (notaSeleccionado == null) {
                throw new Exception("Debe Seleccionar una nota para realizar el abono");
            }
            abonoSeleccionado.setEstatus("ACTIVO");
            abonoSeleccionado.setCuentasXCobrar(notaSeleccionado.getCuentaXCobrar());
            abonoscuentascobrarDAO.insertarAbono(abonoSeleccionado);
            notaSeleccionado.setImporteAbonado(notaSeleccionado.getImporteAbonado().add(abonoSeleccionado.getImporte()));
            notaSeleccionado.setSaldoPendiente(notaSeleccionado.getImporte().subtract(notaSeleccionado.getImporteAbonado()));

            MsgUtility.showInfoMeage("Se realizó el abono correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void actualizarAbono() {
        try {
            if (notaSeleccionado == null) {
                throw new Exception("Debe Seleccionar una nota para Cancelar el abono");
            }else if(abonoSeleccionado == null){
                throw new Exception("Debe Seleccionar un abono para Cancelar");
            }
            abonoSeleccionado.setEstatus("CANCELADO");
            abonoscuentascobrarDAO.actualizarAbono(abonoSeleccionado);
            notaSeleccionado.setImporteAbonado(notaSeleccionado.getImporteAbonado().subtract(abonoSeleccionado.getImporte()));
            notaSeleccionado.setSaldoPendiente(notaSeleccionado.getImporte().subtract(notaSeleccionado.getImporteAbonado()));
            MsgUtility.showInfoMeage("Se canceló el abono correctamente.");
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

    public CuentasXCobrar getCuentaSeleccionado() {
        return cuentaSeleccionado;
    }

    public void setCuentaSeleccionado(CuentasXCobrar cuentaSeleccionado) {
        this.cuentaSeleccionado = cuentaSeleccionado;
    }

    public CuentasXCobrar getCuentaNuevo() {
        return cuentaNuevo;
    }

    public void setCuentaNuevo(CuentasXCobrar cuentaNuevo) {
        this.cuentaNuevo = cuentaNuevo;
    }
    
    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }

    public Date getDate1() {
        return date1;
    }

    public void setDate1(Date date1) {
        this.date1 = date1;
    }

    public Clientes getClienteSelecionado() {
        return clienteSelecionado;
    }

    public void setClienteSelecionado(Clientes clienteSelecionado) {
        this.clienteSelecionado = clienteSelecionado;
    }

    public AbonosCuentasXCobrarDAO getAbonoscuentascobrarDAO() {
        return abonoscuentascobrarDAO;
    }

    public void setAbonoscuentascobrarDAO(AbonosCuentasXCobrarDAO abonoscuentascobrarDAO) {
        this.abonoscuentascobrarDAO = abonoscuentascobrarDAO;
    }

    public ClienteDAO getClienteDao() {
        return clienteDao;
    }

    public void setClienteDao(ClienteDAO clienteDao) {
        this.clienteDao = clienteDao;
    }

    public List<Clientes> getClientes() {
        return clientes;
    }

    public void setClientes(List<Clientes> clientes) {
        this.clientes = clientes;
    }

    public List<AbonosCuentasXCobrar> getAbonos() {
        return abonos;
    }

    public void setAbonos(List<AbonosCuentasXCobrar> abonos) {
        this.abonos = abonos;
    }

    public AbonosCuentasXCobrar getAbonoNuevo() {
        return abonoNuevo;
    }

    public void setAbonoNuevo(AbonosCuentasXCobrar abonoNuevo) {
        this.abonoNuevo = abonoNuevo;
    }

    public AbonosCuentasXCobrar getAbonoSeleccionado() {
        return abonoSeleccionado;
    }

    public void setAbonoSeleccionado(AbonosCuentasXCobrar abonoSeleccionado) {
        this.abonoSeleccionado = abonoSeleccionado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public List<NotasDeVentaView> getNotas() {
        return notas;
    }

    public void setNotas(List<NotasDeVentaView> notas) {
        this.notas = notas;
    }

    public NotasDeVentaView getNotaSeleccionado() {
        return notaSeleccionado;
    }

    public void setNotaSeleccionado(NotasDeVentaView notaSeleccionado) {
        this.notaSeleccionado = notaSeleccionado;
    }
    
    
}
