
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package keydispatchers;

import java.awt.KeyEventDispatcher;
import java.awt.KeyboardFocusManager;
import java.awt.event.KeyEvent;
import javax.swing.JTextField;

/**
 *
 * @author Karla
 */
public class BarCodeScannerKeyDispatcher implements KeyEventDispatcher{
    JTextField barcodeField;
    KeyboardFocusManager manager;
    
    public BarCodeScannerKeyDispatcher(JTextField barcodeField, KeyboardFocusManager manager){
        this.barcodeField = barcodeField;
        this.manager = manager;
    }

    @Override
    public boolean dispatchKeyEvent(KeyEvent e) {
        manager.redispatchEvent(barcodeField, e);
        return true;
    }
    
}
