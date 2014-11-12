/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.UnidadesDeMedida;
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
public class UnidadesDeMedidaDAO {
    
    public void insertarUnidadesDeMedida(UnidadesDeMedida unidadesdemedida) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(unidadesdemedida);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar La unidad de medida.");
                }
            }
            throw new Exception("Ocurrió un error al registrar La unidad de medida.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar La unidad de medida.");
            }
        }
    }
     public void actualizarUnidadesDeMedida(UnidadesDeMedida unidadesdemedida) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(unidadesdemedida);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar La unidad de medida.");
                }
            }
            throw new Exception("Ocurrió un error al modificar La unidad de medida.");
        } finally {
            try {
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar La unidad de medida.");
            }
        }
    }
      public void borrarUnidadesDeMedida(UnidadesDeMedida unidadesdemedida) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(unidadesdemedida);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar La unidad de medida.");
                }
            }
            throw new Exception("Ocurrió un error al borrar La unidad de medida.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar La unidad de medida.");
            }
        }
    }
      public List<UnidadesDeMedida> getUnidadesDeMedida() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<UnidadesDeMedida> unidadesdemedida = new ArrayList<UnidadesDeMedida>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM UnidadesDeMedida");
              unidadesdemedida = (List<UnidadesDeMedida>) q.list();
              return unidadesdemedida;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar Las unidades de medida.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar Las unidades de medida.");
              }
        }
    }
    
}
