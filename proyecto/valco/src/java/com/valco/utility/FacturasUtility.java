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
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.Signature;
import java.security.SignatureException;
import java.util.Date;
import java.util.Iterator;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import org.apache.commons.ssl.PKCS8Key;
import sun.misc.BASE64Encoder;

/**
 *
 * @author Administrador
 */
public class FacturasUtility {
    
    public OutputStream getCadenaOriginal(String cadenaOriginalDir, String xml){
        StreamSource sourceXSL = new StreamSource(new File("cadenaOriginalDir"));
        StringReader reader = new StringReader(xml);
        StringWriter writer = new StringWriter();
        TransformerFactory tFactory = TransformerFactory.newInstance();
        Transformer transformer = null;
        try {
            transformer = tFactory.newTransformer(sourceXSL);
        } catch (TransformerConfigurationException ex) {
        }

        OutputStream output = new ByteArrayOutputStream();

        try {
            transformer.transform(new StreamSource(reader), new StreamResult(output));
        } catch (TransformerException ex) {
        }
        
        return output;
    }

    private byte[] getBytesPrivateKey(String directorio) throws Exception {
        try (InputStream inputstream = new FileInputStream("C:/SAT/aaa010101aaa__csd_01.key");) {
            return getBytes(inputstream);
        } catch (FileNotFoundException ex) {
            throw new FileNotFoundException("No se encuentra la llave privada en el "
                    + "directorio especificado");
        } catch (IOException iOE) {
            throw new IOException("Ocurrió un error al leer el archivo con la llave");
        }
    }

    private java.security.PrivateKey getPrivateKey(byte[] bytesClave, String clave) throws GeneralSecurityException {
        PKCS8Key pkcs8 = null;
        pkcs8 = new PKCS8Key(bytesClave, clave.toCharArray());

        java.security.PrivateKey pk;
        pk = pkcs8.getPrivateKey();
        return pk;
    }

    private byte[] getBytesCadenaFirmada(java.security.PrivateKey pk, OutputStream output) throws NoSuchAlgorithmException, InvalidKeyException, SignatureException, UnsupportedEncodingException {
        Signature firma = Signature.getInstance("SHA1withRSA");
        firma.initSign(pk);
        firma.update(output.toString().getBytes("UTF-8"));
        byte[] cadenaFirmada = firma.sign();
        return cadenaFirmada;
    }

    private String getSelloBase64(byte[] cadenaFirmada) {
        BASE64Encoder b64 = new BASE64Encoder();
        String selloDigital = b64.encode(cadenaFirmada);
        return selloDigital;
    }

    private String formaXmlFactura(String serie,
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
                                    Iterator<Impuestos> impuestos) {
        
        String factura = "<cfdi:Comprobante xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd \" version=\"3.2\" serie= \""+serie+"\" folio= \""+folio+"\" fecha=\""+fecha+"\" formaDePago= \""+formaPago+"\"\n"
                + "total=\""+total+"\" subTotal=\""+subTotal+"\" certificado=\"AQUIVAELCERTIFICADO\" Moneda= \""+moneda+"\" metodoDePago= \""+metodoPago+"\" LugarExpedicion= \""+lugarExpedicion+"\" NumCtaPago= \""+numCtaPago+"\" noCertificado=\""+noCertificado+"\" tipoDeComprobante=\""+tipoDeComprobante+"\">\n"
                + "<cfdi:Emisor rfc= \""+rfcEmisor+"\" nombre= \""+nombreEmisor+"\">\n"
                + "		<cfdi:DomicilioFiscal calle= \""+calleEmisor+"\" noExterior= \""+numExtEmisor+"\" noInterior= \""+numInteriorEmisor+"\" colonia= \""+coloniaEmisor+"\" localidad= \""+localidadEmisor+"\" referencia= \""+referenciaEmisor+"\" municipio= \""+municipioEmisor+"\" estado= \""+estadoEmisor+"\" pais= \""+paisEmisor+"\" codigoPostal= \""+cpEmisor+"\" />\n"
                + "		<cfdi:RegimenFiscal Regimen= \""+regimenEmisor+"\" />\n"
                + "	</cfdi:Emisor>\n"
                + "<cfdi:Receptor rfc= \""+rfcReceptor+"\" nombre= \""+nombreReceptor+"\">\n"
                + "		<cfdi:Domicilio calle= \""+calleReceptor+"\" noExterior= \""+numExtReceptor+"\" noInterior= \""+numInteriorReceptor+"\" colonia= \""+coloniaReceptor+"\" municipio= \""+municipioReceptor+"\" estado= \""+estadoReceptor+"\" pais= \""+paisReceptor+"\" codigoPostal= \""+cpReceptor+"\" />\n"
                + "</cfdi:Receptor>\n"
                + "<cfdi:Conceptos>\n"
                + this.formaXmlConceptos(conceptosFactura)
                + "</cfdi:Conceptos>\n"
                + "<cfdi:Impuestos totalImpuestosTrasladados= \""+this.getTotalImpuestos(impuestos)+"\">\n"
                + "		<cfdi:Traslados>\n"
                + this.formaXmlImpuestos(impuestos)
                + "		</cfdi:Traslados>\n"
                + "</cfdi:Impuestos>\n"
                + "</cfdi:Comprobante>";
        return null;
    }
    
    public String formaXmlConceptos(Iterator<ConceptosFactura> conceptos){
        String cadena = "";
        while(conceptos.hasNext()){
            ConceptosFactura concepto = conceptos.next();
            cadena += "<cfdi:Concepto cantidad= \""+concepto.getCantidad()+"\" unidad= \""+concepto.getUnidad()+"\" noIdentificacion= \""+concepto.getClave()+"\" descripcion= \""+concepto.getDescripcion()+"\" valorUnitario= \""+concepto.getPrecioUnitario()+"\" importe= \""+concepto.getImporteTotal()+"\"/>\n";
        }
        return cadena;
    }
    
    public String formaXmlImpuestos(Iterator<Impuestos> impuestos){
        String cadena = "";
        while(impuestos.hasNext()){
            Impuestos impuesto = impuestos.next();
            cadena += "<cfdi:Traslado impuesto= \""+impuesto.getImpuesto()+"\" tasa= \""+impuesto.getTasa()+"\" importe= \""+impuesto.getImporte()+"\"/>\n";
        }
        return cadena;
    }
    
    public void facturar(Facturas factura, Clientes cliente){
        this.formaXmlFactura("A", factura.getFolio(), factura.getFecha(), 
                factura.getFormaPago(), factura.getTotal(), factura.getSubtotal(),
                factura.getMoneda(), factura.getMetodoPago(), factura.getLugar(),
                cliente.getCuentaBancaria().toString(), factura.getNoSeieCertEmisor(), factura.getTpoComprobante,
                factura.getrfcEmisor, nombre del emisor, calle del emisor, num ext emisor,
                        num inte emisor, colonia emisor, localidad emisor, referencia emisor,
                        municipio emisor, estado emisor, pais emisor, cp emisor,
                        regimen emisor, cliente.getRfc(), cliente.getNombres(), cliente.getDireccion(), 
                        cliente.getNumeroExterior(), cliente.getNumeroInterior(), cliente.getColonia(),
                        cliente.getCiudad(), cliente.getEstado(), cliente.getPais(), 
                        cliente.getCodigoPostal(), factura.get, factura.getImpuestoses().iterator());
        
    }
    
    public Double getTotalImpuestos(Iterator<Impuestos> impuestos){
        Double totalImpuesto = 0.000000;
        while(impuestos.hasNext()){
            Impuestos impuesto = impuestos.next();
            totalImpuesto += impuesto.getImporte().doubleValue();
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
}
