/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.ProductosHasProveedores;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Karla
 */
public class ProductosHasProveedoresDAO {
    
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
     public void actualizarProductosHasProveedores(ProductosHasProveedores productosHasProveedores) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(productosHasProveedores);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar los Productos HasnProveedores.");
                }
            }
            throw new Exception("Ocurrió un error al modificar los Productos HasnProveedores.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar los Productos HasnProveedores.");
            }
        }
    }
      public void borrarProductosHasProveedores(ProductosHasProveedores productosHasProveedores) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(productosHasProveedores);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar los Productos Has Proveedores.");
                }
            }
            throw new Exception("Ocurrió un error al borrar los Productos Has Proveedores.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar los Productos Has Proveedores.");
            }
        }
    }
      public List<ProductosHasProveedores> getProductosHasProveedores() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<ProductosHasProveedores> productosHasProveedores = new ArrayList<ProductosHasProveedores>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosHasProveedores.class);
              productosHasProveedores = (List<ProductosHasProveedores>) q.list();
              tx.commit();
              return productosHasProveedores;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar los Productos Has Proveedores.");

          } finally {
              try {
                  if(session.isOpen())
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los Productos Has Proveedores.");
              }
        }
    }
    
}
