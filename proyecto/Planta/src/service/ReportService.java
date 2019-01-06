/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import java.util.Map;

/**
 *
 * @author Karla
 */
public interface ReportService {
    public void imprimirReporte(Map parametros, String reportName, 
            boolean compile,boolean copy) throws Exception;
}
