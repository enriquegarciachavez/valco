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
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

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
                if(session.isOpen()){
                session.close();
                }
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
              tx.commit();
              return unidadesdemedida;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar Las unidades de medida.");

          } finally {
              try {
                 if(session.isOpen()){
                session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar Las unidades de medida.");
              }
        }
    }
      public UnidadesDeMedida getUnidadesXDescripcion(String descripcion) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          UnidadesDeMedida descrip = new UnidadesDeMedida();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(UnidadesDeMedida.class)
                      .add(Restrictions.eq("descripcion", descripcion));
              descrip = (UnidadesDeMedida)q.uniqueResult();
              tx.commit();
              return descrip;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar los clientes.");

          } finally {
              try {
                 if(session.isOpen()){
                session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los clientes.");
              }
        }
    }
      
      public UnidadesDeMedida getUnidadesXAbreviacion(String abreviacion) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          UnidadesDeMedida abrevia = new UnidadesDeMedida();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(UnidadesDeMedida.class)
                      .add(Restrictions.eq("abreviacion", abreviacion));
              abrevia = (UnidadesDeMedida)q.uniqueResult();
              tx.commit();
              return abrevia;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar los clientes.");

          } finally {
              try {
                  if(session.isOpen()){
                session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los clientes.");
              }
        }
    }
    
}
