package security;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/*
 * ===========================================================================
 * Materiales con licencia - Propiedad de IBM
 *
 * (C) Copyright IBM Corp. 2000 Reservados todos los derechos.
 *
 *  Derechos restringidos de los usuarios del Gobierno de EE. UU.
 *  El uso, la reproducción o la divulgación están sujetos a las
 *  restricciones establecidas por GSA ADP Schedule Contract con IBM Corp.
 * ===========================================================================
 *
 * Archivo: HWPrincipal.java
 */

import java.security.Principal;

/**
 * Esta clase implementa la interfaz Principal
 * y representa un comprobador de HelloWorld.
 *
 * @version 1.1, 09/10/99
 * @author D. Kent Soper
 */
public class HWPrincipal implements Principal, java.io.Serializable {

    private String name;

    /*
     * Crear un HWPrincipal con el nombre suministrado.
     */
    public HWPrincipal(String name) {
        if (name == null)
            throw new NullPointerException("entrada null no permitida");

        this.name = name;
    }

    /*
     * Devolver el nombre del HWPrincipal.
     */
    public String getName() {
        return name;
    }

    /*
     * Devolver una representación de tipo serie del HWPrincipal.
     */
    public String toString() {
        return("HWPrincipal:  " + name);
    }

    /*
     * Compara el objeto (Object) especificado con el HWPrincipal para ver si son iguales.
     * Devuelve true si el objeto dado también es un HWPrincipal y los
     * dos HWPrincipals tienen el mismo nombre de usuario.
     */
    public boolean equals(Object o) {
        if (o == null)
            return false;

        if (this == o)
            return true;

        if (!(o instanceof HWPrincipal))
            return false;
        HWPrincipal that = (HWPrincipal)o;

        if (this.getName().equals(that.getName()))
            return true;
        return false;
    }

    /*
     * Devolver un código hash para el HWPrincipal.
     */
    public int hashCode() {
        return name.hashCode();
    }
}