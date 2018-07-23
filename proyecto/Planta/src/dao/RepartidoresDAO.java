/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;


import Hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import mapping.Productos;
import mapping.Repartidores;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
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
public class RepartidoresDAO {
    
    public void insertarRepartidores(Repartidores repartidores) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(repartidores);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el repartidores.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el repartidores.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el repartidores.");
            }
        }
    }
     public void actualizarRepartidor(Repartidores repartidores) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(repartidores);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el repartidor.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el repartidor.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el repartidor    .");
            }
        }
    }
      public void borrarRepartidor(Repartidores repartidores) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(repartidores);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el repartidor.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el repartidor.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el repartidor.");
            }
        }
    }
      public List<Repartidores> getRepartidores() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Repartidores> repartidores = new ArrayList<Repartidores>();
          try {
              tx = session.beginTransaction();
              Query q = session.createQuery("FROM Repartidores");
              repartidores = (List<Repartidores>) q.list();
              return repartidores;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los repartidores.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los repartidores.");
              }
        }
    }
      
       public Repartidores getRepartidorXDescripcionOCodigo(String criterio) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          Repartidores repartidor = new Repartidores();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Repartidores.class);
                      if(StringUtils.isNumeric(criterio)){
                          q.add(Restrictions.eq("codigo", criterio));
                      }else{
                          q.add(Restrictions.disjunction()
                                .add(Restrictions.like("nombres", criterio + "%"))
                                  .add(Restrictions.like("apellidoPaterno", criterio+"%"))
                                  .add(Restrictions.like("apellidoMaterno", criterio+"%")));
                                q.addOrder(Order.asc("apellidoPaterno"))
                                .setMaxResults(1);
                      }
                      
                              
                      
                      
              repartidor = (Repartidores)q.uniqueResult();
              return repartidor;

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
