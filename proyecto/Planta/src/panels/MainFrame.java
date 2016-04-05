package panels;

import security.DialogCallbackHandler;
import creators.PanelCreator;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.event.ActionEvent;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.io.File;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import java.security.Principal;
import java.security.PrivilegedAction;
import javax.security.auth.*;
import javax.security.auth.login.AccountExpiredException;
import javax.security.auth.login.CredentialExpiredException;
import javax.security.auth.login.FailedLoginException;
import javax.security.auth.login.LoginContext;
import javax.security.auth.login.LoginException;
import security.HWLoginModule;
import utilities.UsuarioFirmado;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Karla
 */
public class MainFrame extends javax.swing.JFrame {

    JInternalFrame internalFrame;
    JPanel prueb;

    /**
     * Creates new form MainFrame
     */
    public MainFrame() {
        try{
        initComponents();
        }catch(Exception e){
         JOptionPane.showMessageDialog(null, e);
                }
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jCheckBox1 = new javax.swing.JCheckBox();
        mainPanel = new javax.swing.JDesktopPane();
        jMenuBar1 = new javax.swing.JMenuBar();
        jMenu1 = new javax.swing.JMenu();
        reciboCanales = new javax.swing.JMenuItem();
        jMenuItem2 = new javax.swing.JMenuItem();
        jMenuItem4 = new javax.swing.JMenuItem();
        jMenuItem1 = new javax.swing.JMenuItem();
        jMenuItem5 = new javax.swing.JMenuItem();
        jMenuItem6 = new javax.swing.JMenuItem();
        jMenuItem7 = new javax.swing.JMenuItem();
        jMenu2 = new javax.swing.JMenu();
        jMenuItem3 = new javax.swing.JMenuItem();

        jCheckBox1.setText("jCheckBox1");

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setExtendedState(JFrame.MAXIMIZED_BOTH);
        addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyTyped(java.awt.event.KeyEvent evt) {
                formKeyTyped(evt);
            }
        });

        javax.swing.GroupLayout mainPanelLayout = new javax.swing.GroupLayout(mainPanel);
        mainPanel.setLayout(mainPanelLayout);
        mainPanelLayout.setHorizontalGroup(
            mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 1394, Short.MAX_VALUE)
        );
        mainPanelLayout.setVerticalGroup(
            mainPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 654, Short.MAX_VALUE)
        );

        getContentPane().add(mainPanel, java.awt.BorderLayout.CENTER);

        jMenu1.setText("File");

        reciboCanales.setText("Recibo de canales");
        reciboCanales.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                reciboCanalesActionPerformed(evt);
            }
        });
        jMenu1.add(reciboCanales);

        jMenuItem2.setText("Apertura de proceso");
        jMenuItem2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem2ActionPerformed(evt);
            }
        });
        jMenu1.add(jMenuItem2);

        jMenuItem4.setText("Pesar y etiquetar");
        jMenuItem4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem4ActionPerformed(evt);
            }
        });
        jMenu1.add(jMenuItem4);

        jMenuItem1.setText("Inventarios");
        jMenuItem1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem1ActionPerformed(evt);
            }
        });
        jMenu1.add(jMenuItem1);

        jMenuItem5.setText("Recibo de producto");
        jMenuItem5.setToolTipText("");
        jMenuItem5.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem5ActionPerformed(evt);
            }
        });
        jMenu1.add(jMenuItem5);

        jMenuItem6.setText("Transferencia de Producto");
        jMenuItem6.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem6ActionPerformed(evt);
            }
        });
        jMenu1.add(jMenuItem6);

        jMenuItem7.setText("Recibo de transferencias");
        jMenuItem7.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem7ActionPerformed(evt);
            }
        });
        jMenu1.add(jMenuItem7);

        jMenuBar1.add(jMenu1);

        jMenu2.setText("Ayuda");

        jMenuItem3.setText("Configuración de la báscula");
        jMenuItem3.setToolTipText("");
        jMenuItem3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem3ActionPerformed(evt);
            }
        });
        jMenu2.add(jMenuItem3);

        jMenuBar1.add(jMenu2);

        setJMenuBar(jMenuBar1);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void addNewPanel(ActionEvent evt) {
        if (internalFrame != null) {
            if (prueb instanceof AbrirProcesoPanel) {
                ((AbrirProcesoPanel) prueb).manager.removeKeyEventDispatcher(((AbrirProcesoPanel) prueb).dispacher);
            } else if (prueb instanceof InventariosMain) {
                ((InventariosMain) prueb).manager.removeKeyEventDispatcher(((InventariosMain) prueb).dispacher);
            } else if (prueb instanceof ReciboProductoBC) {
                ((ReciboProductoBC) prueb).manager.removeKeyEventDispatcher(((ReciboProductoBC) prueb).dispacher);
            } else if (prueb instanceof EnviosPanel) {
                ((EnviosPanel) prueb).manager.removeKeyEventDispatcher(((EnviosPanel) prueb).dispacher);
            } else if (prueb instanceof ReciboTransferenciasPanel) {
                    //((ReciboTransferenciasPanel) prueb).manager.removeKeyEventDispatcher(((ReciboTransferenciasPanel) prueb).dispacher);
                ((ReciboTransferenciasPanel) prueb).enviosPanel.manager.removeKeyEventDispatcher(((ReciboTransferenciasPanel) prueb).enviosPanel.dispacher);

            }
            mainPanel.remove(internalFrame);
        }
        internalFrame = new JInternalFrame();
        String sourceName = ((JMenuItem) evt.getSource()).getText();
        prueb = PanelCreator.createPanel(sourceName, mainPanel);
        internalFrame.add(prueb);
        internalFrame.setBounds(0, 0, 200, 200);
        internalFrame.setResizable(true);
        GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        GraphicsDevice gd = ge.getDefaultScreenDevice();
        gd.getDefaultConfiguration().getBounds().getWidth();
        internalFrame.setSize(gd.getDefaultConfiguration().getBounds().getSize());
        mainPanel.add(internalFrame);
        internalFrame.show();
        internalFrame.setVisible(true);
        internalFrame.repaint();
    }

    private void jMenuItem3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem3ActionPerformed
        addNewPanel(evt);
    }//GEN-LAST:event_jMenuItem3ActionPerformed

    private void jMenuItem4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem4ActionPerformed
        addNewPanel(evt);
    }//GEN-LAST:event_jMenuItem4ActionPerformed

    private void jMenuItem2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem2ActionPerformed
        addNewPanel(evt);
    }//GEN-LAST:event_jMenuItem2ActionPerformed

    private void reciboCanalesActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_reciboCanalesActionPerformed
        addNewPanel(evt);
    }//GEN-LAST:event_reciboCanalesActionPerformed

    private void formKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_formKeyTyped
        JOptionPane.showMessageDialog(null, "hola");
    }//GEN-LAST:event_formKeyTyped

    private void jMenuItem1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem1ActionPerformed
        addNewPanel(evt);
    }//GEN-LAST:event_jMenuItem1ActionPerformed

    private void jMenuItem5ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem5ActionPerformed
        addNewPanel(evt);// TODO add your handling code here:
    }//GEN-LAST:event_jMenuItem5ActionPerformed

    private void jMenuItem6ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem6ActionPerformed
        // TODO add your handling code here:
        addNewPanel(evt);
    }//GEN-LAST:event_jMenuItem6ActionPerformed

    private void jMenuItem7ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem7ActionPerformed
        addNewPanel(evt);
    }//GEN-LAST:event_jMenuItem7ActionPerformed

    /**
     * @param args the command line arguments
     *
     * Esta aplicación se intenta autenticar a un usuario.
     *
     * Si el usuario se autentica satisfactoriamente, se visualiza el nombre de
     * usuario y el número de las credenciales.
     *
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        /**
         * Se intenta autenticar al usuario.
         */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                LoginContext lc = null;
                final LoginContext lcFinal;
                try {
                    // se usan los módulos LoginModule configurados para la entrada "valco"
                    lc = new LoginContext("valco", new DialogCallbackHandler());
                } catch (LoginException le) {
                    le.printStackTrace();
                    System.exit(-1);
                }
                // El usuario dispone de 3 intentos para autenticarse satisfactoriamente.
                int i;
                for (i = 0; i < 3; i++) {
                    try {

                        // Intento de autenticación
                        lc.login();

                        // Si no se devuelve ninguna excepción,
                        // la autenticación ha sido satisfactoria.
                        break;

                    } catch (AccountExpiredException aee) {
                        JOptionPane.showMessageDialog(null, "¡Su cuenta ha caducado!", "¡Error de sesion!", JOptionPane.ERROR_MESSAGE);

                        System.exit(-1);

                    } catch (CredentialExpiredException cee) {
                        JOptionPane.showMessageDialog(null, "¡Sus credenciales han caducado!", "¡Error de sesion!", JOptionPane.ERROR_MESSAGE);

                        System.exit(-1);

                    } catch (FailedLoginException fle) {
                        JOptionPane.showMessageDialog(null, "¡Autenticación fallida!", "¡Error de sesion!", JOptionPane.ERROR_MESSAGE);

                        try {
                            Thread.currentThread().sleep(3000);
                        } catch (Exception e) {
                            // Se pasa por alto.
                        }

                    } catch (Exception e) {
                        JOptionPane.showMessageDialog(null, "¡Excepción no prevista - imposible continuar!", "¡Error de sesion!", JOptionPane.ERROR_MESSAGE);

                        e.printStackTrace();
                        System.exit(-1);
                    }
                }

                // ¿Se ha fallado tres veces?
                if (i == 3) {
                    JOptionPane.showMessageDialog(null, "¡Lo lamentamos!", "¡Error de sesion!", JOptionPane.ERROR_MESSAGE);

                    System.exit(-1);
                }
                // Examinemos parte del trabajo basado en Principal:
                lcFinal = lc;
                Subject.doAsPrivileged(lcFinal.getSubject(), new PrivilegedAction() {

                    public MainFrame run() {
                        MainFrame mf = new MainFrame();
                        HWLoginModule.validateAccess(lcFinal.getSubject(), mf.jMenuBar1.getComponents());
                        mf.setTitle(UsuarioFirmado.getUsuarioFirmado().getNombre());
                        mf.setVisible(true);
                        return mf;
                    }
                }, null);

            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JCheckBox jCheckBox1;
    private javax.swing.JMenu jMenu1;
    private javax.swing.JMenu jMenu2;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JMenuItem jMenuItem1;
    private javax.swing.JMenuItem jMenuItem2;
    private javax.swing.JMenuItem jMenuItem3;
    private javax.swing.JMenuItem jMenuItem4;
    private javax.swing.JMenuItem jMenuItem5;
    private javax.swing.JMenuItem jMenuItem6;
    private javax.swing.JMenuItem jMenuItem7;
    private javax.swing.JDesktopPane mainPanel;
    private javax.swing.JMenuItem reciboCanales;
    // End of variables declaration//GEN-END:variables
}
