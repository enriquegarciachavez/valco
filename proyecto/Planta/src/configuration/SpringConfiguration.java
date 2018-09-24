/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package configuration;

import components.BarCodeArea;
import components.BarCodeTxt;
import components.BasculaPanel;
import components.CustomCellRendered;
import components.CustomDropDown;
import components.NotaVentaTxt;
import components.ProductosTableModel;
import components.ProductosTableModelPOS;
import components.ProductosTableModelProceso;
import components.ProductosTableModelReetiquetado;
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
import dao.ProductosHasProveedoresDao;
import dao.ProveedoresKiloDAO;
import dao.ReetiquetadoDAO;
import dao.RepartidoresDAO;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import panels.AbrirCajaPanel;
import panels.AsignacionProductoRepartidor;
import panels.EtiquetadoPanel;
import panels.PuntoVenta;
import panels.ReciboDeProducto;
import panels.ReciboDeProductoSinBC;
import panels.VentasPanel;
import service.AsignacionServiceImpl;
import service.BasculaService;
import service.BasculaServiceImpl;
import service.ProductosService;
import service.ProductosServiceImpl;
import service.TransactionService;
import table.custom.EtiquetadoTableCellRendered;

/**
 *
 * @author Administrador
 */
@Configuration
public class SpringConfiguration {

    @Bean
    public DAO clientesDAO() {
        return new ClienteDAO();
    }
    
    @Bean
    public DAO repartidoresDAO(){
        return new RepartidoresDAO();
    }
    
    @Bean
    public DAO proveedoresKiloDAO() {
        return new ProveedoresKiloDAO();
    }
    
    @Bean
    public DAO productosDAO() {
        return new ProductoDAO();
    }
    
    @Bean
    public DAO productoHasProveedoresDAO() {
        return new ProductosHasProveedoresDao();
    }

    @Bean
    public BarCodeDAO barCodeDAO() {
        return new ProductoDAO();
    }
    
    @Bean
    public ProcesosDAO procesosDAOImpl() {
        return new ProcesosDAOImpl();
    }
    
    @Bean
    public ProcesosDAO reetiquetadoDAOImpl() {
        return new ReetiquetadoDAO();
    }
    
    @Bean
    public NotaVentaDAOInterface notaVentaDAO() {
        return new NotasVentaDAO();
    }
    
    @Bean
    public ProductosHasProveedoresDao pHasProDao(){
        return new ProductosHasProveedoresDao();
    }
    
    @Scope("prototype")
    @Bean
    public BasculaService basculaService(){
        return new BasculaServiceImpl();
    }
    
    @Scope("prototype")
    @Bean
    public ProductosService productosService(){
        ProductosServiceImpl service = new ProductosServiceImpl();
        service.setProductoDAO((ProductoDAO) productosDAO());
        service.setpHasPro(pHasProDao());
        return service;
    }
    
    @Scope("prototype")
    @Bean
    public TransactionService asignacionService(){
        AsignacionServiceImpl service = new AsignacionServiceImpl();
        service.setProductoDAO((ProductoDAO) productosDAO());
        return service;
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
    public BarCodeTxt barCodeTxt(){
        BarCodeTxt panel = new BarCodeTxt();
        panel.setProveedoresDropDown(proveedoresSelectionKilo());
        panel.setProductoExistente(true);
        panel.setProductosDAO((ProductoDAO) productosDAO());
        panel.setModoOperacion("SALIDA");
        return panel;
    }
    
    @Scope("prototype")
    @Bean
    public BarCodeArea barCodeArea(){
        BarCodeArea panel = new BarCodeArea();
        panel.setProveedoresDropDown(proveedoresSelectionKilo());
        panel.init();
        return panel;
    }

    @Scope("prototype")
    @Bean
    public CustomDropDown repartidoresDropDown() {
        CustomDropDown dropDown = new CustomDropDown();
        dropDown.setDao(repartidoresDAO());
        dropDown.setEtiqueta("Repartidor:");
        dropDown.init();
        return dropDown;
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
    public CustomDropDown productosHasProveedoresSelection() {
        CustomDropDown productosSelection = new CustomDropDown();
        productosSelection.setDao(productoHasProveedoresDAO());
        productosSelection.setDaoFather((FiltrableByFather) productosDAO());
        productosSelection.setEtiqueta("Producto:");
        productosSelection.init();
        return productosSelection;

    }

    @Scope("prototype")
    @Bean
    public ProductosTableModel tableModelPOS() {
        return new ProductosTableModelPOS();
    }
    
    @Bean
    public BasculaPanel basculaPanel() {
        BasculaPanel panel = new BasculaPanel();
        panel.init();
        return panel;
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
        proveedorSelection.setEtiqueta("Proveedor:");
        proveedorSelection.init();
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
        panel.setBasculaPanel1(basculaPanel());
        panel.init();
        return panel;
    }
    
    @Scope("prototype")
    @Bean
    public ReciboDeProductoSinBC reciboDeProductoSinBc() {
        ReciboDeProductoSinBC reciboDeProducto = new ReciboDeProductoSinBC();
        reciboDeProducto.setProveedoresDropdown(proveedoresSelectionKilo());
        reciboDeProducto.setProductosDropDown(productosSelection());
        reciboDeProducto.setBascula(basculaPanel());
        reciboDeProducto.setModel(tableProcesos());
        reciboDeProducto.setCellRendered(etiquetadoCellRendered());
        reciboDeProducto.setProductosDao((ProductoDAO) productosDAO());
        reciboDeProducto.init();
        return reciboDeProducto;
    }
    
    @Scope("prototype")
    @Bean
    public ProductosTableModel tableReetiquetado(){
        return new ProductosTableModelReetiquetado();
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
    public AbrirCajaPanel abrirCajaPanel(){
        AbrirCajaPanel panel = new AbrirCajaPanel();
        panel.setBarCode(barCodeTxt());
        panel.setBascula(basculaPanel());
        panel.setBasculaService(basculaService());
        panel.setModel(tableProcesos());
        panel.setCellRendered(etiquetadoCellRendered());
        panel.setProductosDAO((ProductoDAO) productosDAO());
        panel.init();
        return panel;
    }
    
    @Scope("prototype")
    @Bean
    public VentasPanel ventasPanel() {
        VentasPanel panel = new VentasPanel();
        panel.setAbrirCajaPanel(abrirCajaPanel());
        panel.init();
        return panel;
    }
    
    @Scope("prototype")
    @Bean
    public EtiquetadoPanel reetiquetadoPanel() {
        EtiquetadoPanel panel = new EtiquetadoPanel(true);
        panel.setCajasProcesoDAO(reetiquetadoDAOImpl());
        panel.setModel(tableReetiquetado());
        panel.setCellRendered(reetiquetadoCellRendered());
        panel.setBasculaPanel1(basculaPanel());
        panel.setReetiquetado(true);
        panel.init();
        return panel;
    }

    @Scope("prototype")
    @Bean
    public AsignacionProductoRepartidor asignacionRepartidorEntrada(){
        AsignacionProductoRepartidor panel = new AsignacionProductoRepartidor("ENTRADA");
        CustomDropDown proveedoresDropDown = proveedoresSelectionKilo();
        CustomDropDown productosDropDown = productosSelection();
        productosDropDown.setFather(proveedoresDropDown);
        proveedoresDropDown.setChild(productosDropDown);
        productosDropDown.init();
        proveedoresDropDown.reloadChild();
        panel.setBasculaPanel(basculaPanel());
        panel.setBarCodeArea(barCodeArea());
        panel.setProductosDropDown(productosDropDown);
        panel.setRepartidoresDropDown(repartidoresDropDown());
        panel.setProveedoresDropDown(proveedoresDropDown);
        panel.setProductoDAO((ProductoDAO) productosDAO());
        panel.setpHasPro(pHasProDao());
        panel.setModel(tableProcesos());
        panel.setCellRendered(etiquetadoCellRendered());
        panel.setBasculaService(basculaService());
        panel.setProductosService(productosService());
        panel.setTransactionService(asignacionService());
        panel.init();
        return panel;
    }
    
    @Scope("prototype")
    @Bean
    public AsignacionProductoRepartidor asignacionRepartidorSalida(){
        AsignacionProductoRepartidor panel = new AsignacionProductoRepartidor("SALIDA");
        CustomDropDown proveedoresDropDown = proveedoresSelectionKilo();
        CustomDropDown productosDropDown = productosSelection();
        productosDropDown.setFather(proveedoresDropDown);
        proveedoresDropDown.setChild(productosDropDown);
        productosDropDown.init();
        proveedoresDropDown.reloadChild();
        panel.setBasculaPanel(basculaPanel());
        panel.setBarCodeArea(barCodeArea());
        panel.setProductosDropDown(productosDropDown);
        panel.setRepartidoresDropDown(repartidoresDropDown());
        panel.setProveedoresDropDown(proveedoresDropDown);
        panel.setProductoDAO((ProductoDAO) productosDAO());
        panel.setpHasPro(pHasProDao());
        panel.setModel(tableProcesos());
        panel.setCellRendered(etiquetadoCellRendered());
        panel.setBasculaService(basculaService());
        panel.setProductosService(productosService());
        panel.setTransactionService(asignacionService());
        panel.init();
        return panel;
    }
    
    @Scope("prototype")
    @Bean
    public AsignacionProductoRepartidor inventarioInicial(){
        AsignacionProductoRepartidor panel = new AsignacionProductoRepartidor("SALIDA");
        CustomDropDown proveedoresDropDown = proveedoresSelectionKilo();
        CustomDropDown productosDropDown = productosSelection();
        productosDropDown.setFather(proveedoresDropDown);
        proveedoresDropDown.setChild(productosDropDown);
        productosDropDown.init();
        proveedoresDropDown.reloadChild();
        panel.setBasculaPanel(basculaPanel());
        panel.setBarCodeArea(barCodeArea());
        panel.setProductosDropDown(productosDropDown);
        panel.setRepartidoresDropDown(repartidoresDropDown());
        panel.setProveedoresDropDown(proveedoresDropDown);
        panel.setProductoDAO((ProductoDAO) productosDAO());
        panel.setpHasPro(pHasProDao());
        panel.setModel(tableProcesos());
        panel.setCellRendered(etiquetadoCellRendered());
        panel.setBasculaService(basculaService());
        panel.setProductosService(productosService());
        panel.setTransactionService(asignacionService());
        panel.setInventarioInicial(true);
        panel.init();
        return panel;
    }
}