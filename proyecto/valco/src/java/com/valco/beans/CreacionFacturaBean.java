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
import com.valco.pojo.Facturas;
import com.valco.pojo.Impuestos;
import com.valco.pojo.NotasDeVenta;
import com.valco.utility.ClientesUtility;
import com.valco.utility.FacturasUtility;
import com.valco.utility.Mail;
import com.valco.utility.MsgUtility;
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
    private String metodoPago;
    private String observaciones;
    private Set<Impuestos> impuestosDisponibles;
    private Set<Impuestos> impuestosSeleccionados;

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

    public void facturarPublicoEnGeneral() throws Exception {
        Set<Impuestos> impuestos = new HashSet<Impuestos>();
        NotasDeVenta nota = buildNotaPublicoEnGeneral();
        if (nota == null) {
            throw new Exception("Ocurrió un problema al facturar al publico en general.");
        }
        Impuestos impuesto = new Impuestos();
        impuesto.setImpuesto("IVA");
        impuesto.setTasa(new BigDecimal(16.00).setScale(2, RoundingMode.HALF_EVEN));
        impuesto.setImporte(new BigDecimal("0.160000").setScale(6, RoundingMode.HALF_EVEN));
        impuestos.add(impuesto);
        Facturas factura = new Facturas();
        factura.setFecha(new Date());
        factura.setEstatus("ACTIVO");
        factura.setSerie("A");
        factura.setFormaPago(metodoPago);
        factura.setMetodoPago("EFECTIVO");
        factura.setImpuestoses(impuestos);
        factura.setObservaciones(observaciones);
        factura.setSubtotal(nota.getTotal());
        FacturasUtility.calculaTotalImpuestos(impuesto, nota);
        factura.setIva(impuesto.getImporte());
        factura.setTotal(factura.getSubtotal().add(FacturasUtility.getTotalImpuestos(impuestos)).setScale(2, RoundingMode.HALF_EVEN));
        factura.setImporteLetra(FacturasUtility.Convertir(factura.getTotal().toString(), true));
        factura.setXml(metodoPago);
        factura.setLugar("CHIHUAHUA,CHIHUAHUA,MEXICO");
        factura.setMoneda("MXN");
        factura.setBanco("Santander");
        factura.setCondicionPago("contado");
        factura.setNoSeieCertEmisor("00001000000405339543");
        factura.setFolio(1);
        factura.setNotasDeVenta(nota);
        factura.setTipoDocumento("ingreso");
        factura.setConceptosFacturas(FacturasUtility.convierteProductosAConceptos(nota.getProductosInventarios().iterator()));
        String correoCopia = "info.valco.sistemas@hotmail.com";
        try {
            correoCopia = parametrosGeneralesDAO.getParametroGeneralXClave("FA001");
        } catch (Exception ex) {
            correoCopia = "info.valco.sistemas@hotmail.com";
        }
        String xml = null;
        try {
            factura.setCodigo(facturasDao.getConsecutivo());
            xml = FacturasUtility.facturar(factura, factura.getCodigo());
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Facturada correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());

        }
        try {
            FacturasUtility.agregarDatosDeTimbrado(factura, xml);
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Datos de timbrado obtenidos correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        try {
            nota.setFolio(factura.getCodigo());
            nota.setRepartidores(repartidoresDao.getRepartidores().get(0));
            nota.setUsuarios(UsuariosUtility.getUsuarioFirmado());
            facturasDao.insertarFacturaYActualizarNota(factura);
            notasDeVentaDao.actualizarNotasDeVentaEstatusFacturada(notasDeVenta.getTarget());
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Guardada correctamente en el sistema.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        try {
            FacturasUtility.guardaXml(nota.getClientes().getRfc() + "-" + factura.getCodigo() + ".xml", xml, "C:/SAT/", factura.getCodigo());
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": XML guardado correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        try {
            FacturasUtility.guardaPdf(factura.getCodigo(), nota.getClientes().getRfc() + "-" + factura.getCodigo() + ".pdf", "C:/SAT/");
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": PDF guardado correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        try {
            Mail.Send(nota.getClientes().getCorreoElectronico(), correoCopia, "Factura de valco", "Esta es una factura de valco", "C:\\SAT\\" + nota.getClientes().getRfc() + "-" + factura.getCodigo());
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Correo enviado correctamente.");
        } catch (MessagingException ex) {
            MsgUtility.showErrorMeage("Ocurrio un error al enviar el correo" + ex.getMessage()+ ex.getCause());
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
            Set<Impuestos> impuestos = new HashSet<>();
            Impuestos impuesto = new Impuestos();
            impuesto.setImpuesto("IVA");
            impuesto.setTasa(new BigDecimal(16.00).setScale(2, RoundingMode.HALF_EVEN));
            impuesto.setImporte(new BigDecimal("0.160000").setScale(6, RoundingMode.HALF_EVEN));
            impuestos.add(impuesto);
            for (NotasDeVenta nota : notasDeVenta.getTarget()) {
                Facturas factura = new Facturas();
                factura.setFecha(new Date());
                factura.setEstatus("ACTIVO");
                factura.setSerie("A");
                factura.setFormaPago(metodoPago);
                factura.setMetodoPago("EFECTIVO");
                factura.setImpuestoses(impuestos);
                factura.setObservaciones(observaciones);
                factura.setSubtotal(nota.getTotal());
                FacturasUtility.calculaTotalImpuestos(impuesto, nota);
                factura.setIva(impuesto.getImporte());
                factura.setTotal(factura.getSubtotal().add(FacturasUtility.getTotalImpuestos(impuestos)).setScale(2, RoundingMode.HALF_EVEN));
                factura.setImporteLetra(FacturasUtility.Convertir(factura.getTotal().toString(), true));
                factura.setXml(metodoPago);
                factura.setLugar("CHIHUAHUA,CHIHUAHUA,MEXICO");
                factura.setMoneda("MXN");
                factura.setBanco("Santander");
                factura.setCondicionPago("contado");
                factura.setNoSeieCertEmisor("00001000000405339543");
                factura.setFolio(1);
                nota.setFacturas(factura);
                nota.setEstatus("FACTURADA");
                factura.setNotasDeVenta(nota);
                factura.setConceptosFacturas(FacturasUtility.convierteProductosAConceptos(nota.getProductosInventarios().iterator()));
                String correoCopia = "info.valco.sistemas@hotmail.com";
                try {
                    correoCopia = parametrosGeneralesDAO.getParametroGeneralXClave("FA001");
                } catch (Exception ex) {
                    correoCopia = "info.valco.sistemas@hotmail.com";
                }
                String xml = null;
                try {
                    factura.setCodigo(facturasDao.getConsecutivo());
                    xml = FacturasUtility.facturar(factura, factura.getCodigo());
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Facturada correctamente.");
                } catch (Exception ex) {
                    MsgUtility.showErrorMeage(ex.getMessage());
                    continue;
                }
                try {
                    FacturasUtility.agregarDatosDeTimbrado(factura, xml);
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Datos de timbrado obtenidos correctamente.");
                } catch (Exception ex) {
                    MsgUtility.showErrorMeage(ex.getMessage());
                }
                try {
                    facturasDao.insertarFacturaYActualizarNota(factura);
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Guardada correctamente en el sistema.");
                } catch (Exception ex) {
                    MsgUtility.showErrorMeage(ex.getMessage());
                }
                try {
                    FacturasUtility.guardaXml(nota.getClientes().getRfc() + "-" + factura.getCodigo() + ".xml", xml, "C:/SAT/", factura.getCodigo());
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": XML guardado correctamente.");
                } catch (Exception ex) {
                    MsgUtility.showErrorMeage(ex.getMessage());
                }
                try {
                    FacturasUtility.guardaPdf(factura.getCodigo(), factura.getNotasDeVenta().getClientes().getRfc() + "-" + factura.getCodigo() + ".pdf", "C:/SAT/");
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": PDF guardado correctamente.");
                } catch (Exception ex) {
                    MsgUtility.showErrorMeage(ex.getMessage());
                }
                try {
                    Mail.Send(nota.getClientes().getCorreoElectronico(), correoCopia, "Factura de valco", "Esta es una factura de valco", "C:\\SAT\\" + factura.getNotasDeVenta().getClientes().getRfc() + "-" + factura.getCodigo());
                    MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Correo enviado correctamente.");
                } catch (MessagingException ex) {
                    MsgUtility.showErrorMeage(ex.getMessage());
                }
            }
        }
        notasDeVenta.getTarget().clear();

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

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
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

}
