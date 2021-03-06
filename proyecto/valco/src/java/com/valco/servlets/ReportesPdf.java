/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

/**
 *
 * @author Administrador
 */
public class ReportesPdf extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
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
        Connection conn = DriverManager.getConnection("jdbc:mysql://"+server+":"+port+"/"+dbname, user, password);
                OutputStream output = response.getOutputStream();
            /* TODO output your page here. You may use following sample code. */

            //Connecting to the MySQL database
            //Loading Jasper Report File from Local file system
            String jrxmlFile = request.getParameter("reporte");//"C:/SAT/facturas/Factura.jrxml";
            String realPath = request.getSession().getServletContext().getRealPath(jrxmlFile);
            File reporte = new File(realPath);
            InputStream input = new FileInputStream(reporte);
            Map mapa = new HashMap();
            Enumeration<String> parametros = request.getParameterNames();
            while (parametros.hasMoreElements()) {
                String parametro = parametros.nextElement();
                if (parametro.contains("Int")) {
                    mapa.put(parametro.split("Int")[0], new Integer(request.getParameter(parametro)));
                } else if (parametro.contains("Date")) {
                    mapa.put(parametro.split("Date")[0], new Date(request.getParameter(parametro)));
                } else if (parametro.contains("Bool")) {
                    mapa.put(parametro.split("Bool")[0], new Boolean(request.getParameter(parametro)));
                }

            }
            String absolutePath = reporte.getAbsolutePath();
            String filePath = absolutePath.
                    substring(0, absolutePath.lastIndexOf(File.separator));
            mapa.put("SUBREPORT_DIR", filePath + "\\");
            JasperReport jasperReport = JasperCompileManager.compileReport(input);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, mapa, conn);
            JasperExportManager.exportReportToPdfStream(jasperPrint, output);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ReportesPdf.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ReportesPdf.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
