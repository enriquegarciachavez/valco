/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.TipoProducto;
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
public class TipoProductoDAO {
    
    public void insertarTipoProducto(TipoProducto tipoproducto) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(tipoproducto);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el producto.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el producto.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el producto.");
            }
        }
    }
     public void actualizarTipoProducto(TipoProducto tipoProducto) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(tipoProducto);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el producto.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el producto.");
        } finally {
            try {
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el producto.");
            }
        }
    }
      public void borrarTipoProducto(TipoProducto tipoProducto) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(tipoProducto);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el producto.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el producto.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el producto.");
            }
        }
    }
      public List<TipoProducto> getTipoProducto() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<TipoProducto> tipoproducto = new ArrayList<TipoProducto>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM TipoProducto");
              tipoproducto = (List<TipoProducto>) q.list();
              return tipoproducto;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los producto.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los producto.");
              }
        }
    }
    
}
