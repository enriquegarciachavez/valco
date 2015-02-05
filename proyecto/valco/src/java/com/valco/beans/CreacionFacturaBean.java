/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.sun.xml.rpc.processor.modeler.j2ee.xml.string;
//import https.test_paxfacturacion_com_mx._453.WcfRecepcionASMX;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

/**
 *
 * @author Administrador
 */
@ManagedBean
@ViewScoped
public class CreacionFacturaBean {

    /**
     * Creates a new instance of CreacionFacturaBean
     */
    public CreacionFacturaBean() {
    }
    
    public void facturar(){
        try {
            java.lang.String psComprobante = "<cfdi:Comprobante xmlns:cfdi=\"http://www.sat.gob.mx/cfd/3\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" version=\"3.2\" serie=\"A\" folio=\"147\" fecha=\"2013-07-30T17:12:48\" sello=\"a3JLMjgkBJZ42slB3/tELsjscCyqZw0iL2jv22SDpJaKYQH/EG3gKvHnT2Q9vF3BWGVd1M1TT26YznTXCMqIbQX+3U4I6+ywTeA9ILbR1W4XsGZ4YaTROqJc0mqyklUaxeuSV99vwR1Y4IWVY9Ab05fCDdG89UHCvqZ6v4FAr+o=\" formaDePago=\"Pago en una sola exhibición.\" noCertificado=\"20001000000100005867\" certificado=\"MIIEdDCCA1ygAwIBAgIUMjAwMDEwMDAwMDAxMDAwMDU4NjcwDQYJKoZIhvcNAQEFBQAwggFvMRgwFgYDVQQDDA9BLkMuIGRlIHBydWViYXMxLzAtBgNVBAoMJlNlcnZpY2lvIGRlIEFkbWluaXN0cmFjacOzbiBUcmlidXRhcmlhMTgwNgYDVQQLDC9BZG1pbmlzdHJhY2nDs24gZGUgU2VndXJpZGFkIGRlIGxhIEluZm9ybWFjacOzbjEpMCcGCSqGSIb3DQEJARYaYXNpc25ldEBwcnVlYmFzLnNhdC5nb2IubXgxJjAkBgNVBAkMHUF2LiBIaWRhbGdvIDc3LCBDb2wuIEd1ZXJyZXJvMQ4wDAYDVQQRDAUwNjMwMDELMAkGA1UEBhMCTVgxGTAXBgNVBAgMEERpc3RyaXRvIEZlZGVyYWwxEjAQBgNVBAcMCUNveW9hY8OhbjEVMBMGA1UELRMMU0FUOTcwNzAxTk4zMTIwMAYJKoZIhvcNAQkCDCNSZXNwb25zYWJsZTogSMOpY3RvciBPcm5lbGFzIEFyY2lnYTAeFw0xMjA3MjcxNzAyMDBaFw0xNjA3MjcxNzAyMDBaMIHbMSkwJwYDVQQDEyBBQ0NFTSBTRVJWSUNJT1MgRU1QUkVTQVJJQUxFUyBTQzEpMCcGA1UEKRMgQUNDRU0gU0VSVklDSU9TIEVNUFJFU0FSSUFMRVMgU0MxKTAnBgNVBAoTIEFDQ0VNIFNFUlZJQ0lPUyBFTVBSRVNBUklBTEVTIFNDMSUwIwYDVQQtExxBQUEwMTAxMDFBQUEgLyBIRUdUNzYxMDAzNFMyMR4wHAYDVQQFExUgLyBIRUdUNzYxMDAzTURGUk5OMDkxETAPBgNVBAsTCFVuaWRhZCAxMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC2TTQSPONBOVxpXv9wLYo8jezBrb34i/tLx8jGdtyy27BcesOav2c1NS/Gdv10u9SkWtwdy34uRAVe7H0a3VMRLHAkvp2qMCHaZc4T8k47Jtb9wrOEh/XFS8LgT4y5OQYo6civfXXdlvxWU/gdM/e6I2lg6FGorP8H4GPAJ/qCNwIDAQABox0wGzAMBgNVHRMBAf8EAjAAMAsGA1UdDwQEAwIGwDANBgkqhkiG9w0BAQUFAAOCAQEATxMecTpMbdhSHo6KVUg4QVF4Op2IBhiMaOrtrXBdJgzGotUFcJgdBCMjtTZXSlq1S4DG1jr8p4NzQlzxsdTxaB8nSKJ4KEMgIT7E62xRUj15jI49qFz7f2uMttZLNThipunsN/NF1XtvESMTDwQFvas/Ugig6qwEfSZc0MDxMpKLEkEePmQwtZD+zXFSMVa6hmOu4M+FzGiRXbj4YJXn9Myjd8xbL/c+9UIcrYoZskxDvMxc6/6M3rNNDY3OFhBK+V/sPMzWWGt8S1yjmtPfXgFs1t65AZ2hcTwTAuHrKwDatJ1ZPfa482ZBROAAX1waz7WwXp0gso7sDCm2/yUVww==\" subTotal=\"1.000000\" Moneda=\"MXN\" total=\"1.160000\" tipoDeComprobante=\"ingreso\" metodoDePago=\"No Aplica\" LugarExpedicion=\"México, Chihuahua\" NumCtaPago=\"No Aplica\" xsi:schemaLocation=\"http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd\"><cfdi:Emisor rfc=\"AAA010101AAA\" nombre=\"corpus\"><cfdi:DomicilioFiscal calle=\"Centro\" noExterior=\"5600\" noInterior=\"4\" colonia=\"Dale\" localidad=\"Chihuahua\" referencia=\"Javier\" municipio=\"Chihuahua\" estado=\"Chihuahua\" pais=\"México\" codigoPostal=\"31300\" /><cfdi:RegimenFiscal Regimen=\"Regimen \" /></cfdi:Emisor><cfdi:Receptor rfc=\"BBB010101BBA\" nombre=\"Cliente\"><cfdi:Domicilio calle=\"Primera\" noExterior=\"57660\" noInterior=\"4\" colonia=\"Dale\" municipio=\"Chihuahua\" estado=\"Chihuahua\" pais=\"Mexico\" codigoPostal=\"31100\" /></cfdi:Receptor><cfdi:Conceptos><cfdi:Concepto cantidad=\"1\" unidad=\"1\" noIdentificacion=\"1\" descripcion=\"dafasd\" valorUnitario=\"1.000000\" importe=\"1.000000\" /></cfdi:Conceptos><cfdi:Impuestos totalImpuestosTrasladados=\"0.160000\"><cfdi:Traslados><cfdi:Traslado impuesto=\"IVA\" tasa=\"16.00\" importe=\"0.160000\" /></cfdi:Traslados></cfdi:Impuestos></cfdi:Comprobante>";
            java.lang.String psTipoDocumento = "factura";
            int pnIdEstructura = 0;
            java.lang.String sNombre = "WSDL_PAX";
            java.lang.String sContraseña = "wqfCr8O3xLfEhMOHw4nEjMSrxJnvv7bvvr4cVcKuKkBEM++/ke+/gCPvv4nvvrfvvaDvvb/vvqTvvoA=";
            java.lang.String sVersion = "3.2";
           // https.test_paxfacturacion_com_mx._453.WcfRecepcionASMX service = new https.test_paxfacturacion_com_mx._453.WcfRecepcionASMX();
           // https.test_paxfacturacion_com_mx._453.WcfRecepcionASMXSoap port = service.getWcfRecepcionASMXSoap();
            // TODO process result here
          //  java.lang.String result = port.fnEnviarXML(psComprobante, psTipoDocumento, pnIdEstructura, sNombre, sContraseña, sVersion);
           // System.out.println("Result = " + result);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }
    
}
