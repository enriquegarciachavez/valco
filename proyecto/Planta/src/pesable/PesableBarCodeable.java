/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pesable;

import barcode.BarCodableImpl;
import threads.PesoThread;

/**
 *
 * @author Administrador
 */
public class PesableBarCodeable extends BarCodableImpl implements Pesable{

    PesoThread pesoThread;
    
    @Override
    public void finalizeThread() {
        if(pesoThread != null)
        pesoThread.shutdown();
    }

    public PesoThread getPesoThread() {
        return pesoThread;
    }

    public void setPesoThread(PesoThread pesoThread) {
        this.pesoThread = pesoThread;
    }
    
}
