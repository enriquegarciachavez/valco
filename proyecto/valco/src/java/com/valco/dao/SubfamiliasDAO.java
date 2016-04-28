/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Familias;
import com.valco.pojo.Subfamilias;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Karla
 */
public class SubfamiliasDAO {
    
    public void insertarSubfamilia(Subfamilias subfamilia) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(subfamilia);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar las subfamilias.");
                }
            }
            throw new Exception("Ocurrió un error al registrar las subfamilias.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar las subfamilias.");
            }
        }
    }
     public void actualizarSubfamilia(Subfamilias subfamilia) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(subfamilia);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar las subfamilia.");
                }
            }
            throw new Exception("Ocurrió un error al modificar las subfamilia.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar las subfamilia.");
            }
        }
    }
      public void borrarSubfamilia(Subfamilias subfamilia) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(subfamilia);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar las subfamilia.");
                }
            }
            throw new Exception("Ocurrió un error al borrar las subfamilia.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar las subfamilia.");
            }
        }
    }
      public List<Subfamilias> getSubfamilias() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Subfamilias> subfamilias = new ArrayList<Subfamilias>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Subfamilias.class);
              subfamilias = (List<Subfamilias>) q.list();
              tx.commit();
              return subfamilias;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar las subfamilias.");

          } finally {
              try {
                  if(session.isOpen())
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar las subfamilias.");
              }
        }
    }
      
      public List<Subfamilias> getSubfamilias(Familias familia) throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Subfamilias> subfamilias = new ArrayList<Subfamilias>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Subfamilias.class)
                      .add(Restrictions.eq("familias", familia));
              
              subfamilias = (List<Subfamilias>) q.list();
              tx.commit();
              return subfamilias;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar las subfamilias.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar las subfamilias.");
              }
        }
    }
      
    
}
