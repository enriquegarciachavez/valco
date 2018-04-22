package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1

/**
 * MetodosPago generated by hbm2java
 */
public class MetodosPago implements java.io.Serializable {

    private Integer codigo;
    private String descripcion;
    private String estatus;
    private String codigoSat;

    public MetodosPago() {
    }

    public MetodosPago(String descripcion, String estatus) {
        this.descripcion = descripcion;
        this.estatus = estatus;
    }

    public Integer getCodigo() {
        return this.codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getDescripcion() {
        return this.descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstatus() {
        return this.estatus;
    }

    public String getCodigoSat() {
        return codigoSat;
    }

    public void setCodigoSat(String codigoSat) {
        this.codigoSat = codigoSat;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public String toString() {
        return this.codigoSat + " - " + this.descripcion;
    }

    public boolean equals(Object o) {
        if (o != null) {
            if ((o instanceof MetodosPago) && (((MetodosPago) o).getCodigo() == this.getCodigo())) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

}
