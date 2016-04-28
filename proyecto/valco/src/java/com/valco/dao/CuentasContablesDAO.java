/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.CuentasContables;
import java.io.Serializable;
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
public class CuentasContablesDAO implements Serializable{
    
    public void insertarCuentaContable(CuentasContables cuenta) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(cuenta);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar la cuenta.");
                }
            }
            throw new Exception("Ocurrió un error al registrar la cuenta.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar la cuenta.");
            }
        }
    }
    
    public void actualizarCuentaContable(CuentasContables cuenta) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(cuenta);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar la cuenta.");
                }
            }
            throw new Exception("Ocurrió un error al modificar la cuenta.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar la cuenta.");
            }
        }
    }
    
    public void borrarCuentaContable(CuentasContables cuenta) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(cuenta);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar la cuenta.");
                }
            }
            throw new Exception("Ocurrió un error al borrar la cuenta.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar la cuenta.");
            }
        }
    }
    
    public List<CuentasContables> getCuentasContables() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<CuentasContables> cuentas = new ArrayList<CuentasContables>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(CuentasContables.class);
              cuentas = (List<CuentasContables>) q.list();
              tx.commit();
              return cuentas;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar las cuentas.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar las cuentas.");
              }
        }
    }
    
}
