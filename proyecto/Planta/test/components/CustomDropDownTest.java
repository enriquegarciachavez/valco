/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package components;

import dao.DAO;
import dao.FiltrableByFather;
import javax.swing.JTextField;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Karla
 */
public class CustomDropDownTest {
    
    public CustomDropDownTest() {
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

    /**
     * Test of init method, of class CustomDropDown.
     */
    @Test
    public void testInit() {
        System.out.println("init");
        CustomDropDown instance = new CustomDropDown();
        instance.init();
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of reloadChild method, of class CustomDropDown.
     */
    @Test
    public void testReloadChild() {
        System.out.println("reloadChild");
        CustomDropDown instance = new CustomDropDown();
        instance.reloadChild();
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getSelectedItem method, of class CustomDropDown.
     */
    @Test
    public void testGetSelectedItem() {
        System.out.println("getSelectedItem");
        CustomDropDown instance = new CustomDropDown();
        Object expResult = null;
        Object result = instance.getSelectedItem();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setDao method, of class CustomDropDown.
     */
    @Test
    public void testSetDao() {
        System.out.println("setDao");
        DAO dao = null;
        CustomDropDown instance = new CustomDropDown();
        instance.setDao(dao);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setChild method, of class CustomDropDown.
     */
    @Test
    public void testSetChild() {
        System.out.println("setChild");
        CustomDropDown child = null;
        CustomDropDown instance = new CustomDropDown();
        instance.setChild(child);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setDaoFather method, of class CustomDropDown.
     */
    @Test
    public void testSetDaoFather() {
        System.out.println("setDaoFather");
        FiltrableByFather daoFather = null;
        CustomDropDown instance = new CustomDropDown();
        instance.setDaoFather(daoFather);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of filterByFather method, of class CustomDropDown.
     */
    @Test
    public void testFilterByFather() {
        System.out.println("filterByFather");
        Object father = null;
        CustomDropDown instance = new CustomDropDown();
        instance.filterByFather(father);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setEtiqueta method, of class CustomDropDown.
     */
    @Test
    public void testSetEtiqueta() {
        System.out.println("setEtiqueta");
        String etiqueta = "";
        CustomDropDown instance = new CustomDropDown();
        instance.setEtiqueta(etiqueta);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getTxt method, of class CustomDropDown.
     */
    @Test
    public void testGetTxt() {
        System.out.println("getTxt");
        CustomDropDown instance = new CustomDropDown();
        JTextField expResult = null;
        JTextField result = instance.getTxt();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getChild method, of class CustomDropDown.
     */
    @Test
    public void testGetChild() {
        System.out.println("getChild");
        CustomDropDown instance = new CustomDropDown();
        CustomDropDown expResult = null;
        CustomDropDown result = instance.getChild();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
