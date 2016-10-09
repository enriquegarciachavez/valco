/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import dao.ProductoDAO;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import mapping.ProductosHasProveedores;
import mapping.ProductosHasProveedoresView;
import mapping.ProductosInventario;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import panels.EtiquetadoPanel;
import utilities.ProductosUtility;

/**
 *
 * @author Administrador
 */
public class TestEtiquetadoPanel {

    public TestEtiquetadoPanel() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() {
    }

    @After
    public void tearDown() {
    }

    @Test
    public void testEtiquetadoPanleInit() {

    }

    @Test
    public void testGetProductosHasProveedoresByBarCode() {
        ProductoDAO productoDAO = new ProductoDAO();
        try {
            List<ProductosHasProveedoresView> productosHasProveedores = productoDAO.getProductosHasProveedoresView();
            System.out.println(productosHasProveedores.size());
            ProductosHasProveedores productoProveedor = ProductosUtility.getProductosHasProveedoresByBarCode(productosHasProveedores, "00000000160000000000");
            assertNotNull("Fallo por que no se encontro el producto proveedor", productoProveedor);
            assertEquals(productoProveedor.getCodigo().intValue(), 5);
            assertNull(ProductosUtility.getProductosHasProveedoresByBarCode(new ArrayList<ProductosHasProveedoresView>(), "00000000160000000000"));
            assertNull(ProductosUtility.getProductosHasProveedoresByBarCode(productosHasProveedores, ""));
            assertNull(ProductosUtility.getProductosHasProveedoresByBarCode(productosHasProveedores, null));
            assertNull(ProductosUtility.getProductosHasProveedoresByBarCode(null, "00000000160000000000"));
        } catch (Exception ex) {
            fail("No deberia de haber entrado aqui");
        }

    }

    @Test
    public void testBuilProductoByBarCode() {
        ProductoDAO productoDAO = new ProductoDAO();
        try {
            List<ProductosHasProveedoresView> productosHasProveedores = productoDAO.getProductosHasProveedoresView();
            System.out.println(productosHasProveedores.size());
            ProductosHasProveedores productoProveedor = ProductosUtility.getProductosHasProveedoresByBarCode(productosHasProveedores, "00000000160000000000");
            ProductosInventario producto = ProductosUtility.buildProductoFromBarCode(productoProveedor, "00002570162500000000");
            assertNotNull(producto);
            BigDecimal peso = new BigDecimal("2.57");
            peso = peso.setScale(2, RoundingMode.HALF_EVEN);
            assertTrue(peso.compareTo(producto.getPeso()) == 0);
            System.out.println(peso.doubleValue());

        } catch (Exception ex) {
            fail("No deberia de haber entrado aqui" + ex.getMessage());
        }

    }

    @Test
    public void testGetProductoByBarCode() {
        try {
            ProductoDAO productoDAO = new ProductoDAO();
            ProductosInventario producto = productoDAO.getProductoByBarCode("00002570162500000000");
            assertNotNull(producto);
            BigDecimal peso = new BigDecimal("2.57");
            peso = peso.setScale(2, RoundingMode.HALF_EVEN);
            assertTrue(peso.compareTo(producto.getPeso()) == 0);

        } catch (Exception ex) {
            fail("No deberia de haber entrado aqui");
        }
    }
}
