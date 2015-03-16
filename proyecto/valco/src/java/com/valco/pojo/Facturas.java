package com.valco.pojo;
// Generated 15/03/2015 09:49:32 PM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Facturas generated by hbm2java
 */
public class Facturas  implements java.io.Serializable {


     private Integer codigo;
     private NotasDeVenta notasDeVenta;
     private String lugar;
     private Date fecha;
     private int folio;
     private String folioFiscal;
     private String fechaTimbrado;
     private String noSerieCertSat;
     private String observaciones;
     private String estatus;
     private String xml;
     private String formaPago;
     private String noSeieCertEmisor;
     private String metodoPago;
     private String moneda;
     private int noCliente;
     private String banco;
     private BigDecimal subtotal;
     private BigDecimal iva;
     private BigDecimal total;
     private String importeLetra;
     private String selloCdfi;
     private String selloSat;
     private String cadenaOriginal;
     private String cadenaCompromiso;
     private String condicionPago;
     private Set<NotasDeVenta> notasDeVentas = new HashSet<NotasDeVenta>(0);
     private Set<Impuestos> impuestoses = new HashSet<Impuestos>(0);

    public Facturas() {
    }

	
    public Facturas(NotasDeVenta notasDeVenta, String lugar, Date fecha, int folio, String folioFiscal, String fechaTimbrado, String noSerieCertSat, String estatus, String xml, String formaPago, String noSeieCertEmisor, String metodoPago, String moneda, int noCliente, String banco, BigDecimal subtotal, BigDecimal iva, BigDecimal total, String selloCdfi, String selloSat, String cadenaOriginal, String condicionPago) {
        this.notasDeVenta = notasDeVenta;
        this.lugar = lugar;
        this.fecha = fecha;
        this.folio = folio;
        this.folioFiscal = folioFiscal;
        this.fechaTimbrado = fechaTimbrado;
        this.noSerieCertSat = noSerieCertSat;
        this.estatus = estatus;
        this.xml = xml;
        this.formaPago = formaPago;
        this.noSeieCertEmisor = noSeieCertEmisor;
        this.metodoPago = metodoPago;
        this.moneda = moneda;
        this.noCliente = noCliente;
        this.banco = banco;
        this.subtotal = subtotal;
        this.iva = iva;
        this.total = total;
        this.selloCdfi = selloCdfi;
        this.selloSat = selloSat;
        this.cadenaOriginal = cadenaOriginal;
        this.condicionPago = condicionPago;
    }
    public Facturas(NotasDeVenta notasDeVenta, String lugar, Date fecha, int folio, String folioFiscal, String fechaTimbrado, String noSerieCertSat, String observaciones, String estatus, String xml, String formaPago, String noSeieCertEmisor, String metodoPago, String moneda, int noCliente, String banco, BigDecimal subtotal, BigDecimal iva, BigDecimal total, String importeLetra, String selloCdfi, String selloSat, String cadenaOriginal, String cadenaCompromiso, String condicionPago, Set<NotasDeVenta> notasDeVentas, Set<Impuestos> impuestoses) {
       this.notasDeVenta = notasDeVenta;
       this.lugar = lugar;
       this.fecha = fecha;
       this.folio = folio;
       this.folioFiscal = folioFiscal;
       this.fechaTimbrado = fechaTimbrado;
       this.noSerieCertSat = noSerieCertSat;
       this.observaciones = observaciones;
       this.estatus = estatus;
       this.xml = xml;
       this.formaPago = formaPago;
       this.noSeieCertEmisor = noSeieCertEmisor;
       this.metodoPago = metodoPago;
       this.moneda = moneda;
       this.noCliente = noCliente;
       this.banco = banco;
       this.subtotal = subtotal;
       this.iva = iva;
       this.total = total;
       this.importeLetra = importeLetra;
       this.selloCdfi = selloCdfi;
       this.selloSat = selloSat;
       this.cadenaOriginal = cadenaOriginal;
       this.cadenaCompromiso = cadenaCompromiso;
       this.condicionPago = condicionPago;
       this.notasDeVentas = notasDeVentas;
       this.impuestoses = impuestoses;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public NotasDeVenta getNotasDeVenta() {
        return this.notasDeVenta;
    }
    
    public void setNotasDeVenta(NotasDeVenta notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }
    public String getLugar() {
        return this.lugar;
    }
    
    public void setLugar(String lugar) {
        this.lugar = lugar;
    }
    public Date getFecha() {
        return this.fecha;
    }
    
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public int getFolio() {
        return this.folio;
    }
    
    public void setFolio(int folio) {
        this.folio = folio;
    }
    public String getFolioFiscal() {
        return this.folioFiscal;
    }
    
    public void setFolioFiscal(String folioFiscal) {
        this.folioFiscal = folioFiscal;
    }
    public String getFechaTimbrado() {
        return this.fechaTimbrado;
    }
    
    public void setFechaTimbrado(String fechaTimbrado) {
        this.fechaTimbrado = fechaTimbrado;
    }
    public String getNoSerieCertSat() {
        return this.noSerieCertSat;
    }
    
    public void setNoSerieCertSat(String noSerieCertSat) {
        this.noSerieCertSat = noSerieCertSat;
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
    public String getXml() {
        return this.xml;
    }
    
    public void setXml(String xml) {
        this.xml = xml;
    }
    public String getFormaPago() {
        return this.formaPago;
    }
    
    public void setFormaPago(String formaPago) {
        this.formaPago = formaPago;
    }
    public String getNoSeieCertEmisor() {
        return this.noSeieCertEmisor;
    }
    
    public void setNoSeieCertEmisor(String noSeieCertEmisor) {
        this.noSeieCertEmisor = noSeieCertEmisor;
    }
    public String getMetodoPago() {
        return this.metodoPago;
    }
    
    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }
    public String getMoneda() {
        return this.moneda;
    }
    
    public void setMoneda(String moneda) {
        this.moneda = moneda;
    }
    public int getNoCliente() {
        return this.noCliente;
    }
    
    public void setNoCliente(int noCliente) {
        this.noCliente = noCliente;
    }
    public String getBanco() {
        return this.banco;
    }
    
    public void setBanco(String banco) {
        this.banco = banco;
    }
    public BigDecimal getSubtotal() {
        return this.subtotal;
    }
    
    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }
    public BigDecimal getIva() {
        return this.iva;
    }
    
    public void setIva(BigDecimal iva) {
        this.iva = iva;
    }
    public BigDecimal getTotal() {
        return this.total;
    }
    
    public void setTotal(BigDecimal total) {
        this.total = total;
    }
    public String getImporteLetra() {
        return this.importeLetra;
    }
    
    public void setImporteLetra(String importeLetra) {
        this.importeLetra = importeLetra;
    }
    public String getSelloCdfi() {
        return this.selloCdfi;
    }
    
    public void setSelloCdfi(String selloCdfi) {
        this.selloCdfi = selloCdfi;
    }
    public String getSelloSat() {
        return this.selloSat;
    }
    
    public void setSelloSat(String selloSat) {
        this.selloSat = selloSat;
    }
    public String getCadenaOriginal() {
        return this.cadenaOriginal;
    }
    
    public void setCadenaOriginal(String cadenaOriginal) {
        this.cadenaOriginal = cadenaOriginal;
    }
    public String getCadenaCompromiso() {
        return this.cadenaCompromiso;
    }
    
    public void setCadenaCompromiso(String cadenaCompromiso) {
        this.cadenaCompromiso = cadenaCompromiso;
    }
    public String getCondicionPago() {
        return this.condicionPago;
    }
    
    public void setCondicionPago(String condicionPago) {
        this.condicionPago = condicionPago;
    }
    public Set<NotasDeVenta> getNotasDeVentas() {
        return this.notasDeVentas;
    }
    
    public void setNotasDeVentas(Set<NotasDeVenta> notasDeVentas) {
        this.notasDeVentas = notasDeVentas;
    }
    public Set<Impuestos> getImpuestoses() {
        return this.impuestoses;
    }
    
    public void setImpuestoses(Set<Impuestos> impuestoses) {
        this.impuestoses = impuestoses;
    }




}


