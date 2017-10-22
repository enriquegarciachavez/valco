/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.FacturasDAO;
import com.valco.pojo.Facturas;
import com.valco.utility.MsgUtility;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.RequestScoped;
import org.omnifaces.util.Faces;
import org.primefaces.context.RequestContext;

/**
 *
 * @author Administrador
 */
@ManagedBean
@RequestScoped
public class ReimpresionFacturaBean {
private Integer noFactura;
private Integer noNota;
private boolean facturaOriginal;
private boolean facturaCopia;
@ManagedProperty(value="#{facturasDao}")
private FacturasDAO facturasDao;
    /**
     * Creates a new instance of ReimpresionFacturaBean
     */

    private Facturas getFactura(Integer factura, Integer nota) throws Exception{
        List<Facturas> facturas = this.facturasDao.getFacturas(factura, nota);
        if(facturas == null || facturas.isEmpty()){
            return null;
        }else{
            return facturas.get(0);
        }
    }
    
    public void reimprimirFactras(){
        try {
            Facturas factura = this.getFactura(noFactura, noNota);
            if(factura != null){
                if(!this.isFacturaCopia()&&!this.isFacturaOriginal()){
                    MsgUtility.showWarnMeage("Debe seleccionar si quiere copia o original");
                }
                if(this.isFacturaCopia()){
                    String url = "/valco/ReportesPdf?reporte="+
                        "//pagina//reportes//ventasconfactura//FacturaNuevo.jrxml"+
                        "&FacturaIdInt="+factura.getCodigo().toString()+
                         "&IsCopiaBool=true";
                    RequestContext.getCurrentInstance().execute("window.open('"+url+"');");
                }
                if(this.isFacturaOriginal()){
                    String url = "/valco/ReportesPdf?reporte="+
                        "//pagina//reportes//ventasconfactura//FacturaNuevo.jrxml"+
                        "&FacturaIdInt="+factura.getCodigo().toString()+
                         "&IsCopiaBool=false";
                    RequestContext.getCurrentInstance().execute("window.open('"+url+"');");
                }
            }else{
                MsgUtility.showWarnMeage("No se encontró la factura buscada.");
            }
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al consultar la factura.");
        }
    }

    public ReimpresionFacturaBean() {
    }

    public Integer getNoFactura() {
        return noFactura;
    }

    public void setNoFactura(Integer noFactura) {
        this.noFactura = noFactura;
    }

    public Integer getNoNota() {
        return noNota;
    }

    public void setNoNota(Integer noNota) {
        this.noNota = noNota;
    }

    public boolean isFacturaOriginal() {
        return facturaOriginal;
    }

    public void setFacturaOriginal(boolean facturaOriginal) {
        this.facturaOriginal = facturaOriginal;
    }

    public boolean isFacturaCopia() {
        return facturaCopia;
    }

    public void setFacturaCopia(boolean facturaCopia) {
        this.facturaCopia = facturaCopia;
    }

    public FacturasDAO getFacturasDao() {
        return facturasDao;
    }

    public void setFacturasDao(FacturasDAO facturasDao) {
        this.facturasDao = facturasDao;
    }
    
    
}
