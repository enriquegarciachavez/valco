/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.FacturasDAO;
import com.valco.dao.NotasVentaDAO;
import com.valco.dao.ParametrosGeneralesDAO;
import com.valco.pojo.AbonosCuentasXCobrar;
import com.valco.pojo.Clientes;
import com.valco.pojo.Complemento;
import com.valco.pojo.ConceptosFactura;
import com.valco.pojo.Devoluciones;
import com.valco.pojo.DocRelacionado;
import com.valco.pojo.Facturas;
import com.valco.pojo.NotasCredito;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.ProductosInventario;
import com.valco.utility.FacturasUtility;
import com.valco.utility.Mail;
import com.valco.utility.MsgUtility;
import com.valco.utility.Pagos;
import com.valco.utility.ParametrosGeneralesUtility;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.mail.MessagingException;
import org.primefaces.context.RequestContext;

/**
 *
 * @author Administrador
 */
@ManagedBean
@ViewScoped
public class CancelacionFacturaBean {

    public Integer noFactura;
    public Integer noNota;
    public List<Facturas> facturasDisponibles;
    public Facturas facturaSeleccionada;
    @ManagedProperty(value = "#{facturasDao}")
    private FacturasDAO facturasDao;
    @ManagedProperty(value = "#{notadeVentaDao}")
    private NotasVentaDAO notasDeVentaDao;
    private List<NotasDeVenta> notasDeVenta;
    private NotasDeVenta notaSeleccionada;
    private NotasCredito notaNueva = new NotasCredito();
    private ProductosInventario productoSeleccionado;
    @ManagedProperty(value = "#{parametrosGeneralesDAO}")
    private ParametrosGeneralesDAO parametrosGeneralesDAO;

    /**
     * Creates a new instance of CancelacionFacturaBean
     */
    public CancelacionFacturaBean() {
    }

    public void consultarNotasDeVentaXFactura() {
        try {
            this.notasDeVenta = this.facturasDao.getNotasXFactura(facturaSeleccionada);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void buscar() {
        try {
            this.facturasDisponibles = this.facturasDao.getFacturasActivas(noFactura, noNota);

        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void cancelar() {

        try {
            this.facturaSeleccionada.setEstatus("CANCELADA");
            for (NotasDeVenta nota : facturaSeleccionada.getNotasDeVentas()) {
                nota.setEstatus("VENDIDA");
            }
            this.facturasDao.ActualizarFacturaYNotas(facturaSeleccionada);
            this.facturasDisponibles.remove(facturaSeleccionada);
            MsgUtility.showInfoMeage("La factura se canceló correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void crearNota() {
        List<ProductosInventario> productos = new ArrayList<>();
        List<Devoluciones> devoluciones = new ArrayList<>();
        notaNueva.setFecha(new Date());
        notaNueva.setFactura(facturaSeleccionada);
        for (NotasDeVenta nota : this.notasDeVenta) {
            for (ProductosInventario producto : nota.getProductosInventarios()) {
                if (producto.getDevuelto()) {
                    if (producto.getMalEstado()) {
                        producto.setEstatus("MALESTADO");
                        productos.add(producto);
                    } else {
                        if (producto.getDevolucionTotal()) {
                            producto.setEstatus("ACTIVO");
                            Devoluciones devolucion = new Devoluciones();
                            devolucion.setDevolucionTotal(Boolean.TRUE);
                            devolucion.setPeso(producto.getPeso());
                            devolucion.setProductosInventario(producto);
                            devolucion.setNotasCredito(notaNueva);
                            devoluciones.add(devolucion);
                            productos.add(producto);

                        } else {
                            Devoluciones devolucion = new Devoluciones();
                            devolucion.setDevolucionTotal(Boolean.FALSE);
                            devolucion.setPeso(producto.getCantidadDevuelta());
                            devolucion.setProductosInventario(producto);
                            devolucion.setNotasCredito(notaNueva);
                            devoluciones.add(devolucion);
                        }
                    }
                }
            }
        }
        try {
            Facturas notaDeCredito = new Facturas();
            /*notaDeCredito = facturaSeleccionada.getNotaDeCredito();
            ConceptosFactura concepto = new ConceptosFactura();
            concepto.setDescripcion(notaNueva.getObservaciones());
            concepto.setClave(0);
            concepto.setCantidad(BigDecimal.ONE);
            concepto.setPrecioUnitario(notaNueva.getCantidad());
            concepto.setImporteTotal(notaNueva.getCantidad());
            concepto.setUnidad("KG");
            Set<ConceptosFactura> conceptos = new HashSet<>();
            conceptos.add(concepto);
            notaDeCredito.setConceptosFacturas(conceptos);
            notaDeCredito.setSubtotal(notaNueva.getCantidad());
            notaDeCredito.setTotal(notaNueva.getCantidad());
            notaDeCredito.setTipoDocumento("egreso");
            notaDeCredito.setNoSeieCertEmisor("00001000000405339543");
            notaDeCredito.setIva(BigDecimal.ZERO);*/
            
            String correoCopia = "info.valco.sistemas@hotmail.com";
            
           /* try {
                correoCopia = parametrosGeneralesDAO.getParametroGeneralXClave("FA001");
            } catch (Exception ex) {
                correoCopia = "info.valco.sistemas@hotmail.com";
            }
            String xml = null;
            try {
                notaDeCredito.setCodigo(facturasDao.getConsecutivo());
                xml = FacturasUtility.facturar(notaDeCredito, notaDeCredito.getCodigo());
                MsgUtility.showInfoMeage("Factura " + notaDeCredito.getCodigo() + ": Facturada correctamente.");
            } catch (Exception ex) {
                MsgUtility.showErrorMeage(ex.getMessage());

            }
            try {
                notaDeCredito.setXml(xml);
                FacturasUtility.agregarDatosDeTimbrado(notaDeCredito, xml);
                MsgUtility.showInfoMeage("Factura " + notaDeCredito.getCodigo() + ": Datos de timbrado obtenidos correctamente.");
            } catch (Exception ex) {
                MsgUtility.showErrorMeage(ex.getMessage());
            }
            
            }*/
            
            armarComprobanteDeRcepcionDePago(notaDeCredito);
            FacturasUtility.facturarPago(notaDeCredito, notaDeCredito.getXml(), "02");
            try {
                facturasDao.insertarFacturaYActualizarNota(notaDeCredito);
                MsgUtility.showInfoMeage("Factura " + notaDeCredito.getCodigo() + ": Guardada correctamente en el sistema.");
            } catch (Exception ex) {
                MsgUtility.showErrorMeage(ex.getMessage());
            }
            try {
                FacturasUtility.guardaXml(notaDeCredito.getReceptor().getRfc() + "-" + notaDeCredito.getCodigo() + ".xml", notaDeCredito.getXml(), "C:/SAT/", notaDeCredito.getCodigo());
                MsgUtility.showInfoMeage("Factura " + notaDeCredito.getCodigo() + ": XML guardado correctamente.");
            } catch (Exception ex) {
                MsgUtility.showErrorMeage(ex.getMessage());
            }
            try {
                FacturasUtility.guardaPdf(notaDeCredito.getCodigo(), notaDeCredito.getReceptor().getRfc() + "-" + notaDeCredito.getCodigo() + ".pdf", "C:/SAT/");
                MsgUtility.showInfoMeage("Factura " + notaDeCredito.getCodigo() + ": PDF guardado correctamente.");
                String url = "/valco/ReportesPdf?reporte="
                        + "//pagina//reportes//ventasconfactura//FacturaNuevo.jrxml"
                        + "&FacturaIdInt=" + notaDeCredito.getCodigo().toString()
                        + "&isCopiaBool=false";
                RequestContext.getCurrentInstance().execute("window.open('" + url + "');");
            } catch (Exception ex) {
                MsgUtility.showErrorMeage(ex.getMessage());
            }
            try {
                Mail.Send(notaDeCredito.getReceptor().getCorreoElectronico(), correoCopia, "Factura de valco", "Esta es una factura de valco", "C:\\SAT\\" , notaDeCredito.getReceptor().getRfc() + "-" + notaDeCredito.getCodigo());
                MsgUtility.showInfoMeage("Factura " + notaDeCredito.getCodigo() + ": Correo enviado correctamente.");
            } catch (MessagingException ex) {
                ex.printStackTrace();
                MsgUtility.showErrorMeage(ex.getMessage());
            }
            this.facturasDao.crearNotadeCredito(notaNueva, productos, devoluciones);
        } catch (Exception ex) {
            ex.printStackTrace();
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    private void armarComprobanteDeRcepcionDePago(Facturas factura) throws Exception {
        ConceptosFactura concepto = new ConceptosFactura();
        Set<ConceptosFactura> conceptos = new HashSet<>();
        Clientes emisor = new Clientes();
        Clientes receptor = new Clientes();
        armarFactura(factura);
        armarConcepto(concepto);
        armarEmisor(emisor);
        armarReceptor(receptor);
        factura.setEmisor(emisor);
        factura.setReceptor(receptor);
        conceptos.add(concepto);
        factura.setConceptosFacturas(conceptos);
        FacturasUtility.getFacturaConSelloPP(factura);
    }

    private void armarFactura(Facturas factura) throws Exception {
        factura.setSerie(ParametrosGeneralesUtility.getValor("FA019"));
        factura.setFolio(facturasDao.getNextFolioNC());
        factura.setVersion("3.3");
        factura.setEstatus("ACTIVO");
        factura.setFecha(new Date());
        factura.setNoSeieCertEmisor(ParametrosGeneralesUtility.getValor("FA013"));
        factura.setCertificado(ParametrosGeneralesUtility.getValor("FA015"));
        factura.setSubtotal(notaNueva.getCantidad());
        factura.setIva(BigDecimal.ZERO);
        factura.setTotal(notaNueva.getCantidad());
        factura.setImporteLetra(FacturasUtility.Convertir(factura.getTotal().toString(), true));
        factura.setUsoCFDI("G02");
        factura.setNotasDeVenta(facturaSeleccionada.getNotasDeVenta());
        factura.setMoneda("MXN");
        factura.setTipoDocumento("E");
        factura.setLugar(ParametrosGeneralesUtility.getValor("FA020"));
        CFDIRelacionados relacionados = new CFDIRelacionados();
        relacionados.setTipoRelacion("03");
        CFDIRelacionado relacionado = new CFDIRelacionado();
        relacionado.setUuid(facturaSeleccionada.getFolioFiscal());
        relacionados.getCdiRelacionado().add(relacionado);
        factura.setCfdiRelacionados(relacionados);

    }

    private void armarEmisor(Clientes emisor) throws Exception {
        emisor.setRfc(ParametrosGeneralesUtility.getValor("FA016"));
        emisor.setRazonSocial(ParametrosGeneralesUtility.getValor("FA017"));
        emisor.setRegimenFiscal(ParametrosGeneralesUtility.getValor("FA018"));

    }

    private void armarReceptor(Clientes receptor) {
        receptor.setRfc(facturaSeleccionada.getNotasDeVenta().getClientes().getRfc());
        receptor.setRazonSocial(facturaSeleccionada.getNotasDeVenta().getClientes().getRazonSocial());
        receptor.setUsoCFDI("G02");
        receptor.setCorreoElectronico(facturaSeleccionada.getNotasDeVenta().getClientes().getCorreoElectronico());
    }

    private void armarConcepto(ConceptosFactura concepto) {
        concepto.setClave(84111506);
        concepto.setCantidad(BigDecimal.ONE);
        concepto.setClaveUnidad("ACT");
        concepto.setUnidad("ACT");
        concepto.setDescripcion("Nota de Credito");
        concepto.setPrecioUnitario(notaNueva.getCantidad());
        concepto.setImporteTotal(notaNueva.getCantidad());
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

    public List<Facturas> getFacturasDisponibles() {
        return facturasDisponibles;
    }

    public void setFacturasDisponibles(List<Facturas> facturasDisponibles) {
        this.facturasDisponibles = facturasDisponibles;
    }

    public Facturas getFacturaSeleccionada() {
        return facturaSeleccionada;
    }

    public void setFacturaSeleccionada(Facturas facturaSeleccionada) {
        this.facturaSeleccionada = facturaSeleccionada;
    }

    public FacturasDAO getFacturasDao() {
        return facturasDao;
    }

    public void setFacturasDao(FacturasDAO facturasDao) {
        this.facturasDao = facturasDao;
    }

    public List<NotasDeVenta> getNotasDeVenta() {
        return notasDeVenta;
    }

    public void setNotasDeVenta(List<NotasDeVenta> notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }

    public NotasCredito getNotaNueva() {
        return notaNueva;
    }

    public void setNotaNueva(NotasCredito notaNueva) {
        this.notaNueva = notaNueva;
    }

    public ProductosInventario getProductoSeleccionado() {
        return productoSeleccionado;
    }

    public void setProductoSeleccionado(ProductosInventario productoSeleccionado) {
        this.productoSeleccionado = productoSeleccionado;
    }

    public NotasDeVenta getNotaSeleccionada() {
        return notaSeleccionada;
    }

    public void setNotaSeleccionada(NotasDeVenta notaSeleccionada) {
        this.notaSeleccionada = notaSeleccionada;
    }

    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }

    public void setParametrosGeneralesDAO(ParametrosGeneralesDAO parametrosGeneralesDAO) {
        this.parametrosGeneralesDAO = parametrosGeneralesDAO;
    }

}
