/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package components;

import java.awt.ComponentOrientation;
import javax.swing.JTextField;
import listeners.NumericKeyListener;

/**
 *
 * @author Administrador
 */
public class NumericTextField extends JTextField{
    public NumericTextField(){
        
        this.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        this.addKeyListener(new NumericKeyListener());
        
    }
    
}
