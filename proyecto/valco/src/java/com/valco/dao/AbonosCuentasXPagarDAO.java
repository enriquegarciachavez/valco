/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.AbonosCuentasXPagar;
import com.valco.pojo.OrdenesCompra;
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
public class AbonosCuentasXPagarDAO {
    
    
    
     public void insertarAbono(AbonosCuentasXPagar abono) throws Exception {
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
    
     
     public void actualizarAbono(AbonosCuentasXPagar abono) throws Exception {
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
     
     public void borrarAbono(AbonosCuentasXPagar abono) throws Exception {
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
     
     
     public List<AbonosCuentasXPagar> getAbonosCuentasXCobrar() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<AbonosCuentasXPagar> abonos = new ArrayList<AbonosCuentasXPagar>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM AbonosCuentasXPagar");
              abonos = (List<AbonosCuentasXPagar>) q.list();
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
     
     
     public List<OrdenesCompra> getOrdenesCompras() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<OrdenesCompra> ordenes = new ArrayList<OrdenesCompra>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM OrdenesCompra");
              ordenes = (List<OrdenesCompra>) q.list();
              return ordenes;

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
