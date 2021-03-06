/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.ClienteDAO;
import com.valco.dao.NotasVentaDAO;
import com.valco.dao.ProductoDAO;
import com.valco.pojo.Clientes;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.NotasDeVentaView;
import com.valco.pojo.ProductosInventario;
import com.valco.utility.MsgUtility;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.faces.validator.ValidatorException;

/**
 *
 * @author Karlitha
 */
    @ManagedBean
    @ViewScoped
    public class NotasDeVentaMainBean {
    @ManagedProperty(value="#{productoDao}")
    private ProductoDAO productoDao;
    @ManagedProperty(value="#{notadeVentaDao}")
    private NotasVentaDAO notasDeVentaDao;
    @ManagedProperty(value="#{clienteDao}")
    private ClienteDAO clienteDao;
    private List<NotasDeVentaView> notasDeVenta;
    private NotasDeVentaView notaSeleccionada;
    private NotasDeVenta notaNueva;
    private List<ProductosInventario> productosDisponibles;
    private List<ProductosInventario> productosDisponiblesModificacion;
    private UIInput flete;
    private UIInput nota;
    private UIInput fecha;
    private String tipoNota;


    private List<ProductosInventario> productosModificacion;

    public NotasDeVentaMainBean() {
        this.productosSeleccionados = new ArrayList<ProductosInventario>();
        this.notaNueva = new NotasDeVenta();
    }
    
    @PostConstruct
    private void init(){
        try {
            this.clientes = clienteDao.getClientes();
            notasDeVenta = notasDeVentaDao.getNotasDeVentaVendidasView();
        } catch (Exception ex) {
            Logger.getLogger(NotasDeVentaMainBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String resetNotaNueva(){
        notaNueva = new NotasDeVenta();
        productosSeleccionados = new ArrayList<ProductosInventario>();
        tipoNota = "REPARTIDOR";
        return null;
    }
    
    public void prepareNotaLocal(){
        notaNueva = new NotasDeVenta();
        productosSeleccionados = new ArrayList<ProductosInventario>();
        tipoNota = "LOCAL";
    }
    
    public String consultaXFolio(){
	NotasDeVenta aux = new NotasDeVenta();
        try {
            aux = this.notasDeVentaDao.getNotaDeVentaXFolio(notaNueva.getFolio());
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            return null;
        }
        if(aux == null){
            MsgUtility.showErrorMeage("No existe el folio suministrado");
        }else if(aux.getEstatus() == null){
            MsgUtility.showErrorMeage("La nota buscada tiene un problema.");

        }else if(aux.getEstatus().equals("La nota de venta no ha sido asignada a un repartidor")){

            MsgUtility.showErrorMeage("La nota de venta ya fue vendida.");
        }else if(aux.getEstatus().equals("CANCELADA")){

            MsgUtility.showErrorMeage("La nota de venta está cancelada");
        }else if(aux.getEstatus().equals("FACTURADA")){

            MsgUtility.showErrorMeage("La nota de venta ya fue facturada");
        }else if(aux.getEstatus().equals("VENDIDA")){

            MsgUtility.showErrorMeage("La nota de venta ya fue vendida.");
        }else if(aux.getEstatus().equals("ASIGNADA")){
            this.notaNueva = aux;
        }
        return null;
    }
    
    public void validaEstatusActivo(FacesContext context, UIComponent component, Object value) throws ValidatorException {

        NotasDeVenta aux = new NotasDeVenta();
        try {
            aux = this.notasDeVentaDao.getNotaDeVentaXFolio((int)value);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            return;
        }
        if(aux == null){
            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor")); 
        }else if(aux.getEstatus() == null){
            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));

        }else if(aux.getEstatus().equals("La nota de venta no ha sido asignada a un repartidor")){

            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));
        }else if(aux.getEstatus().equals("CANCELADA")){

            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));
        }else if(aux.getEstatus().equals("FACTURADA")){

            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));
        }else if(aux.getEstatus().equals("VENDIDA")){

            throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));
        }else{
            this.notaNueva = aux;
            if(notaNueva == null || notaNueva.getEstatus() == null || !notaNueva.getEstatus().equals("ASIGNADA")){
            throw new ValidatorException(new FacesMessage("La nota de venta no se encuentra activa")); 
        }
        }
    }
    public String ingresarNotaVendida(){
        if(notaNueva == null || notaNueva.getEstatus() == null || !notaNueva.getEstatus().equals("ASIGNADA")){
           //throw new ValidatorException(new FacesMessage("La nota de venta no ha sido suministrada a ningún repartidor"));
                MsgUtility.showErrorMeage("La nota qe intenta utilizar no es valida");
                return null ;
            }
        if(productosSeleccionados == null ||
                productosSeleccionados.isEmpty()){
            
            MsgUtility.showWarnMeage("Debe eleccionar porlomenos un producto.");
            return null;
        }
        
        for(ProductosInventario producto: productosSeleccionados){
            producto.setNotasDeVenta(notaNueva);
            notaNueva.getProductosInventarios().add(producto);
            productosDisponibles.remove(producto);
        }
        try {
            this.notaNueva.setEstatus("VENDIDA");
            this.notasDeVentaDao.actualizarNotaDeVenta(notaNueva);
            //this.notasDeVenta.add(notaNueva);
            this.notasDeVenta= notasDeVentaDao.getNotasDeVentaVendidasView();
            MsgUtility.showInfoMeage("La nota se capturó correctamente.");
        } catch (Exception ex) {
            FacesContext.getCurrentInstance().addMessage(null,
                    new FacesMessage("Ocurriò un error al guardar la nota de venta"));
        }
        return null;
    }
    
    public void modificarNota(){
        if(notaSeleccionada.getNota().getProductosInventariosList() == null ||
                notaSeleccionada.getNota().getProductosInventariosList().isEmpty()){
            flete.setValid(false);
            MsgUtility.showWarnMeage("Debe eleccionar porlomenos un producto.");
            FacesContext.getCurrentInstance().validationFailed();
            return;
        }
        for(ProductosInventario producto: notaSeleccionada.getNota().getProductosInventarios()){
            producto.setNotasDeVenta(null);
        }
        for(ProductosInventario producto: notaSeleccionada.getNota().getProductosInventariosList()){
            producto.setNotasDeVenta(notaSeleccionada.getNota());
            notaSeleccionada.getNota().getProductosInventarios().remove(producto);
        }
        try {
            this.notaSeleccionada.getCuentaXCobrar().setImporte(getTotalSeleccionado(notaSeleccionada.getNota().getProductosInventariosList()));
            this.notasDeVentaDao.actualizarNotaDeVentaVendida(notaSeleccionada.getNota(), notaSeleccionada.getCuentaXCobrar());
            MsgUtility.showInfoMeage("La Nota se actualizo correctamente");
        } catch (Exception ex) {
            FacesContext.getCurrentInstance().addMessage(null,
                    new FacesMessage("Ocurriò un error al guardar la nota de venta"));
        }
    }
    
    public BigDecimal getTotalSeleccionado(List<ProductosInventario> productos){
        DecimalFormat df = new DecimalFormat("0.00");
        BigDecimal total = new BigDecimal(BigInteger.ZERO,2);
        total.setScale(2, BigDecimal.ROUND_HALF_UP);
        if(productos != null && !productos.isEmpty()){
            for(ProductosInventario producto : productos){
                if(producto.getPeso() != null && producto.getPrecio() != null){
                    total = total.add(producto.getPeso().multiply(producto.getPrecio()).setScale(2, RoundingMode.HALF_EVEN));
                }else{
                    MsgUtility.showWarnMeage("Presione enter después de capturar un precio o un peso, de lo contrario el total podía no mostrarse bien");
                }
            }
        }
            return total;
        
    }
    
    public List<ProductosInventario> getProductosDisponiblesModificar() throws Exception {
        for(ProductosInventario producto: notaNueva.getProductosInventariosList()){
            productosDisponibles.add(producto);
        }
        
        return productosDisponibles;
    }
    
    public String obtenerProductosModificacio() throws Exception{
        notaSeleccionada.getNota().setProductosInventariosList(notasDeVentaDao.getProductosXNota(notaSeleccionada.getNota()));
        productosDisponiblesModificacion = notasDeVentaDao.getProductosDisponibles();
        productosDisponiblesModificacion.addAll(0,notaSeleccionada.getNota().getProductosInventariosList());
        return null;
    }
    
    public void cancelarNotaVendida(){
        if(notaSeleccionada.getNota() == null || notaSeleccionada.getNota().getCodigo() ==null){
            MsgUtility.showWarnMeage("Debe seleccionar una nota.");
            return;
        }
        try {
            notasDeVentaDao.cancelarNotaVendida(notaSeleccionada.getNota());
            notasDeVenta.remove(notaSeleccionada);
        } catch (Exception ex) {
            FacesContext.getCurrentInstance().addMessage(null,
                    new FacesMessage("Ocurriò un error al cancelar la nota"));
        }
    }
    
    public void validaProductosSeleccionadosAlta(FacesContext context, UIComponent component, Object value) throws ValidatorException{
        if(false && (productosSeleccionados == null ||
                productosSeleccionados.isEmpty())){         
            throw new ValidatorException(MsgUtility.getWarnMessage("Debe seleccionar porlomenos un producto."));
        }
    }
    
    public void validaProductosSeleccionadosModificacion(FacesContext context, UIComponent component, Object value) throws ValidatorException{
        if(false && notaSeleccionada.getNota().getProductosInventariosList() == null ||
                notaSeleccionada.getNota().getProductosInventariosList().isEmpty()){         
            throw new ValidatorException(MsgUtility.getWarnMessage("Debe seleccionar porlomenos un producto."));
        }
    }
    
    public String cargaProductosDeNota(){
        try {
            if(notaNueva == null || notaNueva.getEstatus() == null || !notaNueva.getEstatus().equals("ASIGNADA")){
                MsgUtility.showErrorMeage("La nota qe intenta utilizar no es valida");
                return null;
            }
            if("REPARTIDOR".equals(tipoNota)){
                this.productosDisponibles= productoDao.getProductosEnTransito(notaNueva.getRepartidores());
            }else{
                this.productosDisponibles = notasDeVentaDao.getProductosDisponibles();
            }
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
        return null;
        
    }
        
    public List<ProductosInventario> getProductosDisponibles() {
        return productosDisponibles;
    }

    public void setProductosDisponibles(List<ProductosInventario> productosDisponibles) {
        this.productosDisponibles = productosDisponibles;
    }

    public List<ProductosInventario> getProductosSeleccionados() {
        return productosSeleccionados;
    }

    public void setProductosSeleccionados(List<ProductosInventario> productosSeleccionados) {
        this.productosSeleccionados = productosSeleccionados;
    }
    List<Clientes> clientes;
    private List<ProductosInventario> productosSeleccionados;

    

    public ClienteDAO getClienteDao() {
        return clienteDao;
    }

    public void setClienteDao(ClienteDAO clienteDao) {
        this.clienteDao = clienteDao;
    }

    public List<Clientes> getClientes() {
        return clientes;
    }

    public void setClientes(List<Clientes> clientes) {
        this.clientes = clientes;
    }

    public NotasDeVenta getNotaNueva() {
        return notaNueva;
    }

    public void setNotaNueva(NotasDeVenta notaNueva) {
        this.notaNueva = notaNueva;
    }

    public NotasVentaDAO getNotasDeVentaDao() {
        return notasDeVentaDao;
    }

    public void setNotasDeVentaDao(NotasVentaDAO notasDeVentaDao) {
        this.notasDeVentaDao = notasDeVentaDao;
    }

    public List<NotasDeVentaView> getNotasDeVenta() {
        return notasDeVenta;
    }

    public void setNotasDeVenta(List<NotasDeVentaView> notasDeVenta) {
        this.notasDeVenta = notasDeVenta;
    }

    public NotasDeVentaView getNotaSeleccionada() {
        return notaSeleccionada;
    }

    public void setNotaSeleccionada(NotasDeVentaView notaSeleccionada) {
        this.notaSeleccionada = notaSeleccionada;
    }

    
    
    public List<ProductosInventario> getProductosModificacion() {
        return productosModificacion;
    }

    public void setProductosModificacion(List<ProductosInventario> productosModificacion) {
        this.productosModificacion = productosModificacion;
    }
    
    public List<ProductosInventario> getProductosDisponiblesModificacion() {
        return productosDisponiblesModificacion;
    }

    public void setProductosDisponiblesModificacion(List<ProductosInventario> productosDisponiblesModificacion) {
        this.productosDisponiblesModificacion = productosDisponiblesModificacion;
    }
    
    public UIInput getFlete() {
        return flete;
    }

    public void setFlete(UIInput flete) {
        this.flete = flete;
    }

    public UIInput getNota() {
        return nota;
    }

    public void setNota(UIInput nota) {
        this.nota = nota;
    }

    public UIInput getFecha() {
        return fecha;
    }

    public void setFecha(UIInput fecha) {
        this.fecha = fecha;
    }

    public ProductoDAO getProductoDao() {
        return productoDao;
    }

    public void setProductoDao(ProductoDAO productoDao) {
        this.productoDao = productoDao;
    }

    public String getTipoNota() {
        return tipoNota;
    }

    public void setTipoNota(String tipoNota) {
        this.tipoNota = tipoNota;
    }
    
    
    
    
    


    
}
