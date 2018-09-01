/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.sun.xml.bind.marshaller.NamespacePrefixMapper;
import com.valco.dao.ClienteDAO;
import com.valco.pojo.Clientes;
import com.valco.dao.AbonosCuentasXCobrarDAO;
import com.valco.dao.CuentasContablesDAO;
import com.valco.dao.FacturasDAO;
import com.valco.dao.NotasVentaDAO;
import com.valco.pojo.AbonosCuentasXCobrar;
import com.valco.pojo.Complemento;
import com.valco.pojo.ConceptosFactura;
import com.valco.pojo.CuentasContables;
import com.valco.pojo.CuentasXCobrar;
import com.valco.pojo.DocRelacionado;
import com.valco.pojo.Facturas;
import com.valco.pojo.FormaPago;
import com.valco.pojo.NotasDeVentaView;
import com.valco.utility.DefaultNamespacePrefixMapper;
import com.valco.utility.FacturasUtility;
import com.valco.utility.Mail;
import com.valco.utility.MsgUtility;
import com.valco.utility.Pagos;
import com.valco.utility.ParametrosGeneralesUtility;
import java.awt.event.ActionEvent;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.component.html.HtmlSelectOneMenu;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.mail.MessagingException;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import org.primefaces.context.RequestContext;
import org.primefaces.event.SelectEvent;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class AbonosCuentasXCobrarMainBean {

    private Date date1;
    @ManagedProperty(value = "#{abonoscuentascobrarDAO}")
    private AbonosCuentasXCobrarDAO abonoscuentascobrarDAO;
    @ManagedProperty(value = "#{facturasDao}")
    private FacturasDAO facturasDao;
    @ManagedProperty(value = "#{clienteDao}")
    private ClienteDAO clienteDao;
    @ManagedProperty(value = "#{notadeVentaDao}")
    private NotasVentaDAO notasDeVentaDao;
    @ManagedProperty(value = "#{cuentascontablesDAO}")
    private CuentasContablesDAO cuentascontablesDAO;
    List<Clientes> clientes;
    List<NotasDeVentaView> notas;
    List<AbonosCuentasXCobrar> abonos;
    AbonosCuentasXCobrar abonoNuevo;
    AbonosCuentasXCobrar abonoSeleccionado;
    CuentasXCobrar cuentaSeleccionado;
    CuentasXCobrar cuentaNuevo;
    Clientes clienteSelecionado;
    NotasDeVentaView notaSeleccionado;
    HtmlSelectOneMenu ctaOrd;
    HtmlSelectOneMenu ctaBen;
    FormaPago formaPagoSeleccionado;
    CuentasContables cuentaOrdenante;
    CuentasContables cuentaBeneficiario;
    Boolean tipoCadenaPago;

    Date fecha;

    /**
     * Creates a new instance of CuentasXCobrarMainBean
     */
    public AbonosCuentasXCobrarMainBean() {

    }

    @PostConstruct
    public void init() {
        try {

            abonoNuevo = new AbonosCuentasXCobrar();
            abonoNuevo.setFecha(new Date());
            notas = new ArrayList<>();
            this.date1 = new Date();
            this.abonoSeleccionado = new AbonosCuentasXCobrar();
            this.clientes = clienteDao.getClientesConAdeudo();
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void obtenerNotas() {

        try {
            this.notas = notasDeVentaDao.getNotasDeVentaViewXCliente(clienteSelecionado);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void obtenerAbonos() {
        try {
            if (notaSeleccionado == null) {
                throw new Exception("Debe seleccionar una nota para cancelar abonos");
            }
            this.abonos = this.abonoscuentascobrarDAO.getAbonosXCuentasXCobrar(notaSeleccionado.getCuentaXCobrar());
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void validarAbonoSeleccionado(ActionEvent actionEvent) throws Exception {
        if (notaSeleccionado == null || notaSeleccionado.getCodigo() == 0) {
            MsgUtility.showErrorMessage("Error", "Debe seleccionar una nota");
            FacesContext.getCurrentInstance().validationFailed();
            return;
        }
        abonoNuevo.setFolio(abonoscuentascobrarDAO.getNextFolio());
        abonoNuevo.setSerie(ParametrosGeneralesUtility.getValor("FA014"));
    }

    public void insertarAbono() throws Exception {
        Facturas factura = new Facturas();
        try {
            if (notaSeleccionado == null) {
                throw new Exception("Debe Seleccionar una nota para realizar el abono");
            }
            if ((formaPagoSeleccionado.getTipoCadenaPago() && tipoCadenaPago)
                    && (abonoNuevo.getCertPago() == null || abonoNuevo.getCertPago().equals("")
                    || abonoNuevo.getSelloPago() == null || abonoNuevo.getSelloPago().equals("")
                    || abonoNuevo.getCadenaPago() == null || abonoNuevo.getCadenaPago().equals(""))) {
                MsgUtility.showErrorMessage("Datos Faltantes", "Debe capturar toda la información adicional de SPEI");
                FacesContext.getCurrentInstance().validationFailed();
                return;
            }
            if (tipoCadenaPago) {
                abonoNuevo.setTipoCadPago("01");
            } else {
                abonoNuevo.setTipoCadPago(null);
                abonoNuevo.setCadenaPago(null);
                abonoNuevo.setCertPago(null);
                abonoNuevo.setSelloPago(null);
            }
            if ("".equals(abonoNuevo.getNumOperacion().trim())) {
                abonoNuevo.setNumOperacion(null);
            }
            abonoNuevo.setEstatus("ACTIVO");
            abonoNuevo.setCuentasXCobrar(notaSeleccionado.getCuentaXCobrar());
            abonoNuevo.setMoneda("MXN");
            if (cuentaOrdenante != null && formaPagoSeleccionado.getBancarizado()) {
                abonoNuevo.setCtaOrdenante(cuentaOrdenante.getNoDeCuenta());
                abonoNuevo.setRfcCtaOrigen(cuentaOrdenante.getRfcBanco());
                abonoNuevo.setNombreBancoOrd(cuentaOrdenante.getDescripcion());
            }
            if (cuentaBeneficiario != null && formaPagoSeleccionado.getBancarizado()) {
                abonoNuevo.setCtaBen(cuentaBeneficiario.getNoDeCuenta());
                abonoNuevo.setRfcCtaBen(cuentaBeneficiario.getRfcBanco());
                abonoNuevo.setNombreBancoBen(cuentaBeneficiario.getDescripcion());
            }
            abonoNuevo.setImpSaldoAnt(notaSeleccionado.getCuentaXCobrar().getSaldoAnterior().toString());
            abonoNuevo.setImpSaldoInsoluto(notaSeleccionado.getCuentaXCobrar().getSaldoAnterior().subtract(abonoNuevo.getImporte()).toString());
            abonoNuevo.setNumParcialidad(String.valueOf(notaSeleccionado.getNumParcialidad() + 1));
            abonoNuevo.setFormaPago(formaPagoSeleccionado.getCodigo());
            if (notaSeleccionado.getFacturas() != null) {
                System.out.println(notaSeleccionado.getFacturas().getFolioFiscal());
                abonoNuevo.setIdDocRelacionado(notaSeleccionado.getFacturas().getFolioFiscal());
            }

            notaSeleccionado.setImporteAbonado(notaSeleccionado.getImporteAbonado().add(abonoNuevo.getImporte()));
            notaSeleccionado.setSaldoPendiente(notaSeleccionado.getImporte().subtract(notaSeleccionado.getImporteAbonado()));

            armarComprobanteDeRcepcionDePago(factura);
            FacturasUtility.facturarPago(factura, factura.getXml(), "07");
            abonoscuentascobrarDAO.insertarAbono(abonoNuevo);
            facturasDao.insertarFacturaYActualizarNota(factura);
            MsgUtility.showInfoMeage("Se realizó el abono correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            ex.printStackTrace();
        }
        String correoCopia = "info.valco.sistemas@hotmail.com";
        try {
            correoCopia = ParametrosGeneralesUtility.getValor("FA001");
        } catch (Exception ex) {
            correoCopia = "info.valco.sistemas@hotmail.com";
        }
        try {
            FacturasUtility.guardaXml(factura.getReceptor().getRfc() + "-" + factura.getCodigo() + ".xml", factura.getXml(), "C:/SAT/", factura.getCodigo());
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": XML guardado correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        try {
            FacturasUtility.guardaPdf(factura.getCodigo(), factura.getNotasDeVenta().getClientes().getRfc() + "-" + factura.getCodigo() + ".pdf", "C:/SAT/","RecepcionPago.jrxml");
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": PDF guardado correctamente.");
            String url = "/valco/ReportesPdf?reporte="
                    + "//pagina//reportes//ventasconfactura//RecepcionPago.jrxml"
                    + "&FacturaIdInt=" + factura.getCodigo().toString()
                    + "&isCopiaBool=false";
            RequestContext.getCurrentInstance().execute("window.open('" + url + "');");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        try {
            Mail.Send(notaSeleccionado.getClientes().getCorreoElectronico(), correoCopia, "Factura de valco", "Esta es una factura de valco", "C:\\SAT\\", factura.getNotasDeVenta().getClientes().getRfc() + "-" + factura.getCodigo());
            MsgUtility.showInfoMeage("Factura " + factura.getCodigo() + ": Correo enviado correctamente.");
        } catch (MessagingException ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        //cuentaSeleccionado.getAbonosCuentasXCobrars().add(abonoNuevo);
        AbonosCuentasXCobrar abono = new AbonosCuentasXCobrar();
        abono.setImporte(abonoNuevo.getImporte());
        //notaSeleccionado.getCuentaXCobrar().getAbonosCuentasXCobrars().add(abono);
        //notaSeleccionado.setImporteAbonado(notaSeleccionado.getImporteAbonado().add(abonoNuevo.getImporte()));
        formaPagoSeleccionado = new FormaPago();
        formaPagoSeleccionado.setCodigo("01");
        abonoNuevo = new AbonosCuentasXCobrar();
        abonoNuevo.setFecha(new Date());
        tipoCadenaPago = false;
    }

    public void actualizarAbono() {
        try {
            if (notaSeleccionado == null) {
                throw new Exception("Debe Seleccionar una nota para Cancelar el abono");
            } else if (abonoSeleccionado == null) {
                throw new Exception("Debe Seleccionar un abono para Cancelar");
            }
            abonoSeleccionado.setEstatus("CANCELADO");
            abonoscuentascobrarDAO.actualizarAbono(abonoSeleccionado);
            notaSeleccionado.setImporteAbonado(notaSeleccionado.getImporteAbonado().subtract(abonoSeleccionado.getImporte()));
            notaSeleccionado.setSaldoPendiente(notaSeleccionado.getImporte().subtract(notaSeleccionado.getImporteAbonado()));
            MsgUtility.showInfoMeage("Se canceló el abono correctamente.");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public List<CuentasContables> getCtasOrdenantes() {
        try {
            List<CuentasContables> cuentas = cuentascontablesDAO.getCuentasContables(clienteSelecionado.getCodigo());
            return cuentas;
        } catch (Exception ex) {
            Logger.getLogger(AbonosCuentasXCobrarMainBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

    public List<CuentasContables> getCtasBeneficiario() {
        try {
            List<CuentasContables> cuentas = cuentascontablesDAO.getCuentasBeneficiario();
            return cuentas;
        } catch (Exception ex) {
            Logger.getLogger(AbonosCuentasXCobrarMainBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

    public void onDateSelect(SelectEvent event) {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        facesContext.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Date Selected", format.format(event.getObject())));
    }

    public void click() {
        RequestContext requestContext = RequestContext.getCurrentInstance();

        requestContext.update("form:display");
        requestContext.execute("PF('dlg').show()");
    }

    private void armarComprobanteDeRcepcionDePago(Facturas factura) throws Exception {
        Complemento comp = new Complemento();
        List<AbonosCuentasXCobrar> pagos = new ArrayList<>();
        ConceptosFactura concepto = new ConceptosFactura();
        Set<ConceptosFactura> conceptos = new HashSet<>();
        DocRelacionado documento = new DocRelacionado();
        Clientes emisor = new Clientes();
        Clientes receptor = new Clientes();
        pagos.add(abonoNuevo);
        Pagos pago = new Pagos();
        pago.setVersion("1.0");
        pago.setPagos(pagos);
        comp.setPagos(pago);
        abonoNuevo.setDocRelacionado(documento);
        armarFactura(factura);
        armarConcepto(concepto);
        armarDocRelacionado(documento);
        armarEmisor(emisor);
        armarReceptor(receptor);
        factura.setComplemento(comp);
        factura.setEmisor(emisor);
        factura.setReceptor(receptor);
        conceptos.add(concepto);
        factura.setConceptosFacturas(conceptos);
        factura.setNotasDeVenta(notaSeleccionado.getNota());
        factura.setNoCliente(notaSeleccionado.getClientes().getCodigo());
        FacturasUtility.getFacturaConSelloPP(factura);
    }

    private void armarFactura(Facturas factura) throws Exception {
        factura.setSerie(abonoNuevo.getSerie());
        factura.setFolio(abonoNuevo.getFolio());
        factura.setVersion("3.3");
        factura.setEstatus("ACTIVO");
        factura.setFecha(new Date());
        factura.setNoSeieCertEmisor(ParametrosGeneralesUtility.getValor("FA013"));
        factura.setCertificado(ParametrosGeneralesUtility.getValor("FA015"));
        factura.setSubtotal(BigDecimal.ZERO);
        factura.setMoneda("XXX");
        factura.setTotal(BigDecimal.ZERO);
        factura.setTipoDocumento("P");
        factura.setLugar("31110");
    }

    private void armarEmisor(Clientes emisor) throws Exception {
        emisor.setRfc(ParametrosGeneralesUtility.getValor("FA016"));
        emisor.setRazonSocial(ParametrosGeneralesUtility.getValor("FA017"));
        emisor.setRegimenFiscal(ParametrosGeneralesUtility.getValor("FA018"));

    }

    private void armarReceptor(Clientes receptor) {
        receptor.setRfc(notaSeleccionado.getClientes().getRfc());
        receptor.setRazonSocial(notaSeleccionado.getClientes().getRazonSocial());
        receptor.setUsoCFDI("P01");
    }

    private void armarConcepto(ConceptosFactura concepto) {
        concepto.setClave(84111506);
        concepto.setCantidad(BigDecimal.ONE);
        concepto.setClaveUnidad("ACT");
        concepto.setDescripcion("Pago");
        concepto.setPrecioUnitario(BigDecimal.ZERO);
        concepto.setImporteTotal(BigDecimal.ZERO);
    }

    private void armarDocRelacionado(DocRelacionado documento) {
        documento.setIdDocumento(notaSeleccionado.getFacturas().getFolioFiscal());
        documento.setSerie(notaSeleccionado.getFacturas().getSerie());
        documento.setFolio(String.valueOf(notaSeleccionado.getFacturas().getFolio()));
        documento.setMoneda(notaSeleccionado.getFacturas().getMoneda());
        documento.setMetodoPago("PPD");
        documento.setNumParcialidad(Integer.parseInt(abonoNuevo.getNumParcialidad()));
        documento.setImpSaldoAnt(abonoNuevo.getImpSaldoAnt());
        documento.setImpPagado(abonoNuevo.getImporte());
        documento.setImpSaldoInsoluto(abonoNuevo.getImpSaldoInsoluto());
    }

    public CuentasXCobrar getCuentaSeleccionado() {
        return cuentaSeleccionado;
    }

    public void setCuentaSeleccionado(CuentasXCobrar cuentaSeleccionado) {
        this.cuentaSeleccionado = cuentaSeleccionado;
    }

    public CuentasXCobrar getCuentaNuevo() {
        return cuentaNuevo;
    }

    public void setCuentaNuevo(CuentasXCobrar cuentaNuevo) {
        this.cuentaNuevo = cuentaNuevo;
    }

    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }

    public Date getDate1() {
        return date1;
    }

    public void setDate1(Date date1) {
        this.date1 = date1;
    }

    public Clientes getClienteSelecionado() {
        return clienteSelecionado;
    }

    public void setClienteSelecionado(Clientes clienteSelecionado) {
        this.clienteSelecionado = clienteSelecionado;
    }

    public AbonosCuentasXCobrarDAO getAbonoscuentascobrarDAO() {
        return abonoscuentascobrarDAO;
    }

    public void setAbonoscuentascobrarDAO(AbonosCuentasXCobrarDAO abonoscuentascobrarDAO) {
        this.abonoscuentascobrarDAO = abonoscuentascobrarDAO;
    }

    public ClienteDAO getClienteDao() {
        return clienteDao;
    }

    public void setClienteDao(ClienteDAO clienteDao) {
        this.clienteDao = clienteDao;
    }

    public List<Clientes> getClientes() {
        return clientes;
    }

    public void setClientes(List<Clientes> clientes) {
        this.clientes = clientes;
    }

    public List<AbonosCuentasXCobrar> getAbonos() {
        return abonos;
    }

    public void setAbonos(List<AbonosCuentasXCobrar> abonos) {
        this.abonos = abonos;
    }

    public AbonosCuentasXCobrar getAbonoNuevo() {
        return abonoNuevo;
    }

    public void setAbonoNuevo(AbonosCuentasXCobrar abonoNuevo) {
        this.abonoNuevo = abonoNuevo;
    }

    public AbonosCuentasXCobrar getAbonoSeleccionado() {
        return abonoSeleccionado;
    }

    public void setAbonoSeleccionado(AbonosCuentasXCobrar abonoSeleccionado) {
        this.abonoSeleccionado = abonoSeleccionado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public List<NotasDeVentaView> getNotas() {
        return notas;
    }

    public void setNotas(List<NotasDeVentaView> notas) {
        this.notas = notas;
    }

    public NotasDeVentaView getNotaSeleccionado() {
        return notaSeleccionado;
    }

    public void setNotaSeleccionado(NotasDeVentaView notaSeleccionado) {
        this.notaSeleccionado = notaSeleccionado;
    }

    public CuentasContablesDAO getCuentascontablesDAO() {
        return cuentascontablesDAO;
    }

    public void setCuentascontablesDAO(CuentasContablesDAO cuentascontablesDAO) {
        this.cuentascontablesDAO = cuentascontablesDAO;
    }

    public HtmlSelectOneMenu getCtaOrd() {
        return ctaOrd;
    }

    public void setCtaOrd(HtmlSelectOneMenu ctaOrd) {
        this.ctaOrd = ctaOrd;
    }

    public FormaPago getFormaPagoSeleccionado() {
        return formaPagoSeleccionado;
    }

    public void setFormaPagoSeleccionado(FormaPago formaPagoSeleccionado) {
        this.formaPagoSeleccionado = formaPagoSeleccionado;
    }

    public HtmlSelectOneMenu getCtaBen() {
        return ctaBen;
    }

    public void setCtaBen(HtmlSelectOneMenu ctaBen) {
        this.ctaBen = ctaBen;
    }

    public CuentasContables getCuentaOrdenante() {
        return cuentaOrdenante;
    }

    public void setCuentaOrdenante(CuentasContables cuentaOrdenante) {
        this.cuentaOrdenante = cuentaOrdenante;
    }

    public CuentasContables getCuentaBeneficiario() {
        return cuentaBeneficiario;
    }

    public void setCuentaBeneficiario(CuentasContables cuentaBeneficiario) {
        this.cuentaBeneficiario = cuentaBeneficiario;
    }

    public Boolean getTipoCadenaPago() {
        return tipoCadenaPago;
    }

    public void setTipoCadenaPago(Boolean tipoCadenaPago) {
        this.tipoCadenaPago = tipoCadenaPago;
    }

    public FacturasDAO getFacturasDao() {
        return facturasDao;
    }

    public void setFacturasDao(FacturasDAO facturasDao) {
        this.facturasDao = facturasDao;
    }
}
