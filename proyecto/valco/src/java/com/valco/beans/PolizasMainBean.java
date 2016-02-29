/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.CuentasContablesDAO;
import com.valco.dao.PolizasDAO;
import com.valco.pojo.Conceptos;
import com.valco.pojo.CuentasContables;
import com.valco.pojo.Polizas;
import com.valco.utility.MsgUtility;
import java.io.IOException;
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
import javax.faces.context.FacesContext;
import javax.ws.rs.POST;
import org.omnifaces.util.Faces;
import org.primefaces.context.RequestContext;
import org.primefaces.event.SelectEvent;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class PolizasMainBean {

    private Date date;
    @ManagedProperty(value = "#{polizasDAO}")
    private PolizasDAO polizasDAO;
    @ManagedProperty(value = "#{cuentascontablesDAO}")
    private CuentasContablesDAO cuentascontablesDAO;
    private List<CuentasContables> cuentasContables;
    private List<Conceptos> conceptos = new ArrayList<>();
    CuentasContables cuentaSeleccionada;
    private List<Polizas> polizas;
    private Polizas poliza;
    private Polizas polizaNueva;
    Conceptos conceptoNuevo = new Conceptos();

    Date fecha;

    String tipoPoliza;

    /**
     * Creates a new instance of PolizasMainBean
     */
    public PolizasMainBean() {
    }

    public void onDateSelect(SelectEvent event) {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        facesContext.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Date Selected", format.format(event.getObject())));
    }

    @PostConstruct
    public void init() {
        try {
            this.date = new Date();
            poliza = new Polizas();
            polizas = new ArrayList<Polizas>();
            this.cuentasContables = cuentascontablesDAO.getCuentasContables();

        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void insertarConceptos() {
        try {
            polizasDAO.insertarConcepto(conceptoNuevo);
            this.conceptos.add(conceptoNuevo);
            conceptoNuevo = new Conceptos();
            MsgUtility.showInfoMeage("La poliza se ingresó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void borrarConcepto(Conceptos concepto) {
        try {
            polizasDAO.borrarConcepto(concepto);

        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void buscar() throws Exception {
        polizaNueva = polizasDAO.getPolizasBuscar(fecha, tipoPoliza);
        if (polizaNueva == null) {
            polizaNueva = new Polizas();
            polizaNueva.setEstatus("ACTIVO");
            polizaNueva.setFecha(fecha);
            polizaNueva.setTipoPoliza(tipoPoliza);
            polizasDAO.insertarPoliza(polizaNueva);
        }

    }

    public String reinit() {
        conceptoNuevo.setPoliza(polizaNueva);
        try {
            polizasDAO.insertarConcepto(conceptoNuevo);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        conceptoNuevo = new Conceptos();

        return null;
    }
    
    
    public void mostrarPdf(){
        String tipoPoliza = "";
        if(this.tipoPoliza.equals("DE INGRESOS")){
            tipoPoliza = "poliza_ingresos_main.jrxml";
        }else{
            tipoPoliza = "poliza_diario_main.jrxml";
        }
        String url = "/valco/ReportesPdf?reporte="
                + "//pagina//reportes//polizas//"
                + tipoPoliza
                + "&fechaDate="+fecha.toString();
        RequestContext.getCurrentInstance().execute("window.open('"+url+"');");
    }

    public void createNew() {
        polizas.add(poliza);
        poliza = new Polizas();

    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public PolizasDAO getPolizasDAO() {
        return polizasDAO;
    }

    public void setPolizasDAO(PolizasDAO polizasDAO) {
        this.polizasDAO = polizasDAO;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public List<Polizas> getPolizas() {
        return polizas;
    }

    public void setPolizas(List<Polizas> polizas) {
        this.polizas = polizas;
    }

    public Polizas getPoliza() {
        return poliza;
    }

    public void setPoliza(Polizas poliza) {
        this.poliza = poliza;
    }

    public CuentasContablesDAO getCuentascontablesDAO() {
        return cuentascontablesDAO;
    }

    public void setCuentascontablesDAO(CuentasContablesDAO cuentascontablesDAO) {
        this.cuentascontablesDAO = cuentascontablesDAO;
    }

    public String getTipoPoliza() {
        return tipoPoliza;
    }

    public void setTipoPoliza(String tipoPoliza) {
        this.tipoPoliza = tipoPoliza;
    }

    public List<CuentasContables> getCuentasContables() {
        return cuentasContables;
    }

    public void setCuentasContables(List<CuentasContables> cuentasContables) {
        this.cuentasContables = cuentasContables;
    }

    public CuentasContables getCuentaSeleccionada() {
        return cuentaSeleccionada;
    }

    public void setCuentaSeleccionada(CuentasContables cuentaSeleccionada) {
        this.cuentaSeleccionada = cuentaSeleccionada;
    }

    public Conceptos getConceptoNuevo() {
        return conceptoNuevo;
    }

    public void setConceptoNuevo(Conceptos conceptoNuevo) {
        this.conceptoNuevo = conceptoNuevo;
    }

    public List<Conceptos> getConceptos() {
        return conceptos;
    }

    public void setConceptos(List<Conceptos> conceptos) {
        this.conceptos = conceptos;
    }

    public Polizas getPolizaNueva() {
        return polizaNueva;
    }

    public void setPolizaNueva(Polizas polizaNueva) {
        this.polizaNueva = polizaNueva;
    }

}
