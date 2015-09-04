/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.util.List;
import javax.security.auth.Subject;
import mapping.Usuarios;

/**
 *
 * @author 10015097
 */
public class UsuarioFirmado {
    private static Usuarios usuarioFirmado=null;

    public UsuarioFirmado(Usuarios usuario) {
        this.usuarioFirmado=usuario;
    }
    public static Usuarios getUsuarioFirmado() {
        return usuarioFirmado;
    }

    public static void setUsuarioFirmado(Usuarios usuarioFirmado) {
        UsuarioFirmado.usuarioFirmado = usuarioFirmado;
    }
    
    
}
