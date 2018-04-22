/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.pojo;

/**
 *
 * @author Karla
 */
public class UsoCFDI {

    private String codigo;
    private String descripcion;
    private boolean aplicaFisica;
    private boolean aplicaMoral;

    public UsoCFDI() {

    }

    public UsoCFDI(String codigo) {
        this.codigo = codigo;
    }

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

    public boolean isAplicaFisica() {
        return aplicaFisica;
    }

    public void setAplicaFisica(boolean aplicaFisica) {
        this.aplicaFisica = aplicaFisica;
    }

    public boolean isAplicaMoral() {
        return aplicaMoral;
    }

    public void setAplicaMoral(boolean aplicaMoral) {
        this.aplicaMoral = aplicaMoral;
    }
    
    public String toString(){
        return this.codigo + " - " + this.descripcion;
    }

    public boolean equals(Object o) {
        if (o != null) {
            if ((o instanceof UsoCFDI) && (((UsoCFDI) o).getCodigo().equals(this.getCodigo()))) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

}
