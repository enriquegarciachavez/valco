/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.NotasVentaDAO;
import com.valco.pojo.NotasDeVenta;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.ValidatorException;

/**
 *
 * @author Administrador
 */
@ManagedBean
@RequestScoped
public class ValidationBean {
    @ManagedProperty(value="#{notadeVentaDao}")
    private NotasVentaDAO notasDeVentaDao;
    /**
     * Creates a new instance of ValidationBean
     */
    public ValidationBean() {
    }
    
     public void validaEstatusActivo(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        NotasDeVenta aux = new NotasDeVenta();
        aux = 
                this.notasDeVentaDao.getNotaDeVentaXFolio((int)value);
        if(aux == null){
            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor")); 
        }else if(aux.getEstatus() == null){
            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));

        }else if(aux.getEstatus().equals("La nota de venta no ha sido asignada a un repartidor")){

            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));
        }else if(aux.getEstatus().equals("CANCELADA")){

            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));
        }else if(aux.getEstatus().equals("FACTURADA")){

            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));
        }else if(aux.getEstatus().equals("VENDIDA")){

            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));
        }else{
            
            throw new ValidatorException(new FacesMessage("La nota de venta no no se encuentra activa")); 
        
        }
    }

    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }
    
     
}
