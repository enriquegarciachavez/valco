
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
import java.util.List;
import javax.swing.JTextField;

/**
 *
 * @author Karla
 */
public class BarCodeScannerKeyDispatcher implements KeyEventDispatcher {

    private JTextField barcodeField;
    private KeyboardFocusManager manager;
    private List<Component> exceptions;

    public BarCodeScannerKeyDispatcher(JTextField barcodeField, KeyboardFocusManager manager, List<Component> exceptions) {
        this.barcodeField = barcodeField;
        this.manager = manager;
        this.exceptions = exceptions;
    }

    @Override
    public boolean dispatchKeyEvent(KeyEvent e) {
        if (exceptions != null) {

            for (Component exception : exceptions) {
                if (e.getSource().equals(exception)) {
                    manager.redispatchEvent(exception, e);
                    return true;
                }
            }
        }
        manager.redispatchEvent(barcodeField, e);
        return true;
    }

}
