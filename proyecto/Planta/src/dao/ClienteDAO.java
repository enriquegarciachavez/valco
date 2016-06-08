/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import mapping.Clientes;
import mapping.NotasDeVenta;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Enrique
 */
public class ClienteDAO implements Serializable {

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
                if (session.isOpen()) {
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
                if (session.isOpen()) {
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
            tx.commit();
            return clientes;

        } catch (HibernateException he) {
            tx.commit();
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

    
    public List<Clientes> getClientesConAdeudo() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Clientes> clientes = new ArrayList<Clientes>();
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("FROM Clientes");
            clientes = (List<Clientes>) q.list();
            tx.commit();
            return clientes;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar los clientes.");

        } finally {
            try {
                if ((session.isOpen())) {
                    session.close();
                }
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
            cliente = (Clientes) q.uniqueResult();
            tx.commit();
            return cliente;

        } catch (HibernateException he) {
            tx.commit();
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

    

    public Clientes getClienteXNotaDeVenta(NotasDeVenta nota) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Clientes cliente = new Clientes();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Clientes.class)
                    .add(Restrictions.eq("notasDeVentas", nota));
            cliente = (Clientes) q.uniqueResult();
            tx.commit();
            return cliente;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar los clientes.");

        } finally {
            try {
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los clientes.");
            }
        }
    }
    
    public Clientes getClienteXDescripcionOCodigo(String criterio) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          Clientes cliente = new Clientes();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Clientes.class);
                      if(StringUtils.isNumeric(criterio)){
                          q.add(Restrictions.eq("codigo", new Integer( criterio)));
                      }else{
                          q.add(Restrictions.disjunction()
                                .add(Restrictions.like("nombres", criterio + "%"))
                                  .add(Restrictions.like("apellidoPaterno", criterio+"%"))
                                  .add(Restrictions.like("apellidoMaterno", criterio+"%")));
                                q.addOrder(Order.asc("apellidoPaterno"))
                                .setMaxResults(1);
                      }
                      
                              
                      
                      
              cliente = (Clientes)q.uniqueResult();
              return cliente;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los productos.");

          } finally {
              try {
                  if(session.isOpen()){
                    session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los productos.");
              }
        }
    }
}
