/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import mapping.Inventarios;
import mapping.ProductosDelInventario;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Karla
 */
public class InventarioDAO {
    public void insertarInventario(Inventarios inventarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(inventarios);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al agregar el inventario.");
                }
            }
            throw new Exception("Ocurrió un error al agregar el inventario.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al agregar el inventario.");
            }
        }
    }
     public void actualizarInventario(Inventarios inventarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(inventarios);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el inventario.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el inventario.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el inventario.");
            }
        }
    }
     
      public void actualizarInventarios(List<Inventarios> inventarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for(Inventarios inventario:inventarios){
             session.update(inventario);   
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el inventario.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el inventario.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el inventario.");
            }
        }
    }
      public void borrarInventario(Inventarios inventarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(inventarios);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el inventario.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el inventario.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el inventario.");
            }
        }
    }
      public List<Inventarios> getInventarios() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<Inventarios> inventario = new ArrayList<Inventarios>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Inventarios.class)
                     .addOrder(Order.desc("fechaInicio"));
              inventario = (List<Inventarios>) q.list();
              for(Inventarios inv:inventario){
                  Hibernate.initialize(inv.getUsuariosByUsuariosInicio());
                  Hibernate.initialize(inv.getUsuariosByUsuariosFin());
                  Hibernate.initialize(inv.getProductosDelInventarios());
              }
              return inventario;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar el inventario.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar el inventario.");
              }
        }
    }
      
      
      public void insertarProductosInventario(ProductosDelInventario productoInventarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(productoInventarios);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al agregar el prducto del inventario.");
                }
            }
            throw new Exception("Ocurrió un error al agregar el producto del inventario.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al agregar el prducto del inventario.");
            }
        }
    }
     public void actualizarProductosInventario(ProductosDelInventario productoInventarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(productoInventarios);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el producto del inventario.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el producto del inventario.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el producto del inventario.");
            }
        }
    }
      public void borrarProductoInventario(ProductosDelInventario productoInventarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(productoInventarios);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el producto del inventario.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el  producto del inventario.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el producto del inventario.");
            }
        }
    }
     public List<ProductosDelInventario> getProductosDelInventarios() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<ProductosDelInventario> productoInventario = new ArrayList<ProductosDelInventario>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Inventarios.class);
              productoInventario = (List<ProductosDelInventario>) q.list();
              return productoInventario;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar el producto del inventario.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar el producto del inventario.");
              }
        }
    }
      
      public List<ProductosDelInventario> getProductosDelInventariosXInvntario(Inventarios inventario) throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          Transaction tx = null;
          List<ProductosDelInventario> productoInventario = new ArrayList<ProductosDelInventario>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosDelInventario.class)
                      .add(Restrictions.eq("inventarios", inventario));
              productoInventario = (List<ProductosDelInventario>) q.list();
              for(ProductosDelInventario producto: productoInventario){
                  Hibernate.initialize(producto.getProductos());
              }
              return productoInventario;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar el producto del inventario.");

          } finally {
              try {
                  session.close();
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar el producto del inventario.");
              }
        }
    }
      
      public void actualizarProductosInventario (List<ProductosDelInventario> productoInventarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for(ProductosDelInventario producto:productoInventarios){
            session.update(producto);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el producto del inventario.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el producto del inventario.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el producto del inventario.");
            }
        }
    }
}


