/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mapping;

/**
 *
 * @author Administrador
 */
public class ProveedoresCodigo implements java.io.Serializable{

    private Integer codigo;
    private int posicionPesoInicial;
    private int posicionPesoFinal;
    private int posicionCodigoInicial;
    private int posicionCodigoFinal;
    private int decimales;
    private int longMinima;
    private int longMaxima;
    private Proveedores proveedor;

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public int getPosicionPesoInicial() {
        return posicionPesoInicial;
    }

    public void setPosicionPesoInicial(int posicionPesoInicial) {
        this.posicionPesoInicial = posicionPesoInicial;
    }

    public int getPosicionPesoFinal() {
        return posicionPesoFinal;
    }

    public void setPosicionPesoFinal(int posicionPesoFinal) {
        this.posicionPesoFinal = posicionPesoFinal;
    }

    public int getPosicionCodigoInicial() {
        return posicionCodigoInicial;
    }

    public void setPosicionCodigoInicial(int posicionCodigoInicial) {
        this.posicionCodigoInicial = posicionCodigoInicial;
    }

    public int getPosicionCodigoFinal() {
        return posicionCodigoFinal;
    }

    public void setPosicionCodigoFinal(int posicionCodigoFinal) {
        this.posicionCodigoFinal = posicionCodigoFinal;
    }

    public int getDecimales() {
        return decimales;
    }

    public void setDecimales(int decimales) {
        this.decimales = decimales;
    }

    public int getLongMinima() {
        return longMinima;
    }

    public void setLongMinima(int longMinima) {
        this.longMinima = longMinima;
    }

    public int getLongMaxima() {
        return longMaxima;
    }

    public void setLongMaxima(int longMaxima) {
        this.longMaxima = longMaxima;
    }

    public Proveedores getProveedor() {
        return proveedor;
    }

    public void setProveedor(Proveedores proveedor) {
        this.proveedor = proveedor;
    }
    
    public int getHashCode(){
        return hashCode();
    }
    
    public int hashCode(){
        String hash =1+""+posicionPesoInicial+""+posicionPesoFinal+""+
                posicionCodigoInicial+""+posicionCodigoFinal;
        return Integer.parseInt(hash);
    }
    
    @Override
    public boolean equals(Object o) {
        if (o != null) {
            if ((o instanceof ProveedoresCodigo)
                    && (((ProveedoresCodigo) o).getPosicionPesoInicial() == this.getPosicionPesoInicial())
                    && (((ProveedoresCodigo) o).getPosicionPesoFinal() == this.getPosicionPesoFinal())
                    && (((ProveedoresCodigo) o).getPosicionCodigoInicial() == this.getPosicionCodigoInicial())
                    && (((ProveedoresCodigo) o).getPosicionCodigoFinal() == this.getPosicionCodigoFinal())) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

}
