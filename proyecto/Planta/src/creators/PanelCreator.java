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
import panels.AsignacionProductoRepartidor;
import panels.ConfigBascula;
import panels.EnviosPanel;
import panels.InventariosMain;
import panels.PuntoVenta;
import panels.ReciboDeProducto;
import panels.ReciboDeProductoSinBC;
import panels.ReciboProductoBC;
import panels.ReciboTransferenciasPanel;
import panels.VentasPanel;
import utilities.SpringContext;

/**
 *
 * @author Administrador
 */
public class PanelCreator {

    public static JPanel createPanel(String panelName, JDesktopPane mainPanel) {

        if ("Recibo de canales".equals(panelName)) {
            //return new ReciboDeProducto();
            ReciboDeProducto reciboDeProducto = (ReciboDeProducto) SpringContext.getContext().getBean("reciboDeProducto");
            return reciboDeProducto;
        } else if ("Apertura de proceso".equals(panelName)) {
            return new AbrirProcesoPanel();
        } else if ("Pesar y etiquetar".equals(panelName)) {
            EtiquetadoPanel etiquetadoPanel = (EtiquetadoPanel) SpringContext.getContext().getBean("etiquetadoPanel");
            return etiquetadoPanel;
        } else if ("Reetiquetar".equals(panelName)) {
            EtiquetadoPanel etiquetadoPanel = (EtiquetadoPanel) SpringContext.getContext().getBean("reetiquetadoPanel");
            return etiquetadoPanel;
        } else if ("Configuración de la báscula".equals(panelName)) {
            return new ConfigBascula();
        } else if ("Inventarios".equals(panelName)) {
            return new InventariosMain();
        } else if ("Recibo de producto".equals(panelName)) {
            return new ReciboProductoBC();
        } else if ("Transferencia de Producto".equals(panelName)) {
            return new EnviosPanel();
        } else if ("Recibo de transferencias".equals(panelName)) {
            return new ReciboTransferenciasPanel();
        } else if ("Asignar producto a repartidor".equals(panelName)) {
            AsignacionProductoRepartidor panel = 
                    (AsignacionProductoRepartidor) SpringContext.getContext().getBean("asignacionRepartidorSalida");
            return panel;
        } else if ("Producto no vendido".equals(panelName)) {
            AsignacionProductoRepartidor panel = 
                    (AsignacionProductoRepartidor) SpringContext.getContext().getBean("asignacionRepartidorEntrada");
            return panel;
        } else if ("Venta".equals(panelName)) {
            return new VentasPanel();
        } else if ("Punto de Venta".equals(panelName)) {
            PuntoVenta puntoDeVenta = (PuntoVenta) SpringContext.getContext().getBean("puntoDeVenta");
            return puntoDeVenta;
        } else if ("Recibo de cajas sin codigo".equals(panelName)) {
            ReciboDeProductoSinBC panel = (ReciboDeProductoSinBC) SpringContext.getContext().getBean("reciboDeProductoSinBc");
            return panel;
        }
        return null;
    }

}
