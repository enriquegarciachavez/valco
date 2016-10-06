/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;
import mapping.ProductosInventario;

/**
 *
 * @author Administrador
 */
public interface ProcesosDAO {
    public List<ProductosInventario> getCajasPorProceso(int procesoCodigo) throws Exception;
    
}
