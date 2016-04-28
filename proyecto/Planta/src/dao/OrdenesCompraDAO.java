/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import mapping.OrdenesCompra;
import mapping.ProductosInventario;
import mapping.Ubicaciones;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Karla
 */
public class OrdenesCompraDAO {
    
     public void insertarOrdenesCompra(OrdenesCompra ordenesCompra) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(ordenesCompra);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar la Orden de Compra.");
                }
            }
            throw new Exception("Ocurrió un error al registrar la Orden de Compra.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar la Orden de Compra.");
            }
        }
    }
     public void actualizarOrdenesCompra(OrdenesCompra ordenesCompra) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(ordenesCompra);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar la Orden de Compra.");
                }
            }
            throw new Exception("Ocurrió un error al modificar la Orden de Compra.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar la Orden de Compra.");
            }
        }
    }
      public void borrarOrdenesCompra(OrdenesCompra ordenesCompra) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(ordenesCompra);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar la Orden de Compra.");
                }
            }
            throw new Exception("Ocurrió un error al borrar la Orden de Compra.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar la Orden de Compra.");
            }
        }
    }
      public List<OrdenesCompra> getOrdenesCompra() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<OrdenesCompra> ordenesCompra = new ArrayList<OrdenesCompra>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(OrdenesCompra.class);
              ordenesCompra = (List<OrdenesCompra>) q.list();
              tx.commit();
              return ordenesCompra;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar la Orden de Compra.");

          } finally {
              try {
                  if(session.isOpen()){
                session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar la Orden de Compra.");
              }
        }
    }
      
       public List<ProductosInventario> getProductosInventarioXOrden(OrdenesCompra ordenCompra) throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<ProductosInventario> productoInventario = new ArrayList<ProductosInventario>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(OrdenesCompra.class)
                      .add(Restrictions.eq("ordenesCompra", ordenCompra));
              productoInventario = (List<ProductosInventario>) q.list();
              tx.commit();
              return productoInventario;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los Productos de la Orden.");

          } finally {
              try {
                  if(session.isOpen()){
                session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los Productos de la Orden.");
              }
        }
    }
       
        public List<ProductosInventario> getProductosInventarioAgrupadoXOrden(OrdenesCompra ordenCompra) throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<ProductosInventario> productoInventario = new ArrayList<ProductosInventario>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosInventario.class)
                      .add(Restrictions.eq("ordenesCompra", ordenCompra));
              q.setProjection(Projections.projectionList()
                      .add(Projections.groupProperty("productosHasProveedores"))
                        .add(Projections.sum("peso")));
              productoInventario = (List<ProductosInventario>) q.list();
              tx.commit();
              return productoInventario;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los Productos de la Orden.");

          } finally {
              try {
                  if(session.isOpen()){
                session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los Productos de la Orden.");
              }
        }
    }
    
}
