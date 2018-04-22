/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

import javax.persistence.Column;
import org.hibernate.annotations.Formula;

/**
 *
 * @author Karla
 */
public class FormaPago {

    private String codigo;
    private String descripcion;
    private String patronCtaOrdenante;
    private String patronCtaBeneficiario;
    private Boolean bancarizado;
    private Boolean tipoCadenaPago;

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getPatronCtaOrdenante() {
        return patronCtaOrdenante;
    }

    public void setPatronCtaOrdenante(String patronCtaOrdenante) {
        this.patronCtaOrdenante = patronCtaOrdenante;
    }

    public String getPatronCtaBeneficiario() {
        return patronCtaBeneficiario;
    }

    public void setPatronCtaBeneficiario(String patronCtaBeneficiario) {
        this.patronCtaBeneficiario = patronCtaBeneficiario;
    }

    public Boolean getBancarizado() {
        return bancarizado;
    }

    public void setBancarizado(Boolean bancarizado) {
        this.bancarizado = bancarizado;
    }

    public Boolean getTipoCadenaPago() {
        return tipoCadenaPago;
    }

    public void setTipoCadenaPago(Boolean tipoCadenaPago) {
        this.tipoCadenaPago = tipoCadenaPago;
    }

    public String toString() {
        return this.codigo + " - " + this.descripcion;
    }

    public boolean equals(Object o) {
        if (o != null) {
            if ((o instanceof FormaPago) && (((FormaPago) o).getCodigo() == this.getCodigo())) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

}
