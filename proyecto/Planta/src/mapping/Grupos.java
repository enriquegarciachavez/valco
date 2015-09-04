package mapping;
// Generated 14/07/2015 09:21:05 AM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Grupos generated by hbm2java
 */
public class Grupos  implements java.io.Serializable {


     private Integer codigo;
     private String grupo;
     private Set usuariosGruposes = new HashSet(0);

    public Grupos() {
    }

	
    public Grupos(String grupo) {
        this.grupo = grupo;
    }
    public Grupos(String grupo, Set usuariosGruposes) {
       this.grupo = grupo;
       this.usuariosGruposes = usuariosGruposes;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public String getGrupo() {
        return this.grupo;
    }
    
    public void setGrupo(String grupo) {
        this.grupo = grupo;
    }
    public Set getUsuariosGruposes() {
        return this.usuariosGruposes;
    }
    
    public void setUsuariosGruposes(Set usuariosGruposes) {
        this.usuariosGruposes = usuariosGruposes;
    }




}


