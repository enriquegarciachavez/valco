/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.Proveedores;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Karla
 */
public class ProductosHasProveedoresDao implements DAO {

    @Override
    public Collection getElements() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<ProductosHasProveedores> productos = new ArrayList<ProductosHasProveedores>();
        Proveedores proveedor = new Proveedores();
        proveedor.setCodigo(9999999);
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosHasProveedores.class)
                    .add(Restrictions.eq("proveedores", proveedor));

            productos = (List<ProductosHasProveedores>) q.list();
            for (ProductosHasProveedores producto : productos) {
                Hibernate.initialize(producto.getProductos());
                Hibernate.initialize(producto.getProveedores());
            }
            tx.commit();
            return productos;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar los producto.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los producto.");
            }
        }
    }

    @Override
    public Object getElementsByCodeOrDesc(String criteria) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Productos producto = new Productos();
        Proveedores proveedor = new Proveedores();
        proveedor.setCodigo(9999999);
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Productos.class)
                    .add(Restrictions.eq("proveedores", proveedor));
            if (StringUtils.isNumeric(criteria)) {
                q.add(Restrictions.eq("producto.codigo", new Integer(criteria)));
            } else {

                q.add(Restrictions.like("producto.descripcion", criteria + "%"))
                        .addOrder(Order.asc("descripcion"))
                        .setMaxResults(1);
            }

            producto = (Productos) q.uniqueResult();
            tx.commit();
            return producto;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar los productos.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los productos.");
            }
        }
    }

    @Override
    public Object[] getElementsArray() {
        try {
            return getElements().toArray();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return new ArrayList().toArray();

    }
    
    public void insertarProductosHasProveedores(ProductosHasProveedores productosHasProveedores) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(productosHasProveedores);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar los Productos HasnProveedores.");
                }
            }
            throw new Exception("Ocurrió un error los Productos HasnProveedores.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error los Productos HasnProveedores.");
            }
        }
    }

    
}
