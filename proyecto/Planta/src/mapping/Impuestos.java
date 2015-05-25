package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1


import java.math.BigDecimal;

/**
 * Impuestos generated by hbm2java
 */
public class Impuestos  implements java.io.Serializable {


     private Integer codigo;
     private Facturas facturas;
     private String impuesto;
     private BigDecimal tasa;
     private BigDecimal importe;

    public Impuestos() {
    }

    public Impuestos(Facturas facturas, String impuesto, BigDecimal tasa, BigDecimal importe) {
       this.facturas = facturas;
       this.impuesto = impuesto;
       this.tasa = tasa;
       this.importe = importe;
    }
   
    public Integer getCodigo() {
        return this.codigo;
    }
    
    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }
    public Facturas getFacturas() {
        return this.facturas;
    }
    
    public void setFacturas(Facturas facturas) {
        this.facturas = facturas;
    }
    public String getImpuesto() {
        return this.impuesto;
    }
    
    public void setImpuesto(String impuesto) {
        this.impuesto = impuesto;
    }
    public BigDecimal getTasa() {
        return this.tasa;
    }
    
    public void setTasa(BigDecimal tasa) {
        this.tasa = tasa;
    }
    public BigDecimal getImporte() {
        return this.importe;
    }
    
    public void setImporte(BigDecimal importe) {
        this.importe = importe;
    }




}


