/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.valco.dao.FamiliasDAO;
import com.valco.dao.ProductoDAO;
import com.valco.dao.SubfamiliasDAO;
import com.valco.dao.TipoProductoDAO;
import com.valco.dao.UnidadesDeMedidaDAO;
import com.valco.pojo.Familias;
import com.valco.pojo.Productos;
import com.valco.pojo.Subfamilias;
import com.valco.pojo.TipoProducto;
import com.valco.pojo.UnidadesDeMedida;
import com.valco.utility.MsgUtility;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.component.UISelectBoolean;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;
import javax.faces.validator.ValidatorException;

/**
 *
 * @author Enrique
 */
@ManagedBean
@ViewScoped
public class ProductoMainBean {
    
    @ManagedProperty(value = "#{productoDao}")
            private ProductoDAO productoDao;
    @ManagedProperty(value = "#{unidadesdemedidaDao}")
            private UnidadesDeMedidaDAO unidadesdemedidaDao;
    @ManagedProperty(value = "#{tipoproductoDao}")
            private TipoProductoDAO tipoproductoDao;
    List<Productos> productos;
    List<TipoProducto> tipoProducto;
    List<UnidadesDeMedida> unidadesDeMedida;
    Productos productoNuevo = new Productos();
    Productos productoSeleccionado;
    DataModel modeloProducto;
    UIInput descripcion;
    UIInput codigo;
    UISelectBoolean abarrotes;
    UISelectBoolean iva;
    UISelectBoolean incluyeViscera;
    UISelectBoolean generarSubproducto;
    UISelectBoolean aplicaInventarioFisico;
    @ManagedProperty(value = "#{familiasDAO}")
    private FamiliasDAO familiasDAO;
    @ManagedProperty(value = "#{subfamiliasDAO}")
    private SubfamiliasDAO subfamiliasDAO;
    List<Familias> familias = new ArrayList<>();
    List<Subfamilias> subfamilias = new ArrayList<>();
    Familias familiaSelecionada= new Familias();
    
    
    /**
     * Creates a new instance of ProductoMainBean
     */
    public ProductoMainBean() {
    }
    
    public void validarProductoSeleccionado(ActionEvent actionEvent) {
       
            if(productoSeleccionado == null){
                MsgUtility.showErrorMeage("Debe seleccionar un Producto");
                FacesContext.getCurrentInstance().validationFailed();
                
            }else{
                familiaSelecionada = productoSeleccionado.getSubfamilias().getFamilias();
                try {
                    subfamilias = subfamiliasDAO.getSubfamilias(familiaSelecionada);
                } catch (Exception ex) {
                    Logger.getLogger(ProductoMainBean.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            
       
    }

    public Familias getFamiliaSelecionada() {
        return familiaSelecionada;
    }
    
    public void obtenerSubfamiliasXFamilias(){
        try {
            this.subfamilias= subfamiliasDAO.getSubfamilias(familiaSelecionada);
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void setFamiliaSelecionada(Familias familiaSelecionada) {
        this.familiaSelecionada = familiaSelecionada;
    }
    

    public List<Familias> getFamilias() {
        return familias;
    }

    public void setFamilias(List<Familias> familias) {
        this.familias = familias;
    }

    public List<Subfamilias> getSubfamilias() {
        return subfamilias;
    }

    public void setSubfamilias(List<Subfamilias> subfamilias) {
        this.subfamilias = subfamilias;
    }
    
    public FamiliasDAO getFamiliasDAO() {
        return familiasDAO;
    }

    public void setFamiliasDAO(FamiliasDAO familiasDAO) {
        this.familiasDAO = familiasDAO;
    }

    public SubfamiliasDAO getSubfamiliasDAO() {
        return subfamiliasDAO;
    }

    public void setSubfamiliasDAO(SubfamiliasDAO subfamiliasDAO) {
        this.subfamiliasDAO = subfamiliasDAO;
    }
    
    public UnidadesDeMedidaDAO getUnidadesdemedidaDao() {
        return unidadesdemedidaDao;
    }

    public void setUnidadesdemedidaDao(UnidadesDeMedidaDAO unidadesdemedidaDao) {
        this.unidadesdemedidaDao = unidadesdemedidaDao;
    }

    public TipoProductoDAO getTipoproductoDao() {
        return tipoproductoDao;
    }

    public void setTipoproductoDao(TipoProductoDAO tipoproductoDao) {
        this.tipoproductoDao = tipoproductoDao;
    }
    
    

    public ProductoDAO getProductoDao() {
        return productoDao;
    }

    public void setProductoDao(ProductoDAO productoDao) {
        this.productoDao = productoDao;
    }

    public List<Productos> getProductos() {
        return productos;
    }

    public void setProductos(List<Productos> productos) {
        this.productos = productos;
    }

    public List<TipoProducto> getTipoProducto() {
        return tipoProducto;
    }

    public void setTipoProducto(List<TipoProducto> tipoProducto) {
        this.tipoProducto = tipoProducto;
    }

    public List<UnidadesDeMedida> getUnidadesDeMedida() {
        return unidadesDeMedida;
    }

    public void setUnidadesDeMedida(List<UnidadesDeMedida> unidadesDeMedida) {
        this.unidadesDeMedida = unidadesDeMedida;
    }

    public Productos getProductoNuevo() {
        return productoNuevo;
    }

    public void setProductoNuevo(Productos productoNuevo) {
        this.productoNuevo = productoNuevo;
    }

    public Productos getProductoSeleccionado() {
        return productoSeleccionado;
    }

    public void setProductoSeleccionado(Productos productoSeleccionado) {
        this.productoSeleccionado = productoSeleccionado;
    }

    public DataModel getModeloProducto() {
        try {
            productos = productoDao.getProductos();
            modeloProducto = new ListDataModel(productos);
            return modeloProducto;
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
            return modeloProducto;
        }
    }

    public void setModeloProducto(DataModel modeloProducto) {
        this.modeloProducto = modeloProducto;
    }

    public UIInput getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(UIInput descripcion) {
        this.descripcion = descripcion;
    }

    public UISelectBoolean getIncluyeViscera() {
        return incluyeViscera;
    }

    public void setIncluyeViscera(UISelectBoolean incluyeViscera) {
        this.incluyeViscera = incluyeViscera;
    }

    public UISelectBoolean getGenerarSubproducto() {
        return generarSubproducto;
    }

    public void setGenerarSubproducto(UISelectBoolean generarSubproducto) {
        this.generarSubproducto = generarSubproducto;
    }

    public UISelectBoolean getAplicaInventarioFisico() {
        return aplicaInventarioFisico;
    }

    public void setAplicaInventarioFisico(UISelectBoolean aplicaInventarioFisico) {
        this.aplicaInventarioFisico = aplicaInventarioFisico;
    }

    public UIInput getCodigo() {
        return codigo;
    }

    public void setCodigo(UIInput codigo) {
        this.codigo = codigo;
    }

    public UISelectBoolean getAbarrotes() {
        return abarrotes;
    }

    public void setAbarrotes(UISelectBoolean abarrotes) {
        this.abarrotes = abarrotes;
    }

    public UISelectBoolean getIva() {
        return iva;
    }

    public void setIva(UISelectBoolean iva) {
        this.iva = iva;
    }
    
    
    
    
    
    public void actualizarProducto() {
        try {
            productoDao.actualizarProducto(productoSeleccionado);
            MsgUtility.showInfoMeage("El producto se actualizó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }

    }

    public void insertarProducto() {
        try {
            productoNuevo.setEstatus("ACTIVO");
            productoDao.insertarProducto(productoNuevo);
            MsgUtility.showInfoMeage("El producto se insertó con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }

    public void borrarProducto() {
        try {
            productoDao.borrarProducto(productoSeleccionado);
            productos.remove(productoSeleccionado);
            MsgUtility.showInfoMeage("El producto se borró con éxito");
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void limpiarIngresarForm() {
        
        incluyeViscera.setValue(false);
        generarSubproducto.setValue(false);
        aplicaInventarioFisico.setValue(false);
        iva.setValue(false);
        abarrotes.setValue(false);
    }
    
    
    public void inicializarProducto() {
        this.productoNuevo = new Productos();
        
    }
    
    @PostConstruct
        public void init(){
        try {
            this.unidadesDeMedida = unidadesdemedidaDao.getUnidadesDeMedida();
            this.tipoProducto = tipoproductoDao.getTipoProducto();
            this.familias= familiasDAO.getFamilias();
            
        } catch (Exception ex) {
            MsgUtility.showErrorMeage(ex.getMessage());
        }
    }
    
    public void validarDescripcion(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Productos descripcion = null;
        descripcion = 
                this.productoDao.getProductosXDescripcion(value.toString());
        if(descripcion != null){
            throw new ValidatorException(new FacesMessage("El producto que capturó ya existe")); 
        }
        
    }
    public void validarModificarDescripcion(FacesContext context, UIComponent component, Object value) throws ValidatorException, Exception {
        Productos descripcion = null;
        descripcion
                = this.productoDao.getProductosXDescripcion(value.toString());
        if (descripcion != null) {
            if (descripcion.getCodigo() != productoSeleccionado.getCodigo()) {
                throw new ValidatorException(new FacesMessage("La razón social que capturó ya existe"));
            }
        }

    }
    
}
