/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.sun.xml.rpc.processor.modeler.j2ee.xml.string;
import com.valco.dao.ClienteDAO;
import com.valco.dao.FacturasDAO;
import com.valco.dao.NotasVentaDAO;
import com.valco.dao.ParametrosGeneralesDAO;
import com.valco.dao.RepartidoresDAO;
import com.valco.pojo.Clientes;
import com.valco.pojo.ConceptosFactura;
import com.valco.pojo.Facturas;
import com.valco.pojo.FormaPago;
import com.valco.pojo.Impuesto;
import com.valco.pojo.Impuestos;
import com.valco.pojo.MetodosPago;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.UsoCFDI;
import com.valco.utility.ClientesUtility;
import com.valco.utility.FacturasUtility;
import com.valco.utility.Mail;
import com.valco.utility.MsgUtility;
import com.valco.utility.ParametrosGeneralesUtility;
import com.valco.utility.UsuariosUtility;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.mail.MessagingException;
import javax.xml.parsers.ParserConfigurationException;
import org.primefaces.context.RequestContext;
import org.primefaces.model.DualListModel;
import org.xml.sax.SAXException;

/**
 *
 * @author Administrador
 */
@ManagedBean
@ViewScoped
public class CreacionFacturaBean {

    @ManagedProperty(value = "#{notadeVentaDao}")
    private NotasVentaDAO notasDeVentaDao;
    @ManagedProperty(value = "#{clienteDao}")
    private ClienteDAO clienteDao;
    @ManagedProperty(value = "#{facturasDao}")
    private FacturasDAO facturasDao;
    @ManagedProperty(value = "#{parametrosGeneralesDAO}")
    private ParametrosGeneralesDAO parametrosGeneralesDAO;
    @ManagedProperty(value = "#{repartidoresDao}")
    private RepartidoresDAO repartidoresDao;
    private DualListModel<NotasDeVenta> notasDeVenta;
    private List<Clientes> clientes;
    private Clientes clienteSeleccionado;
    private Double iva;
    private String observaciones;
    private Set<Impuestos> impuestosDisponibles;
    private Set<Impuestos> impuestosSeleccionados;
    private MetodosPago metodoPago;
    private FormaPago formaPago;
    private UsoCFDI usoCFDI;

    /**
     * Creates a new instance of CreacionFacturaBean
     */
    public CreacionFacturaBean() {
    }

    @PostConstruct
    public void inicializar() {
        try {
            impuestosDisponibles = new HashSet();
            Impuestos impuesto = new Impuestos();
            impuesto.setImpuesto("IVA");
            impuesto.setTasa(new BigDecimal(16.00).setScale(2, RoundingMode.HALF_EVEN));
            impuesto.setImporte(new BigDecimal("0.160000").setScale(6, RoundingMode.HALF_EVEN));
            impuestosDisponibles.add(impuesto);
            notasDeVenta = new DualListModel();
            clientes = clienteDao.getClientes();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void consultarNotasXCliente() {
        try {
            List<NotasDeVenta> notasDisponibles = new ArrayList<>();
            if (ClientesUtility.isPublicoEnGeneral(clienteSeleccionado)) {
                notasDisponibles = notasDeVentaDao.getNotasDeVentaVendidas();
            } else {
                notasDisponibles = notasDeVentaDao.getNotasDeVentaXClienteVendidas(clienteSeleccionado);
            }

            List<NotasDeVenta> notasSeleccionadas = new ArrayList<>();
            notasDeVenta.setSource(notasDisponibles);
            notasDeVenta.setTarget(notasSeleccionadas);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public NotasDeVenta buildNotaPublicoEnGeneral() {
        NotasDeVenta notaPublicoEnGeneral = new NotasDeVenta();
        try {
            notaPublicoEnGeneral.setClientes(clienteDao.getPublicoEnGeneral());
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            return null;
        }
        for (NotasDeVenta nota : notasDeVenta.getTarget()) {
            notaPublicoEnGeneral.setTotal(nota.getTotal().add(notaPublicoEnGeneral.getTotal()));
            notaPublicoEnGeneral.getProductosInventarios().addAll(nota.getProductosInventarios());
        }

        return notaPublicoEnGeneral;
    }

    public void facturarPublicoEnGeneral() {
        String correoCopia = "info.valco.sistemas@hotmail.com";
        NotasDeVenta nota = buildNotaPublicoEnGeneral();
        if (nota == null) {
            MsgUtility.showErrorMeage("Ocurrió un problema al facturar al publico en general.");
        }

        Facturas factura = new Facturas();
        try {
            armarDocumento(factura, nota);

            nota.setFolio(facturasDao.getConsecutivo());
            nota.setRepartidores(repartidoresDao.getRepartidores().get(0));
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrió un error al armar el documento");
        }
        nota.setUsuarios(UsuariosUtility.getUsuarioFirmado());
        for (NotasDeVenta notaVenta : notasDeVenta.getTarget()) {
            notaVenta.setFacturas(factura);
            notaVenta.setEstatus("FACTURADA");
        }
        try {
            correoCopia = parametrosGeneralesDAO.getParametroGeneralXClave("FA001");
        } catch (Exception ex) {
            correoCopia = "info.valco.sistemas@hotmail.com";
        }
        try {
            FacturasUtility.facturarPago(factura, factura.getXml(), "01");
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Facturada correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());

        }
        try {
            facturasDao.insertarFacturaYActualizarNota(factura);
            notasDeVentaDao.actualizarNotasDeVenta(notasDeVenta.getTarget());
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Guardada correctamente en el sistema.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        try {
            FacturasUtility.guardaXml(nota.getClientes().getRfc() + "-" + factura.getCodigo() + ".xml", factura.getXml(), "C:/SAT/", factura.getCodigo());
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": XML guardado correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        try {
            FacturasUtility.guardaPdf(factura.getCodigo(), nota.getClientes().getRfc() + "-" + factura.getCodigo() + ".pdf", "C:/SAT/", "FacturaNuevo.jrxml");
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": PDF guardado correctamente.");
            String url = "/valco/ReportesPdf?reporte="
                    + "//pagina//reportes//ventasconfactura//FacturaNuevo.jrxml"
                    + "&FacturaIdInt=" + factura.getCodigo().toString()
                    + "&isCopiaBool=false";
            RequestContext.getCurrentInstance().execute("window.open('" + url + "');");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        try {
            Mail.Send(nota.getClientes().getCorreoElectronico(), correoCopia, "Factura de valco", "Esta es una factura de valco", "C:\\SAT\\", nota.getClientes().getRfc() + "-" + factura.getCodigo());
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Correo enviado correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Ocurrio un error al enviar el correo" + ex.getMessage() + ex.getCause());
        }
        notasDeVenta.getTarget().clear();

    }

    public void facturar() {
        if (notasDeVenta.getTarget().isEmpty()) {
            MsgUtility.showInfoMeage("Debe de seleccionar una nota de venta para facturar.");
            return;
        }
        if (ClientesUtility.isPublicoEnGeneral(clienteSeleccionado)) {
            try {
                facturarPublicoEnGeneral();
            } catch (Exception ex) {
                MsgUtility.showErrorMeage(ex.getMessage());
            }
        } else {
            for (NotasDeVenta nota : notasDeVenta.getTarget()) {
                Facturas factura = new Facturas();
                String correoCopia = "info.valco.sistemas@hotmail.com";
                try {
                    armarDocumento(factura, nota);
                } catch (Exception ex) {
                    MsgUtility.showErrorMessage("ERROR", "Ocurrió un error al armar el documetno");
                }
                nota.setEstatus("FACTURADA");
                try {
                    correoCopia = parametrosGeneralesDAO.getParametroGeneralXClave("FA001");
                } catch (Exception ex) {
                    correoCopia = "info.valco.sistemas@hotmail.com";
                }
                try {
                    FacturasUtility.facturarPago(factura, factura.getXml(), "01");
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Facturada correctamente.");
                } catch (Exception ex) {
                    MsgUtility.showErrorMeage(ex.getMessage());
                    ex.printStackTrace();
                    continue;
                }
                try {
                    facturasDao.insertarFacturaYActualizarNota(factura);
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Guardada correctamente en el sistema.");
                } catch (Exception ex) {
                    MsgUtility.showErrorMeage(ex.getMessage());
                }
                try {
                    FacturasUtility.guardaXml(nota.getClientes().getRfc() + "-" + factura.getCodigo() + ".xml", factura.getXml(), "C:/SAT/", factura.getCodigo());
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": XML guardado correctamente.");
                } catch (Exception ex) {
                    MsgUtility.showErrorMeage(ex.getMessage());
                }
                try {
                    FacturasUtility.guardaPdf(factura.getCodigo(), factura.getNotasDeVenta().getClientes().getRfc() + "-" + factura.getCodigo() + ".pdf", "C:/SAT/", "FacturaNuevo.jrxml");
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": PDF guardado correctamente.");
                    String url = "/valco/ReportesPdf?reporte="
                            + "//pagina//reportes//ventasconfactura//FacturaNuevo.jrxml"
                            + "&FacturaIdInt=" + factura.getCodigo().toString()
                            + "&isCopiaBool=false";
                    RequestContext.getCurrentInstance().execute("window.open('" + url + "');");
                } catch (Exception ex) {
                    MsgUtility.showErrorMeage(ex.getMessage());
                }
                try {
                    Mail.Send(nota.getClientes().getCorreoElectronico(), correoCopia, "Factura de valco", "Esta es una factura de valco", "C:\\SAT\\", factura.getNotasDeVenta().getClientes().getRfc() + "-" + factura.getCodigo());
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Correo enviado correctamente.");
                } catch (Exception ex) {
                    MsgUtility.showErrorMeage("Ocurrio un error al enviar el correo" + ex.getMessage() + ex.getCause());
                }
            }
        }
        notasDeVenta.getTarget().clear();

    }

    private void armarDocumento(Facturas factura, NotasDeVenta nota) throws Exception {
        Set<Impuestos> impuestos = new HashSet<Impuestos>();
        Impuestos impuesto = new Impuestos();
        impuesto.setImpuesto("IVA");
        impuesto.setTasa(new BigDecimal(16.00).setScale(2, RoundingMode.HALF_EVEN));
        impuesto.setImporte(new BigDecimal("0.160000").setScale(6, RoundingMode.HALF_EVEN));
        impuestos.add(impuesto);
        Impuesto totalImpuestos = new Impuesto();
        factura.setFecha(new Date());
        factura.setVersion("3.3");
        factura.setEstatus("ACTIVO");
        factura.setSerie("A");
        factura.setFormaPago(formaPago.getCodigo());
        factura.setMetodoPago(metodoPago.getCodigoSat());
        factura.setImpuestoses(impuestos);
        factura.setObservaciones(observaciones);
        factura.setSubtotal(nota.getTotal().setScale(2, RoundingMode.HALF_EVEN));
        FacturasUtility.calculaTotalImpuestos(impuesto, nota);
        factura.setIva(impuesto.getImporte());
        factura.setTotal(factura.getSubtotal().add(FacturasUtility.getTotalImpuestos(impuestos)).setScale(2, RoundingMode.HALF_EVEN));
        factura.setImporteLetra(FacturasUtility.Convertir(factura.getTotal().toString(), true));
        factura.setLugar("31110");
        factura.setMoneda("MXN");
        factura.setBanco("Santander");
        factura.setCondicionPago("contado");
        factura.setNoSeieCertEmisor(ParametrosGeneralesUtility.getValor("FA013"));
        factura.setCertificado(ParametrosGeneralesUtility.getValor("FA015"));
        factura.setFolio(1);
        factura.setNotasDeVenta(nota);
        factura.setNoCliente(nota.getClientes().getCodigo());
        nota.setFacturas(factura);
        factura.setTipoDocumento("I");
        factura.setConceptosFacturas(FacturasUtility.convierteProductosAConceptos(nota.getProductosInventarios().iterator()));
        armarTotalImpuestos(totalImpuestos, factura.getConceptosFacturas());
        if (totalImpuestos.getTotalImpuestosTrasladados().compareTo(BigDecimal.ZERO) != 0) {
            factura.setImpuesto(totalImpuestos);
        }
        Clientes emisor = new Clientes();
        armarEmisor(emisor);
        Clientes receptor = new Clientes();
        armarReceptor(receptor, nota);
        receptor.setUsoCFDI(usoCFDI.getCodigo());
        factura.setUsoCFDI(usoCFDI.getCodigo());
        factura.setEmisor(emisor);
        factura.setReceptor(receptor);
        FacturasUtility.getFacturaConSelloPP(factura);
    }

    private void armarEmisor(Clientes emisor) throws Exception {
        emisor.setRfc(ParametrosGeneralesUtility.getValor("FA016"));
        emisor.setRazonSocial(ParametrosGeneralesUtility.getValor("FA017"));
        emisor.setRegimenFiscal(ParametrosGeneralesUtility.getValor("FA018"));

    }

    private void armarReceptor(Clientes receptor, NotasDeVenta nota) {
        receptor.setRfc(nota.getClientes().getRfc());
        receptor.setRazonSocial(nota.getClientes().getRazonSocial());
        receptor.setUsoCFDI(nota.getClientes().getUsoCFDI());
    }

    private void armarTotalImpuestos(Impuesto total, Set<ConceptosFactura> conceptos) {
        List<Impuestos> impuestos = new ArrayList<>();
        Impuestos iva = new Impuestos();
        iva.setImpuesto("002");
        iva.setImporte(BigDecimal.ZERO);
        iva.setTipoFactor("Tasa");
        iva.setTasa(new BigDecimal(.16).setScale(6, RoundingMode.HALF_EVEN));
        for (ConceptosFactura concepto : conceptos) {
            if (concepto.getImpuesto() != null) {
                for (Impuestos imp : concepto.getImpuesto().getImpuestos()) {
                    if (imp.getImpuesto().equals("002")) {
                        iva.setImporte(iva.getImporte().add(imp.getImporte()));
                    }
                }
            }

        }
        total.setTotalImpuestosTrasladados(iva.getImporte());
        impuestos.add(iva);
        total.setImpuestos(impuestos);
    }

    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }

    public ClienteDAO getClienteDao() {
        return clienteDao;
    }

    public void setClienteDao(ClienteDAO clienteDao) {
        this.clienteDao = clienteDao;
    }

    public DualListModel<NotasDeVenta> getNotasDeVenta() {
        return notasDeVenta;
    }

    public void setNotasDeVenta(DualListModel<NotasDeVenta> notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }

    public List<Clientes> getClientes() {
        return clientes;
    }

    public void setClientes(List<Clientes> clientes) {
        this.clientes = clientes;
    }

    public Clientes getClienteSeleccionado() {
        return clienteSeleccionado;
    }

    public void setClienteSeleccionado(Clientes clienteSeleccionado) {
        this.clienteSeleccionado = clienteSeleccionado;
    }

    public Double getIva() {
        return iva;
    }

    public void setIva(Double iva) {
        this.iva = iva;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public FacturasDAO getFacturasDao() {
        return facturasDao;
    }

    public void setFacturasDao(FacturasDAO facturasDao) {
        this.facturasDao = facturasDao;
    }

    public Set<Impuestos> getImpuestosDisponibles() {
        return impuestosDisponibles;
    }

    public void setImpuestosDisponibles(Set<Impuestos> impuestosDisponibles) {
        this.impuestosDisponibles = impuestosDisponibles;
    }

    public Set<Impuestos> getImpuestosSeleccionados() {
        return impuestosSeleccionados;
    }

    public void setImpuestosSeleccionados(Set<Impuestos> impuestosSeleccionados) {
        this.impuestosSeleccionados = impuestosSeleccionados;
    }

    public ParametrosGeneralesDAO getParametrosGeneralesDAO() {
        return parametrosGeneralesDAO;
    }

    public void setParametrosGeneralesDAO(ParametrosGeneralesDAO parametrosGeneralesDAO) {
        this.parametrosGeneralesDAO = parametrosGeneralesDAO;
    }

    public RepartidoresDAO getRepartidoresDao() {
        return repartidoresDao;
    }

    public void setRepartidoresDao(RepartidoresDAO repartidoresDao) {
        this.repartidoresDao = repartidoresDao;
    }

    public MetodosPago getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(MetodosPago metodoPago) {
        this.metodoPago = metodoPago;
    }

    public FormaPago getFormaPago() {
        return formaPago;
    }

    public void setFormaPago(FormaPago formaPago) {
        this.formaPago = formaPago;
    }

    public UsoCFDI getUsoCFDI() {
        return usoCFDI;
    }

    public void setUsoCFDI(UsoCFDI usoCFDI) {
        this.usoCFDI = usoCFDI;
    }

}
