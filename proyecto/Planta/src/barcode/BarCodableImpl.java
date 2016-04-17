/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package barcode;

import java.awt.KeyboardFocusManager;
import keydispatchers.BarCodeScannerKeyDispatcher;
import panels.CoustomPanel;

/**
 *
 * @author Administrador
 */
public class BarCodableImpl extends CoustomPanel implements BarCodable{
    private BarCodeScannerKeyDispatcher dispacher;
    private KeyboardFocusManager manager;
    @Override
    public void removeKeyEvent() {
        manager.removeKeyEventDispatcher(dispacher);
    }

    public BarCodeScannerKeyDispatcher getDispacher() {
        return dispacher;
    }

    public void setDispacher(BarCodeScannerKeyDispatcher dispacher) {
        this.dispacher = dispacher;
    }

    public KeyboardFocusManager getManager() {
        return manager;
    }

    public void setManager(KeyboardFocusManager manager) {
        this.manager = manager;
    }
    
    
    
}
