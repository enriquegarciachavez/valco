/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.view.JasperViewer;
import utilities.ParametrosGeneralesUtility;

/**
 *
 * @author Karla
 */
public class ReportServiceImpl{

    public static void imprimirReporte(Map parametros, String reportName, boolean compile, boolean copy)
            throws Exception {
        String reportDir = ParametrosGeneralesUtility.getValor("RE001");
        String path = reportDir + reportName + ".jasper";
        
        Properties prop = new Properties();
        String propFileName = "C:\\valco_installation\\conf\\valco.properties";

        InputStream inputStream = null;
            inputStream = new FileInputStream(propFileName);
       

        if (inputStream != null) {
            
                prop.load(inputStream);
            
        } else {
            
                throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
            
        }

        String server = prop.getProperty("server");
        String port = prop.getProperty("port");
        String dbname = prop.getProperty("dbname");
        String user = prop.getProperty("user");
        String password = prop.getProperty("password");
        Connection conn = DriverManager.getConnection("jdbc:mysql://" + server + ":" + port + "/" + dbname, user, password);

        if(compile){
            compileReport(reportName);
        }
        
        JasperPrint jasperPrint = JasperFillManager.fillReport(path, parametros,conn);
        JasperViewer.viewReport(jasperPrint, false);
        JasperPrintManager.printReport(jasperPrint, false);
        if(copy){
            JasperPrintManager.printReport(jasperPrint, false);
        }
    }

    private static void compileReport(String reportName) throws Exception {
        String reportDir = ParametrosGeneralesUtility.getValor("RE001");
        String path = reportDir + reportName + ".jasper";
        String path2 = reportDir + reportName + ".jrxml";
        
        JasperCompileManager.compileReportToFile(path2, path);
    }

}
