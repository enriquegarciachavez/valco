/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import dao.ProductoDAO;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import mapping.ProductosHasProveedores;
import mapping.ProductosHasProveedoresView;
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
    public void testEtiquetadoPanleInit(){
      
    }
    
    @Test
    public void testGetProductosHasProveedoresByBarCode(){
        ProductoDAO productoDAO = new ProductoDAO();
        try {
            List<ProductosHasProveedoresView> productosHasProveedores = productoDAO.getProductosHasProveedoresView();
            System.out.println(productosHasProveedores.size());
             ProductosHasProveedores productoProveedor = ProductosUtility.getProductosHasProveedoresByBarCode(productosHasProveedores, "00000000160000000000");
             assertNotNull("Fallo por que no se encontro el producto proveedor", productoProveedor);
             assertEquals(productoProveedor.getCodigo().intValue(), 5);
        } catch (Exception ex) {
            fail("No deberia de haber entrado aqui");
        }
       
    }
}
