/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Clientes;
import com.valco.pojo.NotasDeVenta;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Enrique
 */
public class ClienteDAO implements Serializable{

    public void insertarCliente(Clientes cliente) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(cliente);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el cliente.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el cliente.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el cliente.");
            }
        }
    }
     public void actualizarCliente(Clientes cliente) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(cliente);
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
      public void borrarCliente(Clientes cliente) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(cliente);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el cliente.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el cliente.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el cliente.");
            }
        }
    }
      public List<Clientes> getClientes() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Clientes> clientes = new ArrayList<Clientes>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Clientes.class);
              clientes = (List<Clientes>) q.list();
              return clientes;

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
      
      public List<Clientes> getClientesYNotas() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Clientes> clientes = new ArrayList<Clientes>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Clientes.class);
              clientes = (List<Clientes>) q.list();
              for(Clientes cliente : clientes){
                  for(NotasDeVenta nota : cliente.getNotasDeVentas()){
                      Hibernate.initialize(nota);
                      Hibernate.initialize(nota.getCuentaXCobrar());
                  }
              }
              return clientes;

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
      
      public List<Clientes> getClientesConAdeudo() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Clientes> clientes = new ArrayList<Clientes>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM Clientes");
              clientes = (List<Clientes>) q.list();
              for(Clientes cliente : clientes){
                  for(NotasDeVenta nota : cliente.getNotasDeVentas()){
                      Hibernate.initialize(nota);
                      Hibernate.initialize(nota.getCuentasXCobrars());
                  }
              }
              return clientes;

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

    public Clientes getClientesXRazonSocial(String razonSocial) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          Clientes cliente = new Clientes();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Clientes.class)
                      .add(Restrictions.eq("razonSocial", razonSocial));
              cliente = (Clientes)q.uniqueResult();
              return cliente;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los clientes.");

          } finally {
              try {
                  if (session.isOpen()) {
                    session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los clientes.");
              }
        }
    }
    
    public Clientes getClienteXNotaDeVenta(NotasDeVenta nota) throws Exception{
        Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          Clientes cliente = new Clientes();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Clientes.class)
                      .add(Restrictions.eq("notasDeVentas", nota));
              cliente = (Clientes)q.uniqueResult();
              return cliente;

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
