/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import java.math.BigDecimal;

/**
 *
 * @author Administrador
 */
public class Conceptos {
    
    Integer codigo;
    BigDecimal debe;
    BigDecimal haber;
    Polizas poliza;
    CuentasContables cuentaContable;

    public Conceptos() {
    }
    
    

    public Conceptos(Integer codigo, BigDecimal debe, BigDecimal haber, Polizas poliza, CuentasContables cuentaContable) {
        this.codigo = codigo;
        this.debe = debe;
        this.haber = haber;
        this.poliza = poliza;
        this.cuentaContable = cuentaContable;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public BigDecimal getDebe() {
        return debe;
    }

    public void setDebe(BigDecimal debe) {
        this.debe = debe;
    }

    public BigDecimal getHaber() {
        return haber;
    }

    public void setHaber(BigDecimal haber) {
        this.haber = haber;
    }

    public Polizas getPoliza() {
        return poliza;
    }

    public void setPoliza(Polizas poliza) {
        this.poliza = poliza;
    }

    public CuentasContables getCuentaContable() {
        return cuentaContable;
    }

    public void setCuentaContable(CuentasContables cuentaContable) {
        this.cuentaContable = cuentaContable;
    }
    
    
}
