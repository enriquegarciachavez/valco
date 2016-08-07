/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package components;

import java.awt.event.ActionListener;
import mapping.ProductosInventario;

/**
 *
 * @author Administrador
 */
public interface BarCodeTableHandler extends BarCodeHandler, ActionListener {
    public void fillTable (ProductosInventario producto);
    
    
}
