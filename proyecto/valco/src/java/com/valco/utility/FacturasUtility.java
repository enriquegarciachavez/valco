/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.utility;

import com.valco.pojo.Clientes;
import com.valco.pojo.ConceptosFactura;
import com.valco.pojo.Facturas;
import com.valco.pojo.Impuestos;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.ProductosInventario;
import com.valco.servlets.ReportesXls;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.GeneralSecurityException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.Signature;
import java.security.SignatureException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.sql.Connection;
import java.sql.DriverManager;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import org.apache.commons.ssl.PKCS8Key;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import java.util.Base64;

/**
 *
 * @author Administrador
 */
public class FacturasUtility {
    
    private static final String[] UNIDADES = {"", "un ", "dos ", "tres ", "cuatro ", "cinco ", "seis ", "siete ", "ocho ", "nueve "};
    private static final String[] DECENAS = {"diez ", "once ", "doce ", "trece ", "catorce ", "quince ", "dieciseis ",
        "diecisiete ", "dieciocho ", "diecinueve", "veinte ", "treinta ", "cuarenta ",
        "cincuenta ", "sesenta ", "setenta ", "ochenta ", "noventa "};
    private static final String[] CENTENAS = {"", "ciento ", "doscientos ", "trecientos ", "cuatrocientos ", "quinientos ", "seiscientos ",
        "setecientos ", "ochocientos ", "novecientos "};
    
    public static OutputStream getCadenaOriginal(String cadenaOriginalDir, String xml) throws Exception {
        File file = new File(cadenaOriginalDir);
        InputStream content = new FileInputStream(file);
        StreamSource sourceXSL = new StreamSource(content);
        StringReader reader = new StringReader(xml);
        TransformerFactory tFactory = TransformerFactory.newInstance();
        Transformer transformer = null;
        transformer = tFactory.newTransformer(sourceXSL);
        transformer.setOutputProperty(OutputKeys.ENCODING, "ISO-8859-1");
        OutputStream output = new ByteArrayOutputStream();
        transformer.transform(new StreamSource(reader), new StreamResult(output));
        
        return output;
    }
    
    private static byte[] getBytesPrivateKey(String directorio) throws Exception {
        try (InputStream inputstream = new FileInputStream(directorio);) {
            return getBytes(inputstream);
        } catch (FileNotFoundException ex) {
            throw new FileNotFoundException("No se encuentra la llave privada en el "
                    + "directorio especificado");
        } catch (IOException iOE) {
            throw new IOException("Ocurrió un error al leer el archivo con la llave");
        } catch (Exception ex) {
            throw new Exception("Fallo en el pinche getBytesPrivateKey");
        }
    }
    
    private static java.security.PrivateKey getPrivateKey(byte[] bytesClave, String clave) throws Exception {
        java.security.PrivateKey pk;
        try {
            
            PKCS8Key pkcs8 = null;
            pkcs8 = new PKCS8Key(bytesClave, clave.toCharArray());
            
            pk = pkcs8.getPrivateKey();
        } catch (Exception ex) {
            throw new Exception("Fallo en el pinche getPrivateKey");
        }
        return pk;
    }
    
    private static byte[] getBytesCadenaFirmada(java.security.PrivateKey pk, OutputStream output) throws NoSuchAlgorithmException, InvalidKeyException, SignatureException, UnsupportedEncodingException, Exception {
        Signature firma = Signature.getInstance(ParametrosGeneralesUtility.getValor("FA012"));
        firma.initSign(pk);
        firma.update(output.toString().getBytes("UTF-8"));
        byte[] cadenaFirmada = firma.sign();
        return cadenaFirmada;
    }
    
    private static String getSelloBase64(byte[] cadenaFirmada) {
        
        byte[] selloDigital = Base64.getEncoder().encode(cadenaFirmada);
        return new String(selloDigital);
    }
    
    private static String formaXmlFactura(String serie,
            String folio,
            Date fecha,
            String formaPago,
            String total,
            String subTotal,
            String moneda,
            String metodoPago,
            String lugarExpedicion,
            String numCtaPago,
            String noCertificado,
            String tipoDeComprobante,
            String rfcEmisor,
            String nombreEmisor,
            String calleEmisor,
            String numExtEmisor,
            String numInteriorEmisor,
            String coloniaEmisor,
            String localidadEmisor,
            String referenciaEmisor,
            String municipioEmisor,
            String estadoEmisor,
            String paisEmisor,
            String cpEmisor,
            String regimenEmisor,
            String rfcReceptor,
            String nombreReceptor,
            String calleReceptor,
            String numExtReceptor,
            String numInteriorReceptor,
            String coloniaReceptor,
            String municipioReceptor,
            String estadoReceptor,
            String paisReceptor,
            String cpReceptor,
            Iterator<ConceptosFactura> conceptosFactura,
            Set<Impuestos> impuestos,
            String usoCFDI) throws ParseException {
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        String factura = "<cfdi:Comprobante xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd \" version=\"3.2\" serie=\"" + serie + "\" folio=\"" + folio + "\" fecha=\"" + formatDate.format(fecha) + "\" formaDePago=\"" + formaPago + "\"\n"
                + "sello=\"AQUIVAELSELLO\""
                + " total=\"" + total + "\" subTotal=\"" + subTotal + "\" certificado=\"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\" Moneda=\"" + moneda + "\" metodoDePago=\"" + metodoPago + "\" LugarExpedicion=\"" + lugarExpedicion + "\" noCertificado=\"" + noCertificado + "\" tipoDeComprobante=\"" + tipoDeComprobante + "\">\n"
                + "<cfdi:Emisor rfc=\"" + rfcEmisor + "\" nombre=\"" + nombreEmisor + "\">\n"
                + "		<cfdi:DomicilioFiscal calle=\"" + calleEmisor + "\" noExterior=\"" + numExtEmisor + "\" noInterior=\"" + numInteriorEmisor + "\" colonia=\"" + coloniaEmisor + "\" localidad=\"" + localidadEmisor + "\" referencia=\"" + referenciaEmisor + "\" municipio=\"" + municipioEmisor + "\" estado=\"" + estadoEmisor + "\" pais=\"" + paisEmisor + "\" codigoPostal=\"" + cpEmisor + "\" />\n"
                + "		<cfdi:RegimenFiscal Regimen=\"" + regimenEmisor + "\" />\n"
                + "	</cfdi:Emisor>\n"
                + "<cfdi:Receptor rfc=\"" + rfcReceptor + "\" nombre=\"" + nombreReceptor + "\"" + "\" UsoCFDI=\"" + usoCFDI + "\">\n"
                + "		<cfdi:Domicilio calle=\"" + calleReceptor + "\" noExterior=\"" + numExtReceptor + "\" colonia=\"" + coloniaReceptor + "\" municipio=\"" + municipioReceptor + "\" estado=\"" + estadoReceptor + "\" pais=\"" + paisReceptor + "\" codigoPostal=\"" + cpReceptor + "\" />\n"
                + "</cfdi:Receptor>\n"
                + "<cfdi:Conceptos>\n"
                + formaXmlConceptos(conceptosFactura)
                + "</cfdi:Conceptos>\n"
                + "<cfdi:Impuestos totalImpuestosTrasladados=\"" + getTotalImpuestos(impuestos) + "\">\n";
        if (impuestos != null && !impuestos.isEmpty() && getTotalImpuestos(impuestos).compareTo(BigDecimal.ZERO) != 0) {
            factura += "		<cfdi:Traslados>\n"
                    + formaXmlImpuestos(impuestos)
                    + "		</cfdi:Traslados>\n";
        }
        factura += "</cfdi:Impuestos>\n"
                + "</cfdi:Comprobante>";
        
        return factura;
    }
    
    private static String formaXmlPago(String serie,
            String folio,
            Date fecha,
            String formaPago,
            String total,
            String subTotal,
            String moneda,
            String metodoPago,
            String lugarExpedicion,
            String numCtaPago,
            String noCertificado,
            String tipoDeComprobante,
            String rfcEmisor,
            String nombreEmisor,
            String calleEmisor,
            String numExtEmisor,
            String numInteriorEmisor,
            String coloniaEmisor,
            String localidadEmisor,
            String referenciaEmisor,
            String municipioEmisor,
            String estadoEmisor,
            String paisEmisor,
            String cpEmisor,
            String regimenEmisor,
            String rfcReceptor,
            String nombreReceptor,
            String calleReceptor,
            String numExtReceptor,
            String numInteriorReceptor,
            String coloniaReceptor,
            String municipioReceptor,
            String estadoReceptor,
            String paisReceptor,
            String cpReceptor,
            Iterator<ConceptosFactura> conceptosFactura,
            Set<Impuestos> impuestos,
            String usoCFDI,
            String regimenFiscalEmisor) throws ParseException {
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        String factura = "<cfdi:Comprobante xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv33.xsd http://www.sat.gob.mx/Pagos http://www.sat.gob.mx/sitio_internet/cfd/Pagos/Pagos10.xsd \" xmlns:pago10=\"http://www.sat.gob.mx/Pagos\"  version=\"3.3\" serie=\"" + serie + "\" folio=\"" + folio + "\" fecha=\"" + formatDate.format(fecha) + "\"\n"
                + "sello=\"AQUIVAELSELLO\""
                + " total=\"0\" subTotal=\"0\" certificado=\"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\" Moneda=\"XXX\" LugarExpedicion=\"" + cpEmisor + "\" noCertificado=\"" + noCertificado + "\" tipoDeComprobante=\"P\">\n"
                + "<cfdi:Emisor rfc=\"" + rfcEmisor + "\" nombre=\"" + nombreEmisor + "\" RegimenFiscal=\"" + regimenFiscalEmisor +"\">\n"
                + "		<cfdi:DomicilioFiscal calle=\"" + calleEmisor + "\" noExterior=\"" + numExtEmisor + "\" noInterior=\"" + numInteriorEmisor + "\" colonia=\"" + coloniaEmisor + "\" localidad=\"" + localidadEmisor + "\" referencia=\"" + referenciaEmisor + "\" municipio=\"" + municipioEmisor + "\" estado=\"" + estadoEmisor + "\" pais=\"" + paisEmisor + "\" codigoPostal=\"" + cpEmisor + "\" />\n"
                + "		<cfdi:RegimenFiscal Regimen=\"" + regimenEmisor + "\" />\n"
                + "	</cfdi:Emisor>\n"
                + "<cfdi:Receptor rfc=\"" + rfcReceptor + "\" nombre=\"" + nombreReceptor + "\"" + "\" UsoCFDI=\"" + usoCFDI + "\">\n"
                + "		<cfdi:Domicilio calle=\"" + calleReceptor + "\" noExterior=\"" + numExtReceptor + "\" colonia=\"" + coloniaReceptor + "\" municipio=\"" + municipioReceptor + "\" estado=\"" + estadoReceptor + "\" pais=\"" + paisReceptor + "\" codigoPostal=\"" + cpReceptor + "\" />\n"
                + "</cfdi:Receptor>\n"
                + "<cfdi:Conceptos>\n"
                + "<cfdi:Concepto Importe=\"0.00\" ValorUnitario=\"0.00\" Descripcion=\"Pago\" ClaveUnidad=\"ACT\" Cantidad=\"1\" ClaveProdServ=\"84111506\"/>"
                + "</cfdi:Conceptos>\n"
                + "<cfdi:Complemento>\n"
                + "<pago10:Pagos Version=\"1.0\">"
                + ""
                + "</cfdi:Complemento>\n"
                + "</pago10:Pagos>"
                + "</cfdi:Comprobante>";
        
        return factura;
    }
    
    public static String formaXmlConceptos(Iterator<ConceptosFactura> conceptos) {
        String cadena = "";
        while (conceptos.hasNext()) {
            ConceptosFactura concepto = conceptos.next();
            cadena += "<cfdi:Concepto ClaveProdServ=\""+ concepto.getClaveProducto()+ "\" cantidad=\"" + concepto.getCantidad() + "\" ClaveUnidad=\"" + concepto.getUnidad() + "\" NoIdentificacion=\"" + concepto.getClave() + "\" descripcion=\"" + concepto.getDescripcion() + "\" valorUnitario=\"" + concepto.getPrecioUnitario() + "\" importe=\"" + concepto.getImporteTotal() + "\"/>\n";
        }
        return cadena;
    }
    
    public static String formaXmlImpuestos(Set<Impuestos> impuestos) {
        String cadena = "";
        for (Impuestos impuesto : impuestos) {
            cadena += "<cfdi:Traslado impuesto=\"" + impuesto.getImpuesto() + "\" tasa=\"" + impuesto.getTasa() + "\" importe=\"" + impuesto.getImporte() + "\"/>\n";
        }
        return cadena;
    }
    
    public static String getFacturaConSello(Facturas factura) throws Exception {
        
        Clientes cliente = factura.getNotasDeVenta().getClientes();
        String rfcEmisor = ParametrosGeneralesUtility.getValor("FA004");
        String xml = null;
        try {
            xml = formaXmlFactura(factura.getSerie(), Integer.toString(factura.getFolio()), factura.getFecha(),
                    factura.getFormaPago(), factura.getTotal().setScale(2, RoundingMode.HALF_EVEN).toString(), factura.getSubtotal().setScale(2, RoundingMode.HALF_EVEN).toString(),
                    factura.getMoneda(), factura.getMetodoPago(), factura.getLugar(),
                    cliente.getCuentaBancaria().toString(), factura.getNoSeieCertEmisor(), factura.getTipoDocumento(),
                    "DCV9612126N6", "DISTRIBUIDORA DE CARNES VALCO S.A. DE C.V.", "PARRAL", "246",
                    "0", "REVOLUCION", "CHIHUAHUA", "referencia",
                    "CHIHUAHUA", "CHIHUAHUA", "MÉXICO", "31110",
                    "SOCIEDAD ANONIMA", cliente.getRfc(), cliente.getNombreCompleto(), cliente.getCalle(),
                    Integer.toString(cliente.getNumeroExterior()), cliente.getNumeroInterior(), cliente.getColonia(),
                    cliente.getCiudad(), cliente.getEstado(), cliente.getPais(),
                    Integer.toString(cliente.getCodigoPostal()), factura.getConceptosFacturas().iterator(), factura.getImpuestoses(),
                    factura.getUsoCFDI());
        } catch (ParseException ex) {
            throw new Exception("Ocurrió un error al formar el XML de la factura");
            
        }
        
        String xml1 = new String(xml);
        
        OutputStream cadenaOriginal = null;
        
        try {
            
            cadenaOriginal = getCadenaOriginal(ParametrosGeneralesUtility.getValor("FA005"), new String(xml.getBytes("Windows-1252")));
        } catch (UnsupportedEncodingException ex) {
            cadenaOriginal = getCadenaOriginal("//resources//xslt//cadenaoriginal_3_2.xslt", new String(xml.getBytes("Windows-1252")));
        }
        String cadena = cadenaOriginal.toString();
        cadena = cadena.replace("\n", "").replace("\r", "");
        
        factura.setCadenaOriginal(cadena);
        byte[] bytesKey = null;
        java.security.PrivateKey pk = null;
        try {
            //bytesKey = getBytesPrivateKey(ParametrosGeneralesUtility.getValor("FA003"));
            InputStream in = new FileInputStream(ParametrosGeneralesUtility.getValor("FA003"));
            String passwd = ParametrosGeneralesUtility.getValor("FA004");
            byte[] decrypted = (passwd != null)
                    ? getBytes(in, passwd.toCharArray())
                    : getBytes(in);
            //pk = getPrivateKey(bytesKey, ParametrosGeneralesUtility.getValor("FA004"));
            PKCS8EncodedKeySpec keysp = new PKCS8EncodedKeySpec(decrypted);
            KeyFactory kf = KeyFactory.getInstance(ParametrosGeneralesUtility.getValor("FA011"));
            pk = kf.generatePrivate(keysp);
            
        } catch (GeneralSecurityException ex) {
            if (true) {
                throw new Exception("Entro al pinche catch-" + ex.getMessage());
            }
            bytesKey = getBytesPrivateKey("C:/SAT/aaa010101aaa__csd_01.key");
            pk = getPrivateKey(bytesKey, "12345678a");
        }
        byte[] bytesCadenaFirmada = null;
        try {
            OutputStream cadenaOriginal2 = new ByteArrayOutputStream();
            cadenaOriginal2.write(cadena.getBytes());
            bytesCadenaFirmada = getBytesCadenaFirmada(pk, cadenaOriginal2);
        } catch (Exception ex) {
            throw new Exception("Ocurrió un error al ofirmar la cadena original" + ex.getMessage());
        }
        String selloBase64 = getSelloBase64(bytesCadenaFirmada);
        
        selloBase64 = selloBase64.replace("\n", "").replace("\r", "");
        xml = xml.replace("AQUIVAELSELLO", selloBase64);
        return xml;
        
    }
    
    private static byte[] getBytes(InputStream in, char[] passwd)
            throws Exception {
        try {
            PKCS8Key pkcs8 = new PKCS8Key(in, passwd);
            return pkcs8.getDecryptedBytes();
        } finally {
            in.close();
        }
    }
    
    public static String facturar(Facturas factura, Integer facturaId) throws Exception {
        String facturaXml = null;
        String result = null;
        Boolean debug = false;
        try {
            debug = new Boolean(ParametrosGeneralesUtility.getValor("FA006"));
        } catch (Exception e) {
            debug = false;
        }
        try {
            facturaXml = getFacturaConSello(factura);
        } catch (Exception ex) {
            throw new Exception("Factura " + facturaId + ": " + ex.getMessage());
        }
        java.lang.String psTipoDocumento = ParametrosGeneralesUtility.getValor("FA007");
        int pnIdEstructura = 0;
        java.lang.String sNombre = ParametrosGeneralesUtility.getValor("FA008");
        java.lang.String sContraseña = ParametrosGeneralesUtility.getValor("FA009");
        java.lang.String sVersion = ParametrosGeneralesUtility.getValor("FA010");
        if (debug) {
            https.test_paxfacturacion_com_mx._453.WcfRecepcionASMX service = new https.test_paxfacturacion_com_mx._453.WcfRecepcionASMX();
            https.test_paxfacturacion_com_mx._453.WcfRecepcionASMXSoap port = service.getWcfRecepcionASMXSoap();
            result = port.fnEnviarXML(facturaXml, psTipoDocumento, pnIdEstructura, sNombre, sContraseña, sVersion);
        } else {
            https.www_paxfacturacion_com_mx._453.WcfRecepcionASMX service = new https.www_paxfacturacion_com_mx._453.WcfRecepcionASMX();
            https.www_paxfacturacion_com_mx._453.WcfRecepcionASMXSoap port = service.getWcfRecepcionASMXSoap();
            // TODO process result here
            result = port.fnEnviarXML(facturaXml, psTipoDocumento, pnIdEstructura, sNombre, sContraseña, sVersion);
        }
        
        if (result.startsWith("96")) {
            throw new Exception(sNombre + sContraseña);
        } else if (result.startsWith("301")) {
            throw new Exception("El xml se encuentra mal formado." + facturaXml);
        } else if (result.startsWith("302")) {
            throw new Exception("El sello de la factura está mal formado." + facturaXml);
        } else if (result.startsWith("303")) {
            throw new Exception("El xml se encuentra mal formado.");
        } else if (result.startsWith("304")) {
            throw new Exception("El Sello no corresponde al emisor o ya caducó.");
        } else if (result.startsWith("305")) {
            throw new Exception("El certificado fue revocado o está caduco.");
        } else if (result.startsWith("306")) {
            throw new Exception("La fecha de emisión no está dentro de la vigencia del CSD del Emisor.");
        } else if (result.startsWith("307")) {
            throw new Exception("El CDFI tiene un timbre previo.");
        } else if (result.startsWith("308")) {
            throw new Exception("Certificado no expedido or el SAT.");
        } else if (result.startsWith("401")) {
            throw new Exception("El rango de la fecha de generación es mayor a 72 horas para la emisión del timbre.");
        } else if (result.startsWith("402")) {
            throw new Exception("El RFC del emisor no existe." + facturaXml);
        } else if (result.startsWith("403")) {
            throw new Exception("La fecha de emisión es anterior al primero de enero del 2011.");
        }
        
        return result;
    }
    
    public static void agregarDatosDeTimbrado(Facturas factura, String xml) throws ParserConfigurationException, SAXException, IOException, ParseException {
        String folioFiscal = null;
        Date fechaTimbrado = new Date();
        String selloCFD = null;
        String noCertificadoSat = null;
        String selloSat = null;
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        InputStream inputXml = new ByteArrayInputStream(xml.getBytes("UTF-8"));
        org.w3c.dom.Document doc = dBuilder.parse(inputXml);
        doc.getDocumentElement().normalize();
        
        NodeList nList = doc.getElementsByTagName("tfd:TimbreFiscalDigital");
        
        for (int temp = 0; temp < nList.getLength(); temp++) {
            
            Node nNode = nList.item(temp);
            
            System.out.println("\nCurrent Element :" + nNode.getNodeName());
            
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                
                Element eElement = (Element) nNode;
                
                folioFiscal = eElement.getAttribute("UUID");
                fechaTimbrado = formatDate.parse(eElement.getAttribute("FechaTimbrado"));
                selloCFD = eElement.getAttribute("selloCFD");
                noCertificadoSat = eElement.getAttribute("noCertificadoSAT");
                selloSat = eElement.getAttribute("selloSAT");
                
                factura.setFolioFiscal(folioFiscal);
                factura.setFechaTimbrado(fechaTimbrado);
                factura.setSelloCdfi(selloCFD);
                factura.setNoSerieCertSat(noCertificadoSat);
                factura.setSelloSat(selloSat);
            }
        }
    }
    
    public static Set<ConceptosFactura> convierteProductosAConceptos(Iterator<ProductosInventario> productos) {
        Set<ConceptosFactura> conceptos = new HashSet<>();
        while (productos.hasNext()) {
            ProductosInventario producto = productos.next();
            ConceptosFactura concepto = new ConceptosFactura();
            concepto.setPrecioUnitario(new BigDecimal("0.00").setScale(3, RoundingMode.HALF_EVEN));
            concepto.setClaveProducto(producto.getProductosHasProveedores().getProductos().getSubfamilias().getClaveProducto());
            
            concepto.setClave(producto.getProductosHasProveedores().getProductos().getCodigo());
            concepto.setCantidad(new BigDecimal("1.00").setScale(2, RoundingMode.HALF_EVEN));
            concepto.setDescripcion(producto.getProductosHasProveedores().getProductos().getDescripcion());
            concepto.setPrecioUnitario(producto.getPrecio());
            concepto.setCantidad(producto.getPeso());
            concepto.setUnidad("KG");
            concepto.setImporteTotal(producto.getPrecio().multiply(producto.getPeso()));
            if (!conceptos.contains(concepto)) {
                conceptos.add(concepto);
            } else {
                for (ConceptosFactura conceptoRepetio : conceptos) {
                    if (conceptoRepetio.equals(concepto)) {
                        conceptoRepetio.setCantidad(conceptoRepetio.getCantidad().add(concepto.getCantidad()));
                        conceptoRepetio.setImporteTotal(conceptoRepetio.getImporteTotal().add(concepto.getImporteTotal()));
                    }
                }
            }
        }
        return conceptos;
    }
    
    public static void calculaTotalImpuestos(Impuestos impuesto, NotasDeVenta nota) {
        BigDecimal totalIva = new BigDecimal("0.00");
        for (ProductosInventario producto : nota.getProductosInventarios()) {
            if (producto.getProductosHasProveedores().getProductos().isIva()) {
                totalIva = totalIva.add(impuesto.getTasa().divide(new BigDecimal("100.00")).multiply(producto.getPeso().multiply(producto.getPrecio()))).setScale(2, RoundingMode.HALF_EVEN);
            }
        }
        
        impuesto.setImporte(totalIva);
        
    }
    
    public static BigDecimal getTotalImpuestos(Set<Impuestos> impuestos) {
        BigDecimal totalImpuesto = new BigDecimal("0.000000");
        for (Impuestos impuesto : impuestos) {
            totalImpuesto = totalImpuesto.add(impuesto.getImporte()).setScale(6, RoundingMode.HALF_EVEN);
        }
        return totalImpuesto;
    }
    
    public static String byteArrayToHexString(byte[] b) {
        String result = "";
        for (int i = 0; i < b.length; i++) {
            result
                    += Integer.toString((b[i] & 0xff) + 0x100, 16).substring(1);
        }
        return result;
    }
    
    private static byte[] getBytes(InputStream is) throws IOException {
        int totalBytes = 714;
        byte[] buffer = null;
        buffer = new byte[totalBytes];
        is.read(buffer, 0, totalBytes);
        is.close();
        
        return buffer;
    }
    
    public static void guardaXml(String name, String content, String path, Integer facturaId) throws Exception {
        try {
            File file = new File(path + name);
            // if file doesnt exists, then create it
            if (!file.exists()) {
                file.createNewFile();
            }
            
            FileWriter fw = new FileWriter(file.getAbsoluteFile());
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(content);
            bw.close();
        } catch (Exception ex) {
            throw new Exception("Factura " + facturaId + ": Ocurrio un error al generar el PDF.");
        }
        
    }
    
    public static void guardaPdf(Integer facturaId, String name, String path) throws Exception {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReportesXls.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(ReportesXls.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(ReportesXls.class.getName()).log(Level.SEVERE, null, ex);
        }
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/valco", "admin3ZheGrA", "1VtHQW5M-3g-");) {
            String reportsDir = ParametrosGeneralesUtility.getValor("RE001");
            JasperReport jasperReport = null;
            jasperReport = JasperCompileManager.compileReport(reportsDir + "ventasconfactura//FacturaNuevo.jrxml");
            
            JasperPrint jasperPrint = null;
            
            Map mapa = new HashMap();
            mapa.put("FacturaId", facturaId);
            mapa.put("SUBREPORT_DIR", reportsDir + "ventasconfactura//");
            jasperPrint = JasperFillManager.fillReport(jasperReport, mapa, conn);
            
            JasperExportManager.exportReportToPdfFile(jasperPrint, path + name);
            
        } catch (Exception ex) {
            throw new Exception("Factura " + facturaId + ": Ocurrio un error al generar el PDF." + ex.getMessage() + ex.getCause());
        }
    }
    
    public static String Convertir(String numero, boolean mayusculas) {
        String literal = "";
        String parte_decimal;
        //si el numero utiliza (.) en lugar de (,) -> se reemplaza
        numero = numero.replace(".", ",");
        //si el numero no tiene parte decimal, se le agrega ,00
        if (numero.indexOf(",") == -1) {
            numero = numero + ",00";
        }
        //se valida formato de entrada -> 0,00 y 999 999 999,00
        if (Pattern.matches("\\d{1,9},\\d{1,2}", numero)) {
            //se divide el numero 0000000,00 -> entero y decimal
            String Num[] = numero.split(",");
            //de da formato al numero decimal
            parte_decimal = Num[1] + "/100 M.N.";
            //se convierte el numero a literal
            if (Integer.parseInt(Num[0]) == 0) {//si el valor es cero
                literal = "cero ";
            } else if (Integer.parseInt(Num[0]) > 999999) {//si es millon
                literal = getMillones(Num[0]);
            } else if (Integer.parseInt(Num[0]) > 999) {//si es miles
                literal = getMiles(Num[0]);
            } else if (Integer.parseInt(Num[0]) > 99) {//si es centena
                literal = getCentenas(Num[0]);
            } else if (Integer.parseInt(Num[0]) > 9) {//si es decena
                literal = getDecenas(Num[0]);
            } else {//sino unidades -> 9
                literal = getUnidades(Num[0]);
            }
            //devuelve el resultado en mayusculas o minusculas
            if (mayusculas) {
                return (literal + parte_decimal).toUpperCase();
            } else {
                return (literal + parte_decimal);
            }
        } else {//error, no se puede convertir
            return literal = null;
        }
    }

    /* funciones para convertir los numeros a literales */
    private static String getUnidades(String numero) {// 1 - 9
        //si tuviera algun 0 antes se lo quita -> 09 = 9 o 009=9
        String num = numero.substring(numero.length() - 1);
        return UNIDADES[Integer.parseInt(num)];
    }
    
    private static String getDecenas(String num) {// 99                        
        int n = Integer.parseInt(num);
        if (n < 10) {//para casos como -> 01 - 09
            return getUnidades(num);
        } else if (n > 19) {//para 20...99
            String u = getUnidades(num);
            if (u.equals("")) { //para 20,30,40,50,60,70,80,90
                return DECENAS[Integer.parseInt(num.substring(0, 1)) + 8];
            } else {
                return DECENAS[Integer.parseInt(num.substring(0, 1)) + 8] + "y " + u;
            }
        } else {//numeros entre 11 y 19
            return DECENAS[n - 10];
        }
    }
    
    private static String getCentenas(String num) {// 999 o 099
        if (Integer.parseInt(num) > 99) {//es centena
            if (Integer.parseInt(num) == 100) {//caso especial
                return " cien ";
            } else {
                return CENTENAS[Integer.parseInt(num.substring(0, 1))] + getDecenas(num.substring(1));
            }
        } else {//por Ej. 099 
            //se quita el 0 antes de convertir a decenas
            return getDecenas(Integer.parseInt(num) + "");
        }
    }
    
    private static String getMiles(String numero) {// 999 999
        //obtiene las centenas
        String c = numero.substring(numero.length() - 3);
        //obtiene los miles
        String m = numero.substring(0, numero.length() - 3);
        String n = "";
        //se comprueba que miles tenga valor entero
        if (Integer.parseInt(m) > 0) {
            n = getCentenas(m);
            return n + "mil " + getCentenas(c);
        } else {
            return "" + getCentenas(c);
        }
        
    }
    
    private static String getMillones(String numero) { //000 000 000        
        //se obtiene los miles
        String miles = numero.substring(numero.length() - 6);
        //se obtiene los millones
        String millon = numero.substring(0, numero.length() - 6);
        String n = "";
        if (millon.length() > 1) {
            n = getCentenas(millon) + "millones ";
        } else {
            n = getUnidades(millon) + "millon ";
        }
        return n + getMiles(miles);
    }
}
