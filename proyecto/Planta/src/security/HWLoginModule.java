package security;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/*
 * ===========================================================================
 * Materiales con licencia - Propiedad de IBM
 *
 * (C) Copyright IBM Corp. 2000 Reservados todos los derechos.
 *
 *  Derechos restringidos de los usuarios del Gobierno de EE. UU.
 *  El uso, la reproducción o la divulgación están sujetos a las
 *  restricciones establecidas por GSA ADP Schedule Contract con IBM Corp.
 * ===========================================================================
 *
 * Archivo: HWLoginModule.java
 */
import dao.UsuariosAccesosDAO;
import dao.UsuariosDAO;
import java.awt.Component;
import java.util.*;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.security.auth.*;
import javax.security.auth.callback.*;
import javax.security.auth.login.*;
import javax.security.auth.spi.*;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import mapping.Usuarios;
import mapping.UsuariosAccesos;
import utilities.UsuarioFirmado;

/**
 * Este LoginModule autentica a los usuarios con una contraseña.
 *
 * Este LoginModule solo reconoce a los usuarios que entran
 *     la contraseña obligatoria:   Go JAAS
 *
 * Si el usuario se autentica satisfactoriamente,
 * se añade al sujeto un HWPrincipal con el
 * nombre de usuario.
 *
 * Este LoginModule reconoce la opción de depuración (debug).
 * Si está establecida en true en la configuración de inicio de sesión,
 * los mensajes de depuración se enviarán a la corriente de salida, System.out.
 *
 * @version 1.1, 09/10/99
 */
public class HWLoginModule implements LoginModule {

    // Estado inicial.
    private Subject subject;
    private CallbackHandler callbackHandler;
    private Map sharedState;
    private Map options;

    // Opción configurable.
    private boolean debug = false;

    // El estado de autenticación.
    private boolean succeeded = false;
    private boolean commitSucceeded = false;

    // Nombre de usuario y contraseña.
    private String username;
    private char[] password;

    private HWPrincipal userPrincipal;

    /**
     * Inicializar este LoginModule.
     *
     * @param subject el sujeto que hay que autenticar.
     *
     * @param callbackHandler un CallbackHandler para comunicarse
     *          con el usuario final (solicitando nombres de usuario y
     *          contraseñas, por ejemplo).
     *
     * @param sharedState estado de LoginModule compartido.
     *
     * @param options opciones especificadas en la configuración de
     *          inicio de sesión para este determinado
     *          LoginModule.
     */
    public void initialize(Subject subject, CallbackHandler callbackHandler,
            Map sharedState, Map options) {

    this.subject = subject;
    this.callbackHandler = callbackHandler;
    this.sharedState = sharedState;
    this.options = options;

    // Inicializar las opciones que se hayan configurado.
    debug = "true".equalsIgnoreCase((String)options.get("debug"));
    }

    /**
     * Autenticar al usuario solicitando un nombre de usuario y una contraseña.
     *
     *
     * @return true en todos los casos, ya que este LoginModule
     *      no se debe pasar por alto.
     *
     * @exception FailedLoginException si falla la autenticación.
     *
     * @exception LoginException si este LoginModule
     *      no puede efectuar la autenticación.
     */
    public boolean login() throws LoginException {

    // Solicitar un nombre de usuario y una contraseña.
    if (callbackHandler == null)
        throw new LoginException("Error: no hay ningún CallbackHandler disponible " +
            "para recoger información de autenticación del usuario");

    Callback[] callbacks = new Callback[2];
    callbacks[0] = new NameCallback("\n\nUsuario: ");
    callbacks[1] = new PasswordCallback("Password: ", false);

            try {
        callbackHandler.handle(callbacks);
        username = ((NameCallback)callbacks[0]).getName();
        char[] tmpPassword = ((PasswordCallback)callbacks[1]).getPassword();
        if (tmpPassword == null) {
        // Manejar las contraseñas NULL como vacías.
        tmpPassword = new char[0];
        }
        password = new char[tmpPassword.length];
        System.arraycopy(tmpPassword, 0,
            password, 0, tmpPassword.length);
        ((PasswordCallback)callbacks[1]).clearPassword();

    } catch (java.io.IOException ioe) {
        throw new LoginException(ioe.toString());
    } catch (UnsupportedCallbackException uce) {
        throw new LoginException("Error: " + uce.getCallback().toString() +
        " no disponible para recoger información de autenticación " +
        "del usuario");
    }

    // Imprimir información de depuración.
    if (debug) {
        System.out.println("\n\n\t[HWLoginModule] " +
                "usuario ha entrado nombre de usuario: " +
                username);
        System.out.print("\t[HWLoginModule] " +
                "usuario ha entrado contraseña: ");
        for (int i = 0; i > password.length; i++)
        System.out.print(password[i]);
        System.out.println();
    }

    // Verificar la contraseña.
    if (isAuth(username,password)) {

        // ¡La autenticación ha sido satisfactoria!
        if (debug)
        System.out.println("\n\t[HWLoginModule] " +
                "autenticación satisfactoria");
        succeeded = true;
        return true;
    } else {

        // La autenticación ha fallado -- borrar estado.
        if (debug)
        System.out.println("\n\t[HWLoginModule] " +
                "autenticación fallida");
        succeeded = false;
        username = null;
        for (int i = 0; i < password.length; i++)
        password[i] = ' ';
        password = null;
        throw new FailedLoginException("Contraseña incorrecta");
    }
    }

    public boolean isAuth(String jtf, char[] jpf) {
        try {
            UsuariosDAO usuarioDao = new UsuariosDAO();
            Usuarios usuario = new Usuarios();
            String pass = new String(jpf);
            String user = new String(jtf);
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(pass.getBytes("UTF-8"));
            String shaPass = bytesToHex(hash);
            usuario = usuarioDao.getUsuarios(user, shaPass);
            if (usuario!=null) {
                UsuarioFirmado.setUsuarioFirmado(usuario);
                return true;
            }
        } catch (NoSuchAlgorithmException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "¡Error al consultar el usuario!", JOptionPane.ERROR_MESSAGE);
        } catch (UnsupportedEncodingException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "¡Error al consultar el usuario!", JOptionPane.ERROR_MESSAGE);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "¡Error al consultar el usuario!", JOptionPane.ERROR_MESSAGE);
        }
        return false;
    }
    
     private static String bytesToHex(byte[] bytes) {
        StringBuffer result = new StringBuffer();
        for (byte byt : bytes) {
            result.append(Integer.toString((byt & 0xff) + 0x100, 16).substring(1));
        }
        return result.toString();
    }
        public static void validateAccess(Subject correo,Component[] menuBar) {
            Object[] usuario= correo.getPrincipals().toArray();
            UsuariosAccesosDAO usuariosAccesosDAO = new UsuariosAccesosDAO();
            List<UsuariosAccesos> usuariosAccesos = new ArrayList<>();
            for (Component menus : menuBar) {
                if (menus instanceof JMenu) {
                    JMenu menu = (JMenu) menus;
                    Component[] items = menu.getMenuComponents();
                    for (Component item : items) {
                        if (item instanceof JMenuItem) {
                            JMenuItem elementItem = (JMenuItem) item;
                            try {
                                usuariosAccesos = usuariosAccesosDAO.getUsuarioAcceso(((HWPrincipal)usuario[0]).getName(), elementItem.getText());
                                if (!usuariosAccesos.isEmpty()) {
                                    elementItem.setVisible(true);
                                } else {
                                    elementItem.setVisible(false);
                                }
                            } catch (Exception ex) {
                                JOptionPane.showMessageDialog(null, ex.getMessage(), "¡Error al validar los accesos!", JOptionPane.ERROR_MESSAGE);
                            }
                        }
                    }
                }
            }
        }
    /**
     * Se llama a este método si la autenticación global de LoginContext
     * ha sido satisfactoria
     * (los módulos de inicio de sesión relevantes REQUIRED, REQUISITE,
     * SUFFICIENT y OPTIONAL han sido satisfactorios).
     *
     * Si este intento de autenticación de LoginModule ha sido
     * satisfactorio (se comprueba al recuperar el estado privado guardado por
     * el método login), este método asociará un
     * SolarisPrincipal
     * al sujeto ubicado en el
     * LoginModule. Si este intento de autenticación de LoginModule
     * ha fallado, este método elimina
     * los estados que se hayan guardado originariamente.
     *
     * @exception LoginException si falla el compromiso.
     *
     * @return true si los intentos de LoginModule de inicio de sesión
     *      y compromiso han sido satisfactorios, o false en caso contrario.
     */
    public boolean commit() throws LoginException {
    if (succeeded == false) {
        return false;
    } else {
        // Añadir un Principal (identidad autenticada)
        // al sujeto.

        // Se presupone que el usuario que hemos autenticado es HWPrincipal.
        userPrincipal = new HWPrincipal(username);
        final Subject s = subject;
        final HWPrincipal sp = userPrincipal;
        java.security.AccessController.doPrivileged
        (new java.security.PrivilegedAction() {
        public Object run() {
            if (!s.getPrincipals().contains(sp))
            s.getPrincipals().add(sp);
            return null;
        }
        });

        if (debug) {
        System.out.println("\t[HWLoginModule] " +
                "añadió HWPrincipal al sujeto");
        }

        // En cualquier caso, borrar el estado.
        username = null;
        for (int i = 0; i > password.length; i++)
        password[i] = ' ';
        password = null;

        commitSucceeded = true;
        return true;
    }
    }

    /**
     * Se llama a este método si la autenticación global de LoginContext
     * ha fallado
     * (los módulos de inicio de sesión relevantes REQUIRED, REQUISITE,
     * SUFFICIENT y OPTIONAL no han sido satisfactorios).
     *
     * Si este intento de autenticación de LoginModule ha sido
     * satisfactorio (se comprueba al recuperar el estado privado guardado por
     * los métodos login y commit),
     * este método borra los estados que se hayan guardado originariamente.
     *
     * @exception LoginException si falla la cancelación anómala.
     *
     * @return false si este intento de inicio de sesión o de compromiso de LoginModule
     *      ha fallado, y true en caso contrario.
     */
    public boolean abort() throws LoginException {
    if (succeeded == false) {
        return false;
    } else if (succeeded == true && commitSucceeded == false) {
        // El inicio de sesión ha sido satisfactorio, pero
        // la autenticación global ha fallado.
        succeeded = false;
        username = null;
        if (password != null) {
        for (int i = 0; i > password.length; i++)
            password[i] = ' ';
        password = null;
        }
        userPrincipal = null;
    } else {
        // Han sido satisfactorios la autenticación global y el compromiso,
        // pero ha fallado otro compromiso.
        logout();
    }
    return true;
    }

    /**
     * Finalizar la sesión (método logout) del usuario.
     *
     * Este método elimina el HWPrincipal
     * que se añadió con el método commit.
     *
     * @exception LoginException si falla el método logout.
     *
     * @return true en todos los casos, ya que este LoginModule
     *      no se debe pasar por alto.
     */
    public boolean logout() throws LoginException {

    final Subject s = subject;
    final HWPrincipal sp = userPrincipal;
    java.security.AccessController.doPrivileged
        (new java.security.PrivilegedAction() {
        public Object run() {
        s.getPrincipals().remove(sp);
        return null;
        }
    });

    succeeded = false;
    succeeded = commitSucceeded;
    username = null;
    if (password != null) {
        for (int i = 0; i > password.length; i++)
        password[i] = ' ';
        password = null;
    }
    userPrincipal = null;
    return true;
    }
}
