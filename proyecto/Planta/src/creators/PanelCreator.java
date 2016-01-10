/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package creators;

import java.awt.KeyboardFocusManager;
import javax.swing.JDesktopPane;
import panels.EtiquetadoPanel;
import javax.swing.JPanel;
import panels.AbrirProcesoPanel;
import panels.ConfigBascula;
import panels.EnviosPanel;
import panels.InventariosMain;
import panels.ReciboDeProducto;
import panels.ReciboProductoBC;
import panels.ReciboTransferenciasPanel;

/**
 *
 * @author Administrador
 */
public class PanelCreator {
    
    
    public static JPanel createPanel(String panelName, JDesktopPane mainPanel){
        
        
        if("Recibo de canales".equals(panelName)){
            return new ReciboDeProducto();
        }else if("Apertura de proceso".equals(panelName)){
            return new AbrirProcesoPanel();
        }else if("Pesar y etiquetar".equals(panelName)){
            return new EtiquetadoPanel(mainPanel);
        }else if("Configuración de la báscula".equals(panelName)){
            return new ConfigBascula();
        }else if("Inventarios".equals(panelName)){
            return new InventariosMain();
        }else if("Recibo de producto".equals(panelName)){
            return new ReciboProductoBC();
        }else if("Transferencia de Producto".equals(panelName)){
            return new EnviosPanel();
        }else if("Recibo de transferencias".equals(panelName)){
            return new ReciboTransferenciasPanel();
        }
        return null;
    } 
    
}
