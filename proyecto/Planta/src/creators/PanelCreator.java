/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package creators;

import javax.swing.JDesktopPane;
import panels.EtiquetadoPanel;
import javax.swing.JPanel;
import panels.AbrirProcesoPanel;
import panels.ConfigBascula;
import panels.ReciboDeProducto;

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
        }
        return null;
    } 
    
}
