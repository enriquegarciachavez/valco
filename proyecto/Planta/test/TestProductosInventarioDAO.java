
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import dao.ProductosInventarioDAOImpl;
import dao.UbicacionesDAO;
import java.io.File;
import java.math.BigDecimal;
import java.util.logging.Level;
import java.util.logging.Logger;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Ubicaciones;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
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
public class TestProductosInventarioDAO {
    
    ProductosInventarioDAOImpl productosDAO;
     UbicacionesDAO ubicacionesDAO;
    
    public TestProductosInventarioDAO() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
        productosDAO = new ProductosInventarioDAOImpl();
        ubicacionesDAO = new UbicacionesDAO();
        
        try {
            
            // Create the SessionFactory from standard (hibernate.cfg.xml) 
            // config file.
            //sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
            File conFile = new File("src\\hibernate-test.cfg.xml");
           SessionFactory sessionFactory = new AnnotationConfiguration().configure(conFile).buildSessionFactory();
           productosDAO.setSessionFactory(sessionFactory);
           ubicacionesDAO.setSessionFactory(sessionFactory);
        } catch (Throwable ex) {
            // Log the exception. 
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
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
       producto.setUbicaciones(ubicacion);
       producto.setCodigo(1);
       producto.setEstatus("ACTIVO");
       productosDAO.saveProductoDAO(producto);
       assertNotNull(producto.getCodigo());
        
       
        /*Ubicaciones ubicacion = new Ubicaciones ();
        ubicacion.setCiudad("Chihuahua");
        ubicacion.setEstado("Chihuahua");
        ubicacion.setEstatus("ACTIVO");
        ubicacion.setOficina("VALCO");
        ubicacion.setCodigo(1);
        try {
            ubicacionesDAO.insertarUbicacion(ubicacion);
        } catch (Exception ex) {
            Logger.getLogger(TestProductosInventarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        */
       
       
       
    }
    
    
    
}
