/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Familias;
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
public class FamiliasDAO {
    public void insertarFamilia(Familias familia) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(familia);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar la familia.");
                }
            }
            throw new Exception("Ocurrió un error al registrar la familia.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar la familia.");
            }
        }
    }
     public void actualizarFamilia(Familias familia) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(familia);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar la familia.");
                }
            }
            throw new Exception("Ocurrió un error al modificar la familia.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar la familia.");
            }
        }
    }
      public void borrarFamilia(Familias familia) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(familia);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar la familia.");
                }
            }
            throw new Exception("Ocurrió un error al borrar la familia.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar la familia.");
            }
        }
    }
      public List<Familias> getFamilias() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Familias> familias = new ArrayList<Familias>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Familias.class);
              familias = (List<Familias>) q.list();
              return familias;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar las familias.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar las familias.");
              }
        }
    }
    
}
