/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.NotasVentaDAO;
import com.valco.dao.RepartidoresDAO;
import com.valco.dao.UsuariosDAO;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.Repartidores;
import com.valco.pojo.Usuarios;
import com.valco.utility.MsgUtility;
import com.valco.utility.UsuariosUtility;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import sun.misc.Request;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class AsignacionNotasMainBean {
    
    @ManagedProperty(value="#{notadeVentaDao}")
            private NotasVentaDAO notadeVentaDao;
    @ManagedProperty(value="#{repartidoresDao}")
            private RepartidoresDAO repartidoresDao;
    @ManagedProperty(value = "#{usuariosDao}")
        private UsuariosDAO usuariosDao;
    List<NotasDeVenta> notasDeVenta;
    List<Repartidores> repartidores;
    Repartidores repartidor;
    NotasDeVenta asignacionNuevo;
    NotasDeVenta asignacionSeleccionado;
    Integer folioInicial;
    Integer folioFinal;
    DataModel modeloAsignacion;
    private List<NotasDeVenta> notasSeleccionadas;

    public DataModel getModeloAsignacion() throws Exception {
        notasDeVenta = notadeVentaDao.getAsignacionNotasDeVenta();
        modeloAsignacion = new ListDataModel(notasDeVenta);
        return modeloAsignacion;
    }

    public void setModeloAsignacion(DataModel modeloAsignacion) {
        this.modeloAsignacion = modeloAsignacion;
    }
    
    @PostConstruct
    public void init(){
        try {
          this.repartidores = repartidoresDao.getRepartidores();
        } catch (Exception ex) {
            
        }
    }
    public void asignarNotas() {
        List<NotasDeVenta> notas = new ArrayList<NotasDeVenta>();
        List<NotasDeVenta> notasExistentes = new ArrayList<NotasDeVenta>();
        if (folioFinal < folioInicial) {
            FacesMessage msg = null;
            msg = new FacesMessage("El Folio final debe ser "
                    + "mayor que el folio inicial");
            FacesContext.getCurrentInstance().addMessage(null, msg);
            return;
        }
        
        try {
            notasExistentes
                    = notadeVentaDao.getNotasXRangoFolio(folioInicial, folioFinal);
            if (notasExistentes != null && !notasExistentes.isEmpty()) {
                FacesMessage msg = null;
                msg = new FacesMessage("El rango indicado incluye folios que "
                        + "ya se encuentran asignados.");
                FacesContext.getCurrentInstance().addMessage(null, msg);
                return;
            }
        } catch (Exception ex) {
            FacesMessage msg = null;
            msg = new FacesMessage("Ocurrió un error al verificar si las "
                    + "notas ya se hbían asignado.");
            FacesContext.getCurrentInstance().addMessage(null, msg);
            return;
        }

        for (int x = folioInicial; x <= folioFinal; x++) {
            
            
            NotasDeVenta notaNueva = new NotasDeVenta();
            notaNueva.setEstatus("ASIGNADA");
            notaNueva.setFolio(x);
            notaNueva.setRepartidores(repartidor);
            notaNueva.setUsuarios(UsuariosUtility.getUsuarioFirmado());
            notas.add(notaNueva);

        }
        try {
            notadeVentaDao.insertarNotas(notas);
        } catch (Exception ex) {
            FacesMessage msg = null;
            msg = new FacesMessage(ex.getMessage());
            FacesContext.getCurrentInstance().addMessage(null, msg);

        }

    }
    
    public void borrarNotas(){
        try {
            notadeVentaDao.borrarNotasDeVenta(notasSeleccionadas);
            FacesMessage msg = null;
            msg = new FacesMessage("Las notas se borraron correctamente.");
            FacesContext.getCurrentInstance().addMessage(null, msg);
        } catch (Exception ex) {
            FacesMessage msg = null;
            msg = new FacesMessage(FacesMessage.SEVERITY_WARN,"","Ocurrió un error al borrar las notas.");
            FacesContext.getCurrentInstance().addMessage(null, msg);
        }
    }
    
    /**
     * Creates a new instance of AsignacionNotasMainBean
     */
    public AsignacionNotasMainBean() {
    }

    public Repartidores getRepartidor() {
        return repartidor;
    }

    public void setRepartidor(Repartidores repartidor) {
        this.repartidor = repartidor;
    }

    public Integer getFolioInicial() {
        return folioInicial;
    }

    public void setFolioInicial(Integer folioInicial) {
        this.folioInicial = folioInicial;
    }

    public Integer getFolioFinal() {
        return folioFinal;
    }

    public void setFolioFinal(Integer folioFinal) {
        this.folioFinal = folioFinal;
    }

    
    

    public NotasVentaDAO getNotadeVentaDao() {
        return notadeVentaDao;
    }

    public void setNotadeVentaDao(NotasVentaDAO notadeVentaDao) {
        this.notadeVentaDao = notadeVentaDao;
    }

    public RepartidoresDAO getRepartidoresDao() {
        return repartidoresDao;
    }

    public void setRepartidoresDao(RepartidoresDAO repartidoresDao) {
        this.repartidoresDao = repartidoresDao;
    }

    public List<NotasDeVenta> getNotasDeVenta() {
        return notasDeVenta;
    }

    public void setNotasDeVenta(List<NotasDeVenta> notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }

   

    public List<Repartidores> getRepartidores() {
        return repartidores;
    }

    public void setRepartidores(List<Repartidores> repartidores) {
        this.repartidores = repartidores;
    }

    

    public NotasDeVenta getAsignacionNuevo() {
        return asignacionNuevo;
    }

    public void setAsignacionNuevo(NotasDeVenta asignacionNuevo) {
        this.asignacionNuevo = asignacionNuevo;
    }

    public NotasDeVenta getAsignacionSeleccionado() {
        return asignacionSeleccionado;
    }

    public void setAsignacionSeleccionado(NotasDeVenta asignacionSeleccionado) {
        this.asignacionSeleccionado = asignacionSeleccionado;
    }
    
    public List<NotasDeVenta> getNotasSeleccionadas() {
        return notasSeleccionadas;
    }

    public void setNotasSeleccionadas(List<NotasDeVenta> notasSeleccionadas) {
        this.notasSeleccionadas = notasSeleccionadas;
    }

    public UsuariosDAO getUsuariosDao() {
        return usuariosDao;
    }

    public void setUsuariosDao(UsuariosDAO usuariosDao) {
        this.usuariosDao = usuariosDao;
    }

}