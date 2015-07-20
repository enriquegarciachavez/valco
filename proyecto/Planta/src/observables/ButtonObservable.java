/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package observables;

import java.util.ArrayList;
import javax.swing.JButton;
import observers.Observer;

/**
 *
 * @author Karla
 */
public class ButtonObservable extends JButton implements Observable {
    private ArrayList<Observer> observers;

    @Override
    public void registerObserver(Observer observer) {
            observers.add(observer);
    }

    @Override
    public void removeObserver(Observer observer) {
            observers.remove(observer);
    }

    @Override
    public void notifyObservers() {
            for(Observer observer : observers){
                observer.update();
            }
    }
    
}
