/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import java.util.List;
import mapping.ProductosInventario;
import mapping.Repartidores;

/**
 *
 * @author Karla
 */
public interface TransactionService {
    public void finalize(List<ProductosInventario> productos, Repartidores repartidor,
                                        String modoOperacion) throws Exception;
}
