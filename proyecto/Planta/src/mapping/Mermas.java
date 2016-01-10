/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mapping;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author Administrador
 */
public class Mermas {
    
    Integer codigo;
    BigDecimal peso;
    Date fecha;
    ProductosInventario productosInventario;
    Tranferencias tranferencias;

    public Mermas() {
    }
    
    

    public Mermas(Integer codigo, BigDecimal peso, Date fecha, ProductosInventario productosInventario) {
        this.codigo = codigo;
        this.peso = peso;
        this.fecha = fecha;
        this.productosInventario = productosInventario;
    }

    public Mermas(Integer codigo, BigDecimal peso, Date fecha, ProductosInventario productosInventario, Tranferencias tranferencias) {
        this.codigo = codigo;
        this.peso = peso;
        this.fecha = fecha;
        this.productosInventario = productosInventario;
        this.tranferencias = tranferencias;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public BigDecimal getPeso() {
        return peso;
    }

    public void setPeso(BigDecimal peso) {
        this.peso = peso;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public ProductosInventario getProductosInventario() {
        return productosInventario;
    }

    public void setProductosInventario(ProductosInventario productosInventario) {
        this.productosInventario = productosInventario;
    }

    public Tranferencias getTranferencias() {
        return tranferencias;
    }

    public void setTranferencias(Tranferencias tranferencias) {
        this.tranferencias = tranferencias;
    }

    
    

    
    
    
}
