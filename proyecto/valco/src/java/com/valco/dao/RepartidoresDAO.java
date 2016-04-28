/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Repartidores;
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
public class RepartidoresDAO {
    
    public void insertarRepartidores(Repartidores repartidores) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(repartidores);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el repartidores.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el repartidores.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el repartidores.");
            }
        }
    }
     public void actualizarRepartidor(Repartidores repartidores) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(repartidores);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el repartidor.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el repartidor.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el repartidor    .");
            }
        }
    }
      public void borrarRepartidor(Repartidores repartidores) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(repartidores);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el repartidor.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el repartidor.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el repartidor.");
            }
        }
    }
      public List<Repartidores> getRepartidores() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Repartidores> repartidores = new ArrayList<Repartidores>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM Repartidores");
              repartidores = (List<Repartidores>) q.list();
              tx.commit();
              return repartidores;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar los repartidores.");

          } finally {
              try {
                  if(session.isOpen())
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los repartidores.");
              }
        }
    }
    
}
