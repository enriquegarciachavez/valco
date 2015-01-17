/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.AbonosCuentasXCobrar;
import com.valco.pojo.Clientes;
import com.valco.pojo.NotasDeVenta;
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
public class AbonosCuentasXCobrarDAO {
    
    public void insertarAbono(AbonosCuentasXCobrar abono) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(abono);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el abono.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el abono.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el abono.");
            }
        }
    }
    
    
    public void actualizarAbono(AbonosCuentasXCobrar abono) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(abono);
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
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el cliente.");
            }
        }
    }
    
    public void borrarAbono(AbonosCuentasXCobrar abono) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(abono);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el abono.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el abono.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el abono.");
            }
        }
    }
    
    public List<AbonosCuentasXCobrar> getAbonosCuentasXCobrar() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<AbonosCuentasXCobrar> abonos = new ArrayList<AbonosCuentasXCobrar>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM AbonosCuentasXCobrar");
              abonos = (List<AbonosCuentasXCobrar>) q.list();
              return abonos;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los clientes.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los clientes.");
              }
        }
    }
    
    public List<NotasDeVenta> getNotasDeVenta() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<NotasDeVenta> notas = new ArrayList<NotasDeVenta>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM NotasDeVenta");
              notas = (List<NotasDeVenta>) q.list();
              return notas;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los clientes.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los clientes.");
              }
        }
    }
    
    
    
    
    
    
}
