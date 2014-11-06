/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Clientes;
import com.valco.pojo.Proveedores;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Enrique
 */
public class ProveedorDAO implements Serializable{
    public void insertarProveedor(Proveedores proveedor) throws Exception{
     Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(proveedor);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el proveedor.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el proveedor.");
        } finally {
            try {
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el proveedor.");
            }
        }
    }
    
    public void actualizarProveedor (Proveedores proveedor) throws Exception{
     Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(proveedor);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el proveedor.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el proveedor.");
        } finally {
            try {
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el proveedor.");
            }
        }
    }
    public void borrarProveedor (Proveedores proveedor) throws Exception{
     Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(proveedor);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el proveedor.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el proveedor.");
        } finally {
            try {
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el proveedor.");
            }
        }
    }
    public List<Proveedores> getProveedores() throws Exception{
    Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Proveedores> proveedores = new ArrayList<Proveedores>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM Proveedores");
              proveedores = (List<Proveedores>) q.list();
              return proveedores;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los proveedores.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los proveedores.");
              }
        }
    }
    
    
    
}
