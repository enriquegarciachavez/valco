/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pesable;

import threads.PesoThread;

/**
 *
 * @author Administrador
 */
public class PesableImpl implements Pesable{
    PesoThread pesoThread;
    
    @Override
    public void finalizeThread() {
        pesoThread.shutdown();
    }

    public PesoThread getPesoThread() {
        return pesoThread;
    }

    public void setPesoThread(PesoThread pesoThread) {
        this.pesoThread = pesoThread;
    }
    
    
}
