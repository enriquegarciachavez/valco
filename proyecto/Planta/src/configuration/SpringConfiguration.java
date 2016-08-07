/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package configuration;

import components.CustomDropDown;
import components.NotaVentaTxt;
import components.ProductosTableModel;
import components.ProductosTableModelPOS;
import dao.BarCodeDAO;
import dao.ClienteDAO;
import dao.DAO;
import dao.FiltrableByFather;
import dao.NotaVentaDAOInterface;
import dao.NotasVentaDAO;
import dao.ProductoDAO;
import dao.ProductosDAO;
import dao.ProveedoresDAO;
import dao.ProveedoresKiloDAO;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import panels.PuntoVenta;
import panels.ReciboDeProducto;

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

}
