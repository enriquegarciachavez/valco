/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import mapping.Ubicaciones;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Karla
 */
public class UbicacionesDAO {
    private SessionFactory sessionFactory;
    
     public void insertarUbicacion(Ubicaciones ubicaciones) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        Transaction tx = null;
        try {
            
            tx = session.beginTransaction();
            session.save(ubicaciones);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception(he.getMessage());
                }
            }
            throw new Exception(e.getMessage());
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception(he.getMessage());
            }
        }
    }
     public void actualizarUbicacion(Ubicaciones ubicaciones) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(ubicaciones);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar la ubicacion.");
                }
            }
            throw new Exception("Ocurrió un error al modificar la ubicacion.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar la ubicacion.");
            }
        }
    }
      public void borrarUbicacion(Ubicaciones ubicaciones) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(ubicaciones);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar la ubicacion.");
                }
            }
            throw new Exception("Ocurrió un error al borrar la ubicacion.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar la ubicacion.");
            }
        }
    }
      public List<Ubicaciones> getUbicaciones() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Ubicaciones> ubicaciones = new ArrayList<Ubicaciones>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM Ubicaciones");
              ubicaciones = (List<Ubicaciones>) q.list();
              tx.commit();
              return ubicaciones;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar la ubicacion.");

          } finally {
              try {
                  if(session.isOpen()){
                session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar la ubicacion.");
              }
        }
    }
      
      public Ubicaciones getUbicacionesXOficina(String oficina) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          Ubicaciones ubicacion = new Ubicaciones();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Ubicaciones.class)
                      .add(Restrictions.eq("oficina", oficina));
              ubicacion = (Ubicaciones)q.uniqueResult();
              tx.commit();
              return ubicacion;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar la ubicacion.");

          } finally {
              try {
                 if(session.isOpen()){
                session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar la ubicacion.");
              }
        }
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
      
      
    
}

