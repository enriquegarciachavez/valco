package com.valco.pojo;
// Generated 2/11/2014 06:06:42 PM by Hibernate Tools 4.3.1

import com.valco.utility.DateAdapter;
import java.math.BigDecimal;
import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

/**
 * AbonosCuentasXCobrar generated by hbm2java
 */
@XmlAccessorType(XmlAccessType.FIELD)
public class AbonosCuentasXCobrar implements java.io.Serializable {

    @XmlTransient
    private Integer codigo;
    @XmlTransient
    private CuentasXCobrar cuentasXCobrar;
    @XmlAttribute(name="FechaPago")
    @XmlJavaTypeAdapter(DateAdapter.class)
    private Date fecha;
    @XmlAttribute(name="Monto")
    private BigDecimal importe;
    @XmlTransient
    private String observaciones;
    @XmlTransient
    private String estatus;
    @XmlAttribute(name="FormaDePagoP")
    private String formaPago;
    @XmlAttribute(name="MonedaP")
    private String moneda;
    @XmlAttribute(name="NumOperacion")
    private String numOperacion;
    @XmlAttribute(name="RfcEmisorCtaOrd")
    private String rfcCtaOrigen;
    @XmlAttribute(name="CtaOrdenante")
    private String ctaOrdenante;
    @XmlAttribute(name="RfcEmisorCtaBen")
    private String rfcCtaBen;
    @XmlAttribute(name="CtaBeneficiario")
    private String ctaBen;
    @XmlAttribute(name="TipoCadPago")
    private String tipoCadPago;
    @XmlAttribute(name="CertPago")
    private String certPago;
    @XmlAttribute(name="CadPago")
    private String cadenaPago;
    @XmlAttribute(name="SelloPago")
    private String selloPago;
    @XmlTransient
    private String numParcialidad;
    @XmlTransient
    private String impSaldoAnt;
    @XmlTransient
    private String impSaldoInsoluto;
    @XmlAttribute(name="NomBancoOrdExt")
    private String nombreBancoOrd;
    @XmlTransient
    private String nombreBancoBen;
    @XmlTransient
    private String idDocRelacionado;
    @XmlTransient
    private String serie;
    @XmlTransient
    private Integer folio;
    @XmlElement(namespace = "http://www.sat.gob.mx/Pagos", name="DoctoRelacionado")
    private DocRelacionado docRelacionado;

    public AbonosCuentasXCobrar() {
    }

    public AbonosCuentasXCobrar(CuentasXCobrar cuentasXCobrar, Date fecha, String estatus) {
        this.cuentasXCobrar = cuentasXCobrar;
        this.fecha = fecha;
        this.estatus = estatus;
    }

    public AbonosCuentasXCobrar(CuentasXCobrar cuentasXCobrar, Date fecha, BigDecimal importe, String observaciones, String estatus) {
        this.cuentasXCobrar = cuentasXCobrar;
        this.fecha = fecha;
        this.importe = importe;
        this.observaciones = observaciones;
        this.estatus = estatus;
    }

    public Integer getCodigo() {
        return this.codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public CuentasXCobrar getCuentasXCobrar() {
        return this.cuentasXCobrar;
    }

    public void setCuentasXCobrar(CuentasXCobrar cuentasXCobrar) {
        this.cuentasXCobrar = cuentasXCobrar;
    }

    public Date getFecha() {
        return this.fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public BigDecimal getImporte() {
        return this.importe;
    }

    public void setImporte(BigDecimal importe) {
        this.importe = importe;
    }

    public String getObservaciones() {
        return this.observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getEstatus() {
        return this.estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public String getFormaPago() {
        return formaPago;
    }

    public void setFormaPago(String formaPago) {
        this.formaPago = formaPago;
    }

    public String getMoneda() {
        return moneda;
    }

    public void setMoneda(String moneda) {
        this.moneda = moneda;
    }

    public String getNumOperacion() {
        return numOperacion;
    }

    public void setNumOperacion(String numOperacion) {
        this.numOperacion = numOperacion;
    }

    public String getRfcCtaOrigen() {
        return rfcCtaOrigen;
    }

    public void setRfcCtaOrigen(String rfcCtaOrigen) {
        this.rfcCtaOrigen = rfcCtaOrigen;
    }

    public String getCtaOrdenante() {
        return ctaOrdenante;
    }

    public void setCtaOrdenante(String ctaOrdenante) {
        this.ctaOrdenante = ctaOrdenante;
    }

    public String getRfcCtaBen() {
        return rfcCtaBen;
    }

    public void setRfcCtaBen(String rfcCtaBen) {
        this.rfcCtaBen = rfcCtaBen;
    }

    public String getCtaBen() {
        return ctaBen;
    }

    public void setCtaBen(String ctaBen) {
        this.ctaBen = ctaBen;
    }

    public String getTipoCadPago() {
        return tipoCadPago;
    }

    public void setTipoCadPago(String tipoCadPago) {
        this.tipoCadPago = tipoCadPago;
    }

    public String getCertPago() {
        return certPago;
    }

    public void setCertPago(String certPago) {
        this.certPago = certPago;
    }

    public String getCadenaPago() {
        return cadenaPago;
    }

    public void setCadenaPago(String cadenaPago) {
        this.cadenaPago = cadenaPago;
    }

    public String getSelloPago() {
        return selloPago;
    }

    public void setSelloPago(String selloPago) {
        this.selloPago = selloPago;
    }

    public String getNumParcialidad() {
        return numParcialidad;
    }

    public void setNumParcialidad(String numParcialidad) {
        this.numParcialidad = numParcialidad;
    }

    public String getImpSaldoAnt() {
        return impSaldoAnt;
    }

    public void setImpSaldoAnt(String impSaldoAnt) {
        this.impSaldoAnt = impSaldoAnt;
    }

    public String getImpSaldoInsoluto() {
        return impSaldoInsoluto;
    }

    public void setImpSaldoInsoluto(String impSaldoInsoluto) {
        this.impSaldoInsoluto = impSaldoInsoluto;
    }

    public String getNombreBancoOrd() {
        return nombreBancoOrd;
    }

    public void setNombreBancoOrd(String nombreBancoOrd) {
        this.nombreBancoOrd = nombreBancoOrd;
    }

    public String getNombreBancoBen() {
        return nombreBancoBen;
    }

    public void setNombreBancoBen(String nombreBancoBen) {
        this.nombreBancoBen = nombreBancoBen;
    }

    public String getIdDocRelacionado() {
        return idDocRelacionado;
    }

    public void setIdDocRelacionado(String idDocRelacionado) {
        this.idDocRelacionado = idDocRelacionado;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public Integer getFolio() {
        return folio;
    }

    public void setFolio(Integer folio) {
        this.folio = folio;
    }

    public DocRelacionado getDocRelacionado() {
        return docRelacionado;
    }

    public void setDocRelacionado(DocRelacionado docRelacionado) {
        this.docRelacionado = docRelacionado;
    }
    
    

    
    
    

}
