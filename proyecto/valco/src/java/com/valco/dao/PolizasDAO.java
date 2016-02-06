/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Conceptos;
import com.valco.pojo.Polizas;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Karla
 */
public class PolizasDAO {
    
    public void insertarConcepto(Conceptos conceptos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(conceptos);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar la poliza.");
                }
            }
            throw new Exception("Ocurrió un error al registrar la poliza.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar la poliza.");
            }
        }
    }
    
    public void borrarConcepto(Conceptos conceptos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(conceptos);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el concepto.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el concepto.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el concepto.");
            }
        }
    }
    public void insertarPoliza(Polizas poliza) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(poliza);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar la poliza.");
                }
            }
            throw new Exception("Ocurrió un error al registrar la poliza.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar la poliza.");
            }
        }
    }
    
    public void actualizarPoliza(Polizas poliza) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(poliza);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar la poliza.");
                }
            }
            throw new Exception("Ocurrió un error al modificar la poliza.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar la poliza.");
            }
        }
    }
    
    public void borrarPoliza(Polizas poliza) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(poliza);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar la poliza.");
                }
            }
            throw new Exception("Ocurrió un error al borrar la poliza.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar la poliza.");
            }
        }
    }
    
    public List<Polizas> getPolizas() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Polizas> polizas = new ArrayList<Polizas>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Polizas.class);
              polizas = (List<Polizas>) q.list();
              return polizas;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar las polizas.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar las polizas.");
              }
        }
    }
    
    public Polizas getPolizasBuscar(Date fecha, String tipoPoliza) throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          Polizas polizas = new Polizas();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Polizas.class)
                      .add(Restrictions.eq("tipoPoliza", tipoPoliza))
                      .add(Restrictions.eq("fecha", fecha));
              polizas = (Polizas) q.uniqueResult();
              if(polizas!= null){
                  Hibernate.initialize(polizas.getConceptos());
              }
              return polizas;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar las polizas.");

          } finally {
              try {
                  if(session.isOpen()){
                  session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar las polizas.");
              }
        }
    }
    
    
}
