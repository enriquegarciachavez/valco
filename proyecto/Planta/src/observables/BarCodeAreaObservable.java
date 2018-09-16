/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package observables;

import observers.BarCodeAreaObserver;

/**
 *
 * @author Karla
 */
public interface BarCodeAreaObservable {
    public void registerObserver(BarCodeAreaObserver observer);
    public void removeObserver(BarCodeAreaObserver observer);
    public void notifyObservers();
}
