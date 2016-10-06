package test;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.math.BigDecimal;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Ubicaciones;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Administrador
 */
public class TestProductoInventarioDAO {
    
    public TestProductoInventarioDAO() {
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

    // TODO add test methods here.
    // The methods must be annotated with annotation @Test. For example:
    //
   @Test
    public void testInsertProductosInventario() {
        
       ProductosInventario producto = new ProductosInventario();
       producto.setPeso(BigDecimal.ZERO);
       producto.setPrecio(BigDecimal.ZERO);
       ProductosHasProveedores productoProveedor = new ProductosHasProveedores();
       productoProveedor.setCodigo(1);
       producto.setProductosHasProveedores(productoProveedor);
       Ubicaciones ubicacion = new Ubicaciones ();
       ubicacion.setCodigo(1);
       producto.setEstatus("ACTIVO");
       
       
    }
}
