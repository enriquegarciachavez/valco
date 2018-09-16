/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package observables;

import observers.BarCodeTxtObserver;

/**
 *
 * @author Karla
 */
public interface BarCodeTxtObservable {
    public void registerObserver(BarCodeTxtObserver observer);
    public void removeObserver(BarCodeTxtObserver observer);
    public void notifyObservers();
}
