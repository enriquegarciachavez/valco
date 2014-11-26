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
import com.valco.pojo.NotasDeVenta;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
    @ManagedProperty(value="#{notadeVentaDao}")
            private NotasVentaDAO notasDeVentaDao;
    List<Clientes> clientes;
    List<NotasDeVenta> nota;
    List<AbonosCuentasXCobrar> abonos;
    AbonosCuentasXCobrar abonoNuevo;
    AbonosCuentasXCobrar abonoSeleccionado;
    Clientes clienteSelecionado;
    NotasDeVenta notaSeleccionado;
    DataModel modeloAbono;
    DataModel modeloNotas;
    UIInput importe;
    Date fecha;
    
    
    
    

    /**
     * Creates a new instance of CuentasXCobrarMainBean
     */
    public AbonosCuentasXCobrarMainBean() {
       
    }

    public NotasDeVenta getNotaSeleccionado() {
        return notaSeleccionado;
    }

    public void setNotaSeleccionado(NotasDeVenta notaSeleccionado) {
        this.notaSeleccionado = notaSeleccionado;
    }
    
    

    public DataModel getModeloNotas() throws Exception {
        nota = notasDeVentaDao.getNotasDeVenta();
        modeloNotas = new ListDataModel(nota);
        return modeloNotas;
    }

    public void setModeloNotas(DataModel modeloNotas) {
        this.modeloNotas = modeloNotas;
    }
    
    

    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }

    public List<NotasDeVenta> getNota() {
        return nota;
    }

    public void setNota(List<NotasDeVenta> nota) {
        this.nota = nota;
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

    public DataModel getModeloAbono() throws Exception {
        abonos = abonoscuentascobrarDAO.getAbonosCuentasXCobrar();
        modeloAbono = new ListDataModel(abonos);
        return modeloAbono;
    }

    public void setModeloAbono(DataModel modeloAbono) {
        this.modeloAbono = modeloAbono;
    }

    public UIInput getImporte() {
        return importe;
    }

    public void setImporte(UIInput importe) {
        this.importe = importe;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    
    @PostConstruct
    public void init(){
        try {
            this.date1 = new Date();
            this.nota = notasDeVentaDao.getNotasDeVenta();
            this.clientes = clienteDao.getClientes();
        } catch (Exception ex) {
            
        }
    }
    
    
    
    
    
    
}
