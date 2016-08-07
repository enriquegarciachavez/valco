/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import com.sun.org.apache.xalan.internal.lib.NodeInfo;
import dao.ClienteDAO;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import mapping.Clientes;

/**
 *
 * @author Administrador
 */
public class ClienteUtility {
    
    public static Clientes getPublicoGeneral(){
        String publicoGeneralCodigo = null;
        Clientes cliente = null;
        ClienteDAO clienteDAO = new ClienteDAO();
        try {
            publicoGeneralCodigo = ParametrosGeneralesUtility.getValor("FA002");
        } catch (Exception ex) {
            publicoGeneralCodigo = "1000";
        }
        try {
            cliente = clienteDAO.getClienteXDescripcionOCodigo(publicoGeneralCodigo);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
                 
        }
        return cliente;
        
        
    }
    
}
