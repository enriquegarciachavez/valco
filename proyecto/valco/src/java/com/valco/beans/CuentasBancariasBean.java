/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.pojo.CuentasContables;
import com.valco.utility.MsgUtility;
import java.util.ArrayList;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

/**
 *
 * @author Karla
 */
@ManagedBean
@ViewScoped
public class CuentasBancariasBean {

    /**
     * Creates a new instance of CuentasBancariasBean
     */
    private CuentasContables cuentaNueva;    
    private CuentasContables cuentaSeleccionada;
    private List<CuentasContables> cuentas;
    

    public CuentasBancariasBean() {
        cuentas = new ArrayList<>();
        cuentaNueva = new CuentasContables();

    }
    
    public void insertarCuentaBancaria() {
        CuentasContables cuenta = new CuentasContables();
        if (cuentaNueva.getNoDeCuenta() == null || "".equals(cuentaNueva.getNoDeCuenta())) {
            MsgUtility.showErrorMessage("Datos Faltantes", "El numero de cuenta es un campo requerido");
            return;
        }
        if (cuentas.contains(cuentaNueva)) {
            MsgUtility.showErrorMessage("Cuenta Duplicada", "El numero de cuenta no puede repetirse");
            return;
        }
        cuenta.setDescripcion(cuentaNueva.getDescripcion());
        cuenta.setRfcBanco(cuentaNueva.getRfcBanco());
        cuenta.setNoDeCuenta(cuentaNueva.getNoDeCuenta());
        cuenta.setEsBanco(false);
        cuenta.setEstatus("ACTIVO");
        cuenta.setTipo("CLIENTE");
        cuentas.add(cuenta);
        cuentaNueva = new CuentasContables();
    }
    
    
    public void eliminarCuentaBancaria() {
        cuentas.remove(cuentaSeleccionada);

    }
    
    public void clean(){
        setCuentaNueva(new CuentasContables());
        setCuentaSeleccionada(new CuentasContables());
        cuentas.clear();
    }
    
    public List<CuentasContables> getCuentas() {
        return cuentas;
    }

    public void setCuentas(List<CuentasContables> cuentas) {
        this.cuentas = cuentas;
    }

    public CuentasContables getCuentaNueva() {
        return cuentaNueva;
    }

    public void setCuentaNueva(CuentasContables cuentaNueva) {
        this.cuentaNueva = cuentaNueva;
    }

    public CuentasContables getCuentaSeleccionada() {
        return cuentaSeleccionada;
    }

    public void setCuentaSeleccionada(CuentasContables cuentaSeleccionada) {
        this.cuentaSeleccionada = cuentaSeleccionada;
    }
    
    
    
    

}
