/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listeners;

import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import javax.swing.text.JTextComponent;

/**
 *
 * @author Karla
 */
public class NumericKeyListener implements KeyListener{

    @Override
    public void keyTyped(KeyEvent evt) {
        char c = evt.getKeyChar();
        if (!(Character.isDigit(c) || c == KeyEvent.VK_BACK_SPACE || c == KeyEvent.VK_ENTER )) {
            evt.consume();
        }
    }

    @Override
    public void keyPressed(KeyEvent evt) {
        char c = evt.getKeyChar();
        if (!(Character.isDigit(c) || c == KeyEvent.VK_BACK_SPACE || c == KeyEvent.VK_ENTER )) {
            evt.consume();
        } else {
            JTextComponent source = (JTextComponent)evt.getSource();
            String textSource = source.getText();
            if (c == KeyEvent.VK_BACK_SPACE) {
                if (source.getText().length() > 4) {
                    source.setText(swapChars(textSource, textSource.length() - 3, textSource.length() - 4));
                }else if (textSource.length() == 4){
                    source.setText(textSource.charAt(0) +""+ textSource.charAt(2)+""+ textSource.charAt(3));
                }
            } else if (Character.isDigit(c)){
                if (textSource.length() == 2) {
                    source.setText(textSource.charAt(0) + "." + textSource.charAt(1));
                } else if (textSource.length() > 2) {
                    source.setText(swapChars(textSource, textSource.length() - 3, textSource.length() - 2));
                }
            }
        }
    }

    @Override
    public void keyReleased(KeyEvent e) {

    }
    
    private String swapChars(String str, int lIdx, int rIdx) {
        StringBuilder sb = new StringBuilder(str);
        char l = sb.charAt(lIdx), r = sb.charAt(rIdx);
        sb.setCharAt(lIdx, r);
        sb.setCharAt(rIdx, l);
        return sb.toString();
    }
    
}
