/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import mapping.Productos;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.type.OrientationEnum;
import net.sf.jasperreports.view.JasperViewer;
import panels.EtiquetadoPanel;
import utilities.ParametrosGeneralesUtility;

/**
 *
 * @author Karla
 */
public class BasculaServiceImpl implements BasculaService {

    @Override
    public void imprimitCodigoBarras(String producto, String peso, String codigoBarras) {
        String label = "";
        try (BufferedReader br = new BufferedReader(new FileReader("C:\\valco_installation\\conf\\CodigoBarras.txt"))) {
            StringBuilder sb = new StringBuilder();
            String line = br.readLine();

            while (line != null) {
                sb.append(line);
                sb.append(System.lineSeparator());
                line = br.readLine();
            }
            label = sb.toString();
            br.close();
        } catch (IOException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
        PrintService printService = PrintServiceLookup.lookupDefaultPrintService();
        label = label.replace("PRODUCTO", producto);
        label = label.replace("PESO", peso);
        label = label.replace("CODIGO_BARRAS", codigoBarras);

// convertimos el comando a bytes  
        byte[] by = label.getBytes();
        DocFlavor flavor = DocFlavor.BYTE_ARRAY.AUTOSENSE;
        Doc doc = new SimpleDoc(by, flavor, null);

// creamos el printjob  
        DocPrintJob job = printService.createPrintJob();

        try {
            // imprimimos
            job.print(doc, null);
        } catch (PrintException ex) {
            Logger.getLogger(EtiquetadoPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void imprimitCodigoBarrasPDF(String producto, String peso,
            String codigoBarras, String productoCodigo)
                                        throws Exception {
        
        String reportDir = ParametrosGeneralesUtility.getValor("RE001");
        String path = reportDir + "planta/BarCode.jasper";
        String path2 = reportDir + "planta/BarCode.jrxml";

        String realPath = path;
        Map mapa = new HashMap();

        System.out.println(reportDir);
        System.out.println(realPath);
        mapa.put("barCode", codigoBarras);
        mapa.put("producto", producto);
        mapa.put("peso", peso);
        mapa.put("productoCodigo", productoCodigo);
        //JasperCompileManager.compileReportToFile(path2, path);
        JasperPrint jasperPrint = JasperFillManager.fillReport(path, mapa);
        JasperViewer.viewReport(jasperPrint, false);
        JasperPrintManager.printReport(jasperPrint, false);
    }

    @Override
    public String armarCodigoBarras(String letra, int codigoProducto, int peso, int consecutivo) {
        return letra
                + new SimpleDateFormat("yyyyMMdd").format(new Date())
                + String.format("%05d", codigoProducto)
                + String.format("%06d", peso)
                + String.format("%04d", consecutivo);
    }

}
