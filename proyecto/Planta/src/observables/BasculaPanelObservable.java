/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package observables;

import observers.BasculaPanelObserver;

/**
 *
 * @author Karla
 */
public interface BasculaPanelObservable {

    public void registerObserver(BasculaPanelObserver observer);
    public void removeObserver(BasculaPanelObserver observer);
    public void notifyObservers();
}
