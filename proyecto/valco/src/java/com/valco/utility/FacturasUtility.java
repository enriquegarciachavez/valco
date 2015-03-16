/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.utility;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.Signature;
import java.security.SignatureException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.ssl.PKCS8Key;
import sun.misc.BASE64Encoder;

/**
 *
 * @author Administrador
 */
public class FacturasUtility {

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
                                    String fecha,
                                    String formaPago,
                                    String total,
                                    String subTotal,
                                    String certificado,
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
                                    String cpReceptor) {
        
        String factura = "<cfdi:Comprobante xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd \" version=\"3.2\" serie= \""+serie+"\" folio= \""+folio+"\" fecha=\""+fecha+"\" formaDePago= \""+formaPago+"\"\n"
                + "total=\""+total+"\" subTotal=\""+subTotal+"\" certificado=\""+certificado+"\" Moneda= \""+moneda+"\" metodoDePago= \""+metodoPago+"\" LugarExpedicion= \""+lugarExpedicion+"\" NumCtaPago= \""+numCtaPago+"\" noCertificado=\""+noCertificado+"\" tipoDeComprobante=\""+tipoDeComprobante+"\">\n"
                + "<cfdi:Emisor rfc= \""+rfcEmisor+"\" nombre= \""+nombreEmisor+"\">\n"
                + "		<cfdi:DomicilioFiscal calle= \""+calleEmisor+"\" noExterior= \""+numExtEmisor+"\" noInterior= \""+numInteriorEmisor+"\" colonia= \""+coloniaEmisor+"\" localidad= \""+localidadEmisor+"\" referencia= \""+referenciaEmisor+"\" municipio= \""+municipioEmisor+"\" estado= \""+estadoEmisor+"\" pais= \""+paisEmisor+"\" codigoPostal= \""+cpEmisor+"\" />\n"
                + "		<cfdi:RegimenFiscal Regimen= \""+regimenEmisor+"\" />\n"
                + "	</cfdi:Emisor>\n"
                + "<cfdi:Receptor rfc= \""+rfcReceptor+"\" nombre= \""+nombreReceptor+"\">\n"
                + "		<cfdi:Domicilio calle= \""+calleReceptor+"\" noExterior= \""+numExtReceptor+"\" noInterior= \""+numInteriorReceptor+"\" colonia= \""+coloniaReceptor+"\" municipio= \""+municipioReceptor+"\" estado= \""+estadoReceptor+"\" pais= \""+paisReceptor+"\" codigoPostal= \""+cpReceptor+"\" />\n"
                + "</cfdi:Receptor>\n"
                + "<cfdi:Conceptos>\n"
                + "		<cfdi:Concepto cantidad= \"1 \" unidad= \"1 \" noIdentificacion= \"1 \" descripcion= \"dafasd \" valorUnitario= \"1.000000 \" importe= \"1.000000 \" />\n"
                + "</cfdi:Conceptos>\n"
                + "<cfdi:Impuestos totalImpuestosTrasladados= \"0.160000 \">\n"
                + "		<cfdi:Traslados>\n"
                + "			<cfdi:Traslado impuesto= \"IVA \" tasa= \"16.00 \" importe= \"0.160000 \" />\n"
                + "		</cfdi:Traslados>\n"
                + "</cfdi:Impuestos>\n"
                + "</cfdi:Comprobante>";
        return null;
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
