/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Clientes;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.ProductosInventario;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Karlitha
 */
public class NotasVentaDAO {
    
    public void insertarNotaDeVenta(NotasDeVenta nota) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(nota);
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
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el cliente.");
            }
        }
    }
    
    public void insertarNotas(List<NotasDeVenta> notas) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for (NotasDeVenta nota : notas) {
                session.save(nota);
            }
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
     public void actualizarNotaDeVenta(NotasDeVenta nota) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(nota);
            for(ProductosInventario producto : nota.getProductosInventarios()){
                producto.setEstatus("VENDIDO");
                session.update(producto);
            }
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
      public void borrarNotaDeVenta(NotasDeVenta nota) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(nota);
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
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el cliente.");
            }
        }
    }
      public List<NotasDeVenta> getNotasDeVenta() throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<NotasDeVenta> notas = new ArrayList<NotasDeVenta>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(NotasDeVenta.class)
                      .setFetchMode("repartidores", FetchMode.JOIN);
              q.setFetchMode("productosInventarios", FetchMode.SELECT)
                      .add(Restrictions.eq("estatus", "ASIGNADA"));
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
      
      public List<NotasDeVenta> getAsignacionNotasDeVenta() throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<NotasDeVenta> notas = new ArrayList<NotasDeVenta>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(NotasDeVenta.class)
                      .setFetchMode("repartidores", FetchMode.JOIN);
              q.setFetchMode("productosInventarios", FetchMode.SELECT);
                      
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
    
      public NotasDeVenta getNotaDeVentaXFolio(int folio) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          NotasDeVenta nota = new NotasDeVenta();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(NotasDeVenta.class)
                      .setFetchMode("repartidores", FetchMode.JOIN)
                      .setFetchMode("productosInventarios", FetchMode.JOIN)
                      .add(Restrictions.eq("folio", folio));
              nota = (NotasDeVenta)q.uniqueResult();
              return nota;

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
      
      public List<ProductosInventario> getProductosDisponibles() throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<ProductosInventario> producto = new ArrayList<ProductosInventario>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosInventario.class)
                      .add(Restrictions.eq("estatus", "ACTIVO"));
              producto = (List<ProductosInventario>)q.list();
              return producto;

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
      
      public List<ProductosInventario> getProductosXNota(NotasDeVenta nota) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<ProductosInventario> producto = new ArrayList<ProductosInventario>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosInventario.class)
                      .add(Restrictions.eq("notasDeVenta", nota));
              producto = (List<ProductosInventario>)q.list();
              return producto;

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
