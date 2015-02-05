/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.AbonosCuentasXCobrar;
import com.valco.pojo.Clientes;
import com.valco.pojo.CuentasXCobrar;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.ProductosInventario;
import com.valco.pojo.Repartidores;
import java.util.ArrayList;
import java.util.Date;
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
                if (session.isOpen()) {
                    session.close();
                }
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
            CuentasXCobrar cuenta = new CuentasXCobrar();
            cuenta.setEstatus("ACTIVO");
            cuenta.setFecha(new Date());
            cuenta.setImporte(nota.getTotal());
            cuenta.setNotasDeVenta(nota);
            session.save(cuenta);
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
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el cliente.");
            }
        }
    }
     
     public void cancelarNotaVendida(NotasDeVenta nota) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            nota.setEstatus("ACTIVO");
            nota.setClientes(null);
            nota.setFechaDeVenta(null);
            nota.setFlete(null);
            session.update(nota);
            for(ProductosInventario producto : nota.getProductosInventarios()){
                producto.setEstatus("ACTIVO");
                producto.setNotasDeVenta(null);
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
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el cliente.");
            }
        }
    }
     
     public void actualizarNotaDeVentaVendida(NotasDeVenta nota) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(nota);
            for(ProductosInventario producto : nota.getProductosInventarios()){
                if(!nota.getProductosInventariosList().contains(producto)){
                    producto.setEstatus("ACTIVO");
                    session.update(producto);
                }
            }
            for(ProductosInventario producto : nota.getProductosInventariosList()){
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
                if (session.isOpen()) {
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
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el cliente.");
            }
        }
    }
      
      public void borrarNotasDeVenta(List<NotasDeVenta> notas) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for(NotasDeVenta nota : notas){
                session.delete(nota);
            }
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
      
      public List<NotasDeVenta> getNotasDeVenta() throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<NotasDeVenta> notas = new ArrayList<NotasDeVenta>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(NotasDeVenta.class)
                      .setFetchMode("repartidores", FetchMode.JOIN);
              q.setFetchMode("productosInventarios", FetchMode.SELECT)
                      .setFetchMode("clientes", FetchMode.JOIN)
                      .add(Restrictions.eq("estatus", "ASIGNADA"));
              notas = (List<NotasDeVenta>) q.list();
              return notas;

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
      
      public List<NotasDeVenta> getNotasXRangoFolio(Integer folioInicial, Integer folioFinal) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<NotasDeVenta> notas = new ArrayList<NotasDeVenta>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(NotasDeVenta.class)
                      .add(Restrictions.ge("folio", folioInicial))
                      .add(Restrictions.le("folio", folioFinal));
              notas = (List<NotasDeVenta>) q.list();
              return notas;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los clientes.");

          } finally {
              try {
                  if(session.isOpen()){
                    session.close();
                  }
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
                if (session.isOpen()) {
                    session.close();
                }
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
                  if (session.isOpen()) {
                      session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los clientes.");
              }
        }
    }
      
      public List<NotasDeVenta> getNotasDeVentaXCliente(Clientes cliente) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<NotasDeVenta> notas = new ArrayList<NotasDeVenta>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(NotasDeVenta.class)
                      .setFetchMode("cuentasXCobrars", FetchMode.JOIN)
                      .add(Restrictions.eq("clientes", cliente));
              notas = (List<NotasDeVenta>)q.list();
              for(NotasDeVenta nota : notas){
                  for(CuentasXCobrar cuenta : nota.getCuentasXCobrars()){
                      Hibernate.initialize(cuenta);
                      
                  }
                  Hibernate.initialize(nota.getProductosInventarios());
              }
              return notas;

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
      
      public List<AbonosCuentasXCobrar> getAbonosXCuenta(CuentasXCobrar cuenta) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<AbonosCuentasXCobrar> abonos = new ArrayList<AbonosCuentasXCobrar>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(AbonosCuentasXCobrar.class)
                      .add(Restrictions.eq("cuentasXCobrar", cuenta));
              abonos = (List<AbonosCuentasXCobrar>)q.list();
              return abonos;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los abonos.");

          } finally {
              try {
                  if (session.isOpen()) {
                      session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los abonos.");
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
                  if (session.isOpen()) {
                      session.close();
                  }
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
                  if (session.isOpen()) {
                      session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los clientes.");
              }
        }
    }
      
      public List<NotasDeVenta> getNotasDeVenta(Repartidores repartidor,
                                                Date fechaInicial,
                                                Date fechaFinal,
                                                String estatus) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        List<NotasDeVenta> notas = new ArrayList<NotasDeVenta>();
        try {
            tx = session.beginTransaction();
            Criteria criteria = session.createCriteria(NotasDeVenta.class)
                    .add(Restrictions.eq("repartidores", repartidor));
            if(fechaInicial != null && fechaFinal != null){
                criteria.add(Restrictions.between("fechaDeVenta", fechaInicial, fechaFinal));
            }else if(fechaInicial != null){
                criteria.add(Restrictions.eq("fechaDeVenta", fechaInicial));
            }else if(fechaFinal != null){
                criteria.add(Restrictions.eq("fechaDeVenta", fechaFinal));
            }
            if(estatus != null){
                criteria.add(Restrictions.eq("estatus", estatus));
            }
            notas = (List<NotasDeVenta>) criteria.list();
            for (NotasDeVenta nota : notas) {
                for (CuentasXCobrar cuenta : nota.getCuentasXCobrars()) {
                    Hibernate.initialize(cuenta);
                }
            }
            return notas;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar las notas.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las notas.");
            }
        }
    }
}
