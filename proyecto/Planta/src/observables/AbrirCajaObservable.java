/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package observables;

import mapping.ProductosInventario;
import observers.AbrirCajaObserver;

/**
 *
 * @author Karla
 */
public interface AbrirCajaObservable {
    public void registerObserver(AbrirCajaObserver observer);
    public void removeObserver(AbrirCajaObserver observer);
    public void notifyObservers(ProductosInventario producto);
}
