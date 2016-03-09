/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.ParametrosGenerales;
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
public class ParametrosGeneralesDAO {
    
    public void insertarParametro(ParametrosGenerales parametrosGenerales) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(parametrosGenerales);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el parametro general.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el parametro general.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el parametro general.");
            }
        }
    }
    
    
    public void actualizarParametro(ParametrosGenerales parametrosGenerales) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(parametrosGenerales);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el cliente.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el cliente.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el cliente.");
            }
        }
    }
    
    
    public void borrarParametro(ParametrosGenerales parametrosGenerales) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(parametrosGenerales);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el parametro.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el parametro.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el parametro.");
            }
        }
    }
    
    public List<ParametrosGenerales> getParametrosGenerales() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<ParametrosGenerales> parametros = new ArrayList<ParametrosGenerales>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ParametrosGenerales.class);
              parametros = (List<ParametrosGenerales>) q.list();
              return parametros;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los Parametros Generales.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los Parametros Generales.");
              }
        }
    }
    
    public String getParametroGeneralXClave(String clave) throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          ParametrosGenerales parametro = new ParametrosGenerales();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ParametrosGenerales.class)
                      .add(Restrictions.eq("clave", clave));
              parametro = (ParametrosGenerales) q.uniqueResult();
              if(parametro != null){
                  return parametro.getValor();
              }else{
                  throw new Exception("Parametro "+clave+" no encontradó");
              }

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los Parametros Generales.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los Parametros Generales.");
              }
        }
    }
}
