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
import java.security.NoSuchAlgorithmException;
import java.security.Signature;
import java.security.SignatureException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
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
import javax.faces.context.FacesContext;
import static javax.rmi.PortableRemoteObject.connect;
import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.view.JasperViewer;
import org.apache.commons.ssl.PKCS8Key;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import sun.misc.BASE64Encoder;

/**
 *
 * @author Administrador
 */
public class FacturasUtility {

    public static OutputStream getCadenaOriginal(String cadenaOriginalDir, String xml) throws Exception {
        StreamSource sourceXSL = new StreamSource(new File(cadenaOriginalDir));
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
        }
    }

    private static java.security.PrivateKey getPrivateKey(byte[] bytesClave, String clave) throws GeneralSecurityException {
        PKCS8Key pkcs8 = null;
        pkcs8 = new PKCS8Key(bytesClave, clave.toCharArray());
        java.security.PrivateKey pk;
        pk = pkcs8.getPrivateKey();
        return pk;
    }

    private static byte[] getBytesCadenaFirmada(java.security.PrivateKey pk, OutputStream output) throws NoSuchAlgorithmException, InvalidKeyException, SignatureException, UnsupportedEncodingException {
        Signature firma = Signature.getInstance("SHA1withRSA");
        firma.initSign(pk);
        firma.update(output.toString().getBytes("UTF-8"));
        byte[] cadenaFirmada = firma.sign();
        return cadenaFirmada;
    }

    private static String getSelloBase64(byte[] cadenaFirmada) {
        BASE64Encoder b64 = new BASE64Encoder();
        String selloDigital = b64.encode(cadenaFirmada);
        return selloDigital;
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
            Set<Impuestos> impuestos) throws ParseException {
        SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        String factura = "<cfdi:Comprobante xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd \" version=\"3.2\" serie= \"" + serie + "\" folio= \"" + folio + "\" fecha=\"" + formatDate.format(fecha) + "\" formaDePago= \"" + formaPago + "\"\n"
                + "sello=\"AQUIVAELSELLO\""
                + " total=\"" + total + "\" subTotal=\"" + subTotal + "\" certificado=\"MIIEdDCCA1ygAwIBAgIUMjAwMDEwMDAwMDAxMDAwMDU4NjcwDQYJKoZIhvcNAQEFBQAwggFvMRgwFgYDVQQDDA9BLkMuIGRlIHBydWViYXMxLzAtBgNVBAoMJlNlcnZpY2lvIGRlIEFkbWluaXN0cmFjacOzbiBUcmlidXRhcmlhMTgwNgYDVQQLDC9BZG1pbmlzdHJhY2nDs24gZGUgU2VndXJpZGFkIGRlIGxhIEluZm9ybWFjacOzbjEpMCcGCSqGSIb3DQEJARYaYXNpc25ldEBwcnVlYmFzLnNhdC5nb2IubXgxJjAkBgNVBAkMHUF2LiBIaWRhbGdvIDc3LCBDb2wuIEd1ZXJyZXJvMQ4wDAYDVQQRDAUwNjMwMDELMAkGA1UEBhMCTVgxGTAXBgNVBAgMEERpc3RyaXRvIEZlZGVyYWwxEjAQBgNVBAcMCUNveW9hY8OhbjEVMBMGA1UELRMMU0FUOTcwNzAxTk4zMTIwMAYJKoZIhvcNAQkCDCNSZXNwb25zYWJsZTogSMOpY3RvciBPcm5lbGFzIEFyY2lnYTAeFw0xMjA3MjcxNzAyMDBaFw0xNjA3MjcxNzAyMDBaMIHbMSkwJwYDVQQDEyBBQ0NFTSBTRVJWSUNJT1MgRU1QUkVTQVJJQUxFUyBTQzEpMCcGA1UEKRMgQUNDRU0gU0VSVklDSU9TIEVNUFJFU0FSSUFMRVMgU0MxKTAnBgNVBAoTIEFDQ0VNIFNFUlZJQ0lPUyBFTVBSRVNBUklBTEVTIFNDMSUwIwYDVQQtExxBQUEwMTAxMDFBQUEgLyBIRUdUNzYxMDAzNFMyMR4wHAYDVQQFExUgLyBIRUdUNzYxMDAzTURGUk5OMDkxETAPBgNVBAsTCFVuaWRhZCAxMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC2TTQSPONBOVxpXv9wLYo8jezBrb34i/tLx8jGdtyy27BcesOav2c1NS/Gdv10u9SkWtwdy34uRAVe7H0a3VMRLHAkvp2qMCHaZc4T8k47Jtb9wrOEh/XFS8LgT4y5OQYo6civfXXdlvxWU/gdM/e6I2lg6FGorP8H4GPAJ/qCNwIDAQABox0wGzAMBgNVHRMBAf8EAjAAMAsGA1UdDwQEAwIGwDANBgkqhkiG9w0BAQUFAAOCAQEATxMecTpMbdhSHo6KVUg4QVF4Op2IBhiMaOrtrXBdJgzGotUFcJgdBCMjtTZXSlq1S4DG1jr8p4NzQlzxsdTxaB8nSKJ4KEMgIT7E62xRUj15jI49qFz7f2uMttZLNThipunsN/NF1XtvESMTDwQFvas/Ugig6qwEfSZc0MDxMpKLEkEePmQwtZD+zXFSMVa6hmOu4M+FzGiRXbj4YJXn9Myjd8xbL/c+9UIcrYoZskxDvMxc6/6M3rNNDY3OFhBK+V/sPMzWWGt8S1yjmtPfXgFs1t65AZ2hcTwTAuHrKwDatJ1ZPfa482ZBROAAX1waz7WwXp0gso7sDCm2/yUVww==\" Moneda= \"" + moneda + "\" metodoDePago= \"" + metodoPago + "\" LugarExpedicion= \"" + lugarExpedicion + "\" NumCtaPago= \"" + numCtaPago + "\" noCertificado=\"" + noCertificado + "\" tipoDeComprobante=\"" + tipoDeComprobante + "\">\n"
                + "<cfdi:Emisor rfc= \"" + rfcEmisor + "\" nombre= \"" + nombreEmisor + "\">\n"
                + "		<cfdi:DomicilioFiscal calle= \"" + calleEmisor + "\" noExterior= \"" + numExtEmisor + "\" noInterior= \"" + numInteriorEmisor + "\" colonia= \"" + coloniaEmisor + "\" localidad= \"" + localidadEmisor + "\" referencia= \"" + referenciaEmisor + "\" municipio= \"" + municipioEmisor + "\" estado= \"" + estadoEmisor + "\" pais= \"" + paisEmisor + "\" codigoPostal= \"" + cpEmisor + "\" />\n"
                + "		<cfdi:RegimenFiscal Regimen= \"" + regimenEmisor + "\" />\n"
                + "	</cfdi:Emisor>\n"
                + "<cfdi:Receptor rfc= \"" + rfcReceptor + "\" nombre= \"" + nombreReceptor + "\">\n"
                + "		<cfdi:Domicilio calle= \"" + calleReceptor + "\" noExterior= \"" + numExtReceptor + "\" noInterior= \"" + numInteriorReceptor + "\" colonia= \"" + coloniaReceptor + "\" municipio= \"" + municipioReceptor + "\" estado= \"" + estadoReceptor + "\" pais= \"" + paisReceptor + "\" codigoPostal= \"" + cpReceptor + "\" />\n"
                + "</cfdi:Receptor>\n"
                + "<cfdi:Conceptos>\n"
                + formaXmlConceptos(conceptosFactura)
                + "</cfdi:Conceptos>\n"
                + "<cfdi:Impuestos totalImpuestosTrasladados= \"" + getTotalImpuestos(impuestos) + "\">\n"
                + "		<cfdi:Traslados>\n"
                + formaXmlImpuestos(impuestos)
                + "		</cfdi:Traslados>\n"
                + "</cfdi:Impuestos>\n"
                + "</cfdi:Comprobante>";
        return factura;
    }

    public static String formaXmlConceptos(Iterator<ConceptosFactura> conceptos) {
        String cadena = "";
        while (conceptos.hasNext()) {
            ConceptosFactura concepto = conceptos.next();
            cadena += "<cfdi:Concepto cantidad= \"" + concepto.getCantidad() + "\" unidad= \"" + concepto.getUnidad() + "\" noIdentificacion= \"" + concepto.getClave() + "\" descripcion= \"" + concepto.getDescripcion() + "\" valorUnitario= \"" + concepto.getPrecioUnitario() + "\" importe= \"" + concepto.getImporteTotal() + "\"/>\n";
        }
        return cadena;
    }

    public static String formaXmlImpuestos(Set<Impuestos> impuestos) {
        String cadena = "";
        for (Impuestos impuesto : impuestos) {
            cadena += "<cfdi:Traslado impuesto= \"" + impuesto.getImpuesto() + "\" tasa= \"" + impuesto.getTasa() + "\" importe= \"" + impuesto.getImporte() + "\"/>\n";
        }
        return cadena;
    }

    public static String getFacturaConSello(Facturas factura) throws Exception {

        Clientes cliente = factura.getNotasDeVenta().getClientes();
        String xml = null;
        try {
            xml = formaXmlFactura(factura.getSerie(), Integer.toString(factura.getFolio()), factura.getFecha(),
                    factura.getFormaPago(), factura.getTotal().setScale(2, RoundingMode.HALF_EVEN).toString(), factura.getSubtotal().setScale(2, RoundingMode.HALF_EVEN).toString(),
                    factura.getMoneda(), factura.getMetodoPago(), factura.getLugar(),
                    cliente.getCuentaBancaria().toString(), factura.getNoSeieCertEmisor(), "ingreso",
                    "AAA010101AAA", "DISTRIBUIDORA DE CARNES VALCO S.A. DE C.V.", "PARRAL", "246",
                    "123", "REVOLUCION", "CHIHUAHUA", "referencia",
                    "CHIHUAHUA", "CHIHUAHUA", "MÉXICO", "31110",
                    "REGIMEN", cliente.getRfc(), cliente.getNombreCompleto(), cliente.getCalle(),
                    Integer.toString(cliente.getNumeroExterior()), cliente.getNumeroInterior(), cliente.getColonia(),
                    cliente.getCiudad(), cliente.getEstado(), cliente.getPais(),
                    Integer.toString(cliente.getCodigoPostal()), factura.getConceptosFacturas().iterator(), factura.getImpuestoses());
        } catch (ParseException ex) {
            throw new Exception("Ocurrió un error al formar el XML de la factura");
        }
        OutputStream cadenaOriginal = null;
        try {
            cadenaOriginal = getCadenaOriginal("C:/SAT/cadenaoriginal_3_2.xslt", new String(xml.getBytes("Windows-1252")));
        } catch (UnsupportedEncodingException ex) {
            throw new Exception("Ocurrió un error al obtener la cadena original");
        }
        factura.setCadenaOriginal(cadenaOriginal.toString());
        byte[] bytesKey = null;
        java.security.PrivateKey pk = null;
        try {
            bytesKey = getBytesPrivateKey("C:/SAT/aaa010101aaa__csd_01.key");
            pk = getPrivateKey(bytesKey, "12345678a");
        } catch (GeneralSecurityException ex) {
            throw new Exception(ex);
        }
        byte[] bytesCadenaFirmada = null;
        try {
            bytesCadenaFirmada = getBytesCadenaFirmada(pk, cadenaOriginal);
        } catch (Exception ex) {
            throw new Exception("Ocurrió un error al ofirmar la cadena original");
        }
        String selloBase64 = getSelloBase64(bytesCadenaFirmada);
        xml = xml.replace("AQUIVAELSELLO", selloBase64);
        return xml;

    }

    public static String facturar(Facturas factura, Integer facturaId) throws Exception {
        String facturaXml = null;
        try {
            facturaXml = getFacturaConSello(factura);
        } catch (Exception ex) {
            throw new Exception("Factura " + facturaId + ": "+ex.getMessage());
        }
        java.lang.String psTipoDocumento = "factura";
        int pnIdEstructura = 0;
        java.lang.String sNombre = "WSDL_PAX";
        java.lang.String sContraseña = "wqfCr8O3xLfEhMOHw4nEjMSrxJnvv7bvvr4cVcKuKkBEM++/ke+/gCPvv4nvvrfvvaDvvb/vvqTvvoA=";
        java.lang.String sVersion = "3.2";
        https.test_paxfacturacion_com_mx._453.WcfRecepcionASMX service = new https.test_paxfacturacion_com_mx._453.WcfRecepcionASMX();
        https.test_paxfacturacion_com_mx._453.WcfRecepcionASMXSoap port = service.getWcfRecepcionASMXSoap();
        String result = port.fnEnviarXML(facturaXml, psTipoDocumento, pnIdEstructura, sNombre, sContraseña, sVersion);

        if (result.startsWith("301")) {
            throw new Exception("El xml se encuentra mal formado.");
        } else if (result.startsWith("302")) {
            throw new Exception("El sello de la factura está mal formado.");
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
            throw new Exception("El RFC del emisor no existe.");
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
            JasperReport jasperReport = null;
            JasperReport subreporte = null;
            ServletContext servletContext = (ServletContext) FacesContext
                    .getCurrentInstance().getExternalContext().getContext();
            String realPath = servletContext.getRealPath("//pagina//reportes//factura//Factura.jrxml");
            jasperReport = JasperCompileManager.compileReport(realPath);

            JasperPrint jasperPrint = null;

            Map mapa = new HashMap();
            mapa.put("FacturaId", facturaId);
            jasperPrint = JasperFillManager.fillReport(jasperReport, mapa, conn);

            JasperExportManager.exportReportToPdfFile(jasperPrint, path + name);

        } catch (Exception ex) {
            throw new Exception("Factura " + facturaId + ": Ocurrio un error al generar el PDF.");
        }
    }
}
