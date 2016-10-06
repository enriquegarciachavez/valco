/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package configuration;

import components.CustomCellRendered;
import components.CustomDropDown;
import components.NotaVentaTxt;
import components.ProductosTableModel;
import components.ProductosTableModelPOS;
import components.ProductosTableModelProceso;
import components.ProductosTableModelReetiquetado;
import components.TablaProductos;
import dao.BarCodeDAO;
import dao.ClienteDAO;
import dao.DAO;
import dao.FiltrableByFather;
import dao.NotaVentaDAOInterface;
import dao.NotasVentaDAO;
import dao.ProcesosDAO;
import dao.ProcesosDAOImpl;
import dao.ProductoDAO;
import dao.ProductosDAO;
import dao.ProveedoresDAO;
import dao.ProveedoresKiloDAO;
import dao.ReetiquetadoDAO;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import panels.EtiquetadoPanel;
import panels.PuntoVenta;
import panels.ReciboDeProducto;
import table.custom.EtiquetadoTableCellRendered;

/**
 *
 * @author Administrador
 */
@Configuration
public class SpringConfiguration {

    @Scope("prototype")
    @Bean
    public DAO clientesDAO() {
        return new ClienteDAO();
    }

    @Scope("prototype")
    @Bean
    public CustomDropDown clienteDropDown() {
        CustomDropDown productosSelection = new CustomDropDown();
        productosSelection.setDao(clientesDAO());
        productosSelection.setEtiqueta("Cliente:");
        productosSelection.init();
        return productosSelection;
    }

    @Scope("prototype")
    @Bean
    public NotaVentaDAOInterface notaVentaDAO() {
        return new NotasVentaDAO();

    }

    @Scope("prototype")
    @Bean
    public NotaVentaTxt notaVentaTxt() {
        NotaVentaTxt notaVentaTxt = new NotaVentaTxt();
        notaVentaTxt.setNotasDAO(notaVentaDAO());
        return notaVentaTxt;

    }

    @Scope("prototype")
    @Bean
    public DAO proveedoresKiloDAO() {
        return new ProveedoresKiloDAO();
    }

    @Scope("prototype")
    @Bean
    public CustomDropDown productosSelection() {
        CustomDropDown productosSelection = new CustomDropDown();
        productosSelection.setDao(productosDAO());
        productosSelection.setDaoFather((FiltrableByFather) productosDAO());
        productosSelection.setEtiqueta("Producto:");
        productosSelection.init();
        return productosSelection;

    }

    @Scope("prototype")
    @Bean
    public DAO productosDAO() {
        return new ProductoDAO();
    }

    @Scope("prototype")
    @Bean
    public ProductosTableModel tableModelPOS() {
        return new ProductosTableModelPOS();
    }

    @Scope("prototype")
    @Bean
    public BarCodeDAO barCodeDAO() {
        return new ProductoDAO();
    }

    @Scope("prototype")
    @Bean
    public PuntoVenta puntoDeVenta() {
        PuntoVenta puntoDeVenta = new PuntoVenta();
        puntoDeVenta.setTableModel(tableModelPOS());
        puntoDeVenta.setDao(barCodeDAO());
        puntoDeVenta.setProductoDAO((ProductosDAO) productosDAO());
        puntoDeVenta.setProductosDropDown(productosSelection());
        puntoDeVenta.setNotaVentaTxt(notaVentaTxt());
        puntoDeVenta.setClienteDropDown(clienteDropDown());
        puntoDeVenta.setNotaVentaDAO(notaVentaDAO());
        puntoDeVenta.init();
        return puntoDeVenta;
    }

    @Scope("prototype")
    @Bean
    public CustomDropDown proveedoresSelectionKilo() {
        CustomDropDown proveedorSelection = new CustomDropDown();
        proveedorSelection.setDao(proveedoresKiloDAO());
        proveedorSelection.setChild(productosSelection());
        proveedorSelection.setEtiqueta("Proveedor:");
        proveedorSelection.init();
        proveedorSelection.reloadChild();
        return proveedorSelection;

    }

    @Scope("prototype")
    @Bean
    public ReciboDeProducto reciboDeProducto() {
        CustomDropDown proveedorSelectionKilo = proveedoresSelectionKilo();
        ReciboDeProducto reciboDeProducto = new ReciboDeProducto();
        reciboDeProducto.setProveedorSelection(proveedorSelectionKilo);
        reciboDeProducto.setProductosSelection(proveedorSelectionKilo.getChild());
        reciboDeProducto.init();
        return reciboDeProducto;
    }
    
    @Scope("prototype")
    @Bean
    public ProductosTableModel tableProcesos(){
        return new ProductosTableModelProceso();
    }

    @Scope("prototype")
    @Bean
    public ProcesosDAO procesosDAOImpl() {
        return new ProcesosDAOImpl();
    }
    
    @Scope("prototype")
    @Bean
    public CustomCellRendered etiquetadoCellRendered(){
        EtiquetadoTableCellRendered cellRendered = new EtiquetadoTableCellRendered();
        cellRendered.setEstatusColumn(4);
        return cellRendered;
    }

    @Scope("prototype")
    @Bean
    public EtiquetadoPanel etiquetadoPanel() {
        EtiquetadoPanel panel = new EtiquetadoPanel(false);
        panel.setCajasProcesoDAO(procesosDAOImpl());
        panel.setModel(tableProcesos());
        panel.setCellRendered(etiquetadoCellRendered());
       panel.init();
        return panel;
    }
    
    @Scope("prototype")
    @Bean
    public ProductosTableModel tableReetiquetado(){
        return new ProductosTableModelReetiquetado();
    }

    @Scope("prototype")
    @Bean
    public ProcesosDAO reetiquetadoDAOImpl() {
        return new ReetiquetadoDAO();
    }
    
    @Scope("prototype")
    @Bean
    public CustomCellRendered reetiquetadoCellRendered(){
        EtiquetadoTableCellRendered cellRendered = new EtiquetadoTableCellRendered();
        cellRendered.setEstatusColumn(3);
        return cellRendered;
    }

    @Scope("prototype")
    @Bean
    public EtiquetadoPanel reetiquetadoPanel() {
        EtiquetadoPanel panel = new EtiquetadoPanel(true);
        panel.setCajasProcesoDAO(reetiquetadoDAOImpl());
        panel.setModel(tableReetiquetado());
        panel.setCellRendered(reetiquetadoCellRendered());
        panel.init();
        return panel;
    }

}