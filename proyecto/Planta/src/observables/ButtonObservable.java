/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package observables;

import java.util.ArrayList;
import javax.swing.JButton;
import observers.BarCodeTxtObserver;

/**
 *
 * @author Karla
 */
public class ButtonObservable extends JButton implements BarCodeTxtObservable {
    private ArrayList<BarCodeTxtObserver> observers;

    @Override
    public void registerObserver(BarCodeTxtObserver observer) {
            observers.add(observer);
    }

    @Override
    public void removeObserver(BarCodeTxtObserver observer) {
            observers.remove(observer);
    }

    @Override
    public void notifyObservers() {
            for(BarCodeTxtObserver observer : observers){
                observer.updateBarCodeTxtObserver();
            }
    }
    
}
