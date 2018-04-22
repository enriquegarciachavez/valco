/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.utility;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import org.primefaces.context.RequestContext;

/**
 *
 * @author Enrique
 */
public class MsgUtility {

    public static void showErrorMessage(String header, String msg) {
        FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_INFO, header, msg);
        RequestContext.getCurrentInstance().showMessageInDialog(message);

    }

    public static void showErrorMeage(String msg) {
        FacesMessage mensaje
                = new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", msg);
        FacesContext.getCurrentInstance().addMessage(null, mensaje);
    }

    public static void showWarnMeage(String msg) {
        FacesMessage mensaje
                = new FacesMessage(FacesMessage.SEVERITY_WARN, "Advertencia", msg);
        FacesContext.getCurrentInstance().addMessage(null, mensaje);
    }

    public static void showInfoMeage(String msg) {
        FacesMessage mensaje
                = new FacesMessage(FacesMessage.SEVERITY_INFO, "Información", msg);
        FacesContext.getCurrentInstance().addMessage(null, mensaje);
    }

    public static void showFatalMeage(String msg) {
        FacesMessage mensaje
                = new FacesMessage(FacesMessage.SEVERITY_FATAL, "Error Fatal", msg);
        FacesContext.getCurrentInstance().addMessage(null, mensaje);
    }

    public static FacesMessage getWarnMessage(String msg) {
        FacesMessage mensaje
                = new FacesMessage(FacesMessage.SEVERITY_WARN, "Advertencia", msg);
        return mensaje;
    }

}
