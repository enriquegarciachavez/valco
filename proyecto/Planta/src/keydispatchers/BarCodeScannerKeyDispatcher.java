
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package keydispatchers;

import java.awt.Component;
import java.awt.KeyEventDispatcher;
import java.awt.KeyboardFocusManager;
import java.awt.event.KeyEvent;
import javax.swing.JTextField;

/**
 *
 * @author Karla
 */
public class BarCodeScannerKeyDispatcher implements KeyEventDispatcher{
    private JTextField barcodeField;
    private KeyboardFocusManager manager;
    private Component exception;
    
    public BarCodeScannerKeyDispatcher(JTextField barcodeField, KeyboardFocusManager manager, Component exception){
        this.barcodeField = barcodeField;
        this.manager = manager;
        this.exception = exception;
    }

    @Override
    public boolean dispatchKeyEvent(KeyEvent e) {
        if(exception.equals(e.getSource())){
            manager.redispatchEvent(exception, e);
            return true;
        }
        manager.redispatchEvent(barcodeField, e);
        return true;
    }
    
}
