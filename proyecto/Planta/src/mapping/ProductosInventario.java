package mapping;
// Generated 24-may-2015 21:47:34 by Hibernate Tools 4.3.1

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * ProductosInventario generated by hbm2java
 */
public class ProductosInventario implements java.io.Serializable {

    private Integer codigo;
    private NotasDeVenta notasDeVenta;
    private OrdenesCompra ordenesCompra;
    private ProductosHasProveedores productosHasProveedores;
    private Repartidores repartidores;
    private Tranferencias tranferencias;
    private Ubicaciones ubicaciones;
    private BigDecimal peso;
    private BigDecimal precio;
    private BigDecimal costo;
    private String codigoBarras;
    private String estatus;
    private String descripcion;
    private Integer procesosCodigoPadre;
    private Integer procesosCodigoHijo;
    private Date fechaCaducidad;
    private Date fechaCreacion;
    private Integer numeroMatanza;
    private Integer consecutivoProceso;
    private Integer numeroCanal;
    private Set<Mermas> mermas = new HashSet<Mermas>(0);
    private Boolean ProductoMaestro;
    private Boolean reetiquetado; 
    private Boolean menudeo;

    public ProductosInventario() {
    }

    public ProductosInventario(OrdenesCompra ordenesCompra, ProductosHasProveedores productosHasProveedores, Ubicaciones ubicaciones, BigDecimal peso, BigDecimal precio, String estatus) {
        this.ordenesCompra = ordenesCompra;
        this.productosHasProveedores = productosHasProveedores;
        this.ubicaciones = ubicaciones;
        this.peso = peso;
        this.precio = precio;
        this.estatus = estatus;
    }

    public ProductosInventario(NotasDeVenta notasDeVenta, OrdenesCompra ordenesCompra, ProductosHasProveedores productosHasProveedores, Repartidores repartidores, Tranferencias tranferencias, Ubicaciones ubicaciones, BigDecimal peso, BigDecimal precio, String codigoBarras, String estatus, Integer procesosCodigoPadre, Integer procesosCodigoHijo, Date fechaCaducidad, Integer numeroMatanza) {
        this.notasDeVenta = notasDeVenta;
        this.ordenesCompra = ordenesCompra;
        this.productosHasProveedores = productosHasProveedores;
        this.repartidores = repartidores;
        this.tranferencias = tranferencias;
        this.ubicaciones = ubicaciones;
        this.peso = peso;
        this.precio = precio;
        this.codigoBarras = codigoBarras;
        this.estatus = estatus;
        this.procesosCodigoPadre = procesosCodigoPadre;
        this.procesosCodigoHijo = procesosCodigoHijo;
        this.fechaCaducidad = fechaCaducidad;
        this.numeroMatanza = numeroMatanza;
    }

    public Boolean getProductoMaestro() {
        return ProductoMaestro;
    }

    public void setProductoMaestro(Boolean ProductoMaestro) {
        this.ProductoMaestro = ProductoMaestro;
    }

    public Integer getCodigo() {
        return this.codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public NotasDeVenta getNotasDeVenta() {
        return this.notasDeVenta;
    }

    public void setNotasDeVenta(NotasDeVenta notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }

    public OrdenesCompra getOrdenesCompra() {
        return this.ordenesCompra;
    }

    public void setOrdenesCompra(OrdenesCompra ordenesCompra) {
        this.ordenesCompra = ordenesCompra;
    }

    public ProductosHasProveedores getProductosHasProveedores() {
        return this.productosHasProveedores;
    }

    public void setProductosHasProveedores(ProductosHasProveedores productosHasProveedores) {
        this.productosHasProveedores = productosHasProveedores;
    }

    public Repartidores getRepartidores() {
        return this.repartidores;
    }

    public void setRepartidores(Repartidores repartidores) {
        this.repartidores = repartidores;
    }

    public Tranferencias getTranferencias() {
        return this.tranferencias;
    }

    public void setTranferencias(Tranferencias tranferencias) {
        this.tranferencias = tranferencias;
    }

    public Ubicaciones getUbicaciones() {
        return this.ubicaciones;
    }

    public void setUbicaciones(Ubicaciones ubicaciones) {
        this.ubicaciones = ubicaciones;
    }

    public BigDecimal getPeso() {
        return this.peso;
    }

    public void setPeso(BigDecimal peso) {
        this.peso = peso;
    }

    public BigDecimal getPrecio() {
        return this.precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public String getCodigoBarras() {
        return this.codigoBarras;
    }

    public void setCodigoBarras(String codigoBarras) {
        this.codigoBarras = codigoBarras;
    }

    public String getEstatus() {
        return this.estatus;
    }

    public void setEstatus(String estatus) {
        this.estatus = estatus;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Integer getProcesosCodigoPadre() {
        return this.procesosCodigoPadre;
    }

    public void setProcesosCodigoPadre(Integer procesosCodigoPadre) {
        this.procesosCodigoPadre = procesosCodigoPadre;
    }

    public Integer getProcesosCodigoHijo() {
        return this.procesosCodigoHijo;
    }

    public void setProcesosCodigoHijo(Integer procesosCodigoHijo) {
        this.procesosCodigoHijo = procesosCodigoHijo;
    }

    public Date getFechaCaducidad() {
        return this.fechaCaducidad;
    }

    public void setFechaCaducidad(Date fechaCaducidad) {
        this.fechaCaducidad = fechaCaducidad;
    }

    public Integer getNumeroMatanza() {
        return this.numeroMatanza;
    }

    public void setNumeroMatanza(Integer numeroMatanza) {
        this.numeroMatanza = numeroMatanza;
    }

    public Integer getConsecutivoProceso() {
        return consecutivoProceso;
    }

    public void setConsecutivoProceso(Integer consecutivoProceso) {
        this.consecutivoProceso = consecutivoProceso;
    }

    public Integer getNumeroCanal() {
        return numeroCanal;
    }

    public void setNumeroCanal(Integer numeroCanal) {
        this.numeroCanal = numeroCanal;
    }

    public BigDecimal getCosto() {
        return costo;
    }

    public void setCosto(BigDecimal costo) {
        this.costo = costo;
    }

    public Set<Mermas> getMermas() {
        return mermas;
    }

    public void setMermas(Set<Mermas> mermas) {
        this.mermas = mermas;
    }

    public BigDecimal getMermaTotal() {
        BigDecimal mermaTotal = new BigDecimal("0.00");
        for (Mermas merma : this.mermas) {
            mermaTotal = mermaTotal.add(merma.getPeso());
        }
        return mermaTotal;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public Boolean getReetiquetado() {
        return reetiquetado;
    }

    public void setReetiquetado(Boolean reetiquetado) {
        this.reetiquetado = reetiquetado;
    }

    public Boolean getMenudeo() {
        return menudeo;
    }

    public void setMenudeo(Boolean menudeo) {
        this.menudeo = menudeo;
    }

    public String toString() {
        return this.getDescripcion();
    }

    public boolean equals(Object o) {
        if ((this.getCodigo() == null || ((ProductosInventario) o).getCodigo() == null)
                && (this.getCodigoBarras() != null && ((ProductosInventario) o).getCodigoBarras() != null)) {
            if (this.getCodigoBarras().equals(((ProductosInventario) o).getCodigoBarras())) {
                return true;
            } else {
                return false;
            }
        }
        if (o == null || !((ProductosInventario) o).getCodigo().equals(this.getCodigo())) {
            return false;

        } else {
            return true;
        }
    }

    public Object clone() throws CloneNotSupportedException {
        ProductosInventario clon = new ProductosInventario();
        clon.setCodigoBarras(this.getCodigoBarras());
        clon.setConsecutivoProceso(this.getConsecutivoProceso());
        clon.setCosto(this.getCosto());
        clon.setEstatus(this.getEstatus());
        clon.setFechaCaducidad(this.getFechaCaducidad());
        clon.setFechaCreacion(this.fechaCreacion);
        clon.setMermas(this.getMermas());
        clon.setNotasDeVenta(this.getNotasDeVenta());
        clon.setNumeroCanal(this.getNumeroCanal());
        clon.setNumeroMatanza(this.getNumeroMatanza());
        clon.setOrdenesCompra(this.getOrdenesCompra());
        clon.setPeso(this.getPeso());
        clon.setPrecio(this.getPrecio());
        clon.setProcesosCodigoHijo(this.getProcesosCodigoHijo());
        clon.setProcesosCodigoPadre(this.getProcesosCodigoPadre());
        clon.setProductoMaestro(this.getProductoMaestro());
        clon.setProductosHasProveedores(this.getProductosHasProveedores());
        clon.setRepartidores(this.getRepartidores());
        clon.setTranferencias(this.getTranferencias());
        clon.setUbicaciones(this.getUbicaciones());

        return clon;
    }

    public ProductosInventario getBasicClone() {
        ProductosInventario clon = new ProductosInventario();
        clon.setCodigoBarras(this.getCodigoBarras());
        clon.setConsecutivoProceso(this.getConsecutivoProceso());
        clon.setCosto(this.getCosto());
        clon.setEstatus(this.getEstatus());
        clon.setFechaCaducidad(this.getFechaCaducidad());
        clon.setFechaCreacion(this.fechaCreacion);
        clon.setOrdenesCompra(this.getOrdenesCompra());
        clon.setPeso(this.getPeso());
        clon.setPrecio(this.getPrecio());
        clon.setProcesosCodigoHijo(this.getProcesosCodigoHijo());
        clon.setProcesosCodigoPadre(this.getProcesosCodigoPadre());
        clon.setProductosHasProveedores(this.getProductosHasProveedores());
        clon.setRepartidores(this.getRepartidores());
        clon.setUbicaciones(this.getUbicaciones());

        return clon;
    }

}
