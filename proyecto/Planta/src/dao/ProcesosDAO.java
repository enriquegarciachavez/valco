/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import mapping.Procesos;
import mapping.Productos;
import mapping.ProductosInventario;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.Hibernate;

/**
 *
 * @author Karla
 */
public class ProcesosDAO {
    
    public void abrirProceso(Procesos proceso, Object[] productos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(proceso);
            for(Object producto : productos){
                ((ProductosInventario)producto).setProcesosCodigoHijo(proceso.getCodigo());
                ((ProductosInventario)producto).setEstatus("ASIGNADO");
                session.update(producto);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el producto.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el producto.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el producto.");
            }
        }
    }
     public void actualizarProceso(Procesos proceso, Set<ProductosInventario> toAdd, Set<ProductosInventario> toRemove) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for(Object producto : toRemove){
                ((ProductosInventario)producto).setProcesosCodigoHijo(null);
                ((ProductosInventario)producto).setEstatus("ACTIVO");
                session.update(producto);
            }
            for(Object producto : toAdd){
                ((ProductosInventario)producto).setProcesosCodigoHijo(proceso.getCodigo());
                ((ProductosInventario)producto).setEstatus("ASIGNADO");
                session.update(producto);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el producto.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el producto.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el producto.");
            }
        }
    }
    
    public char getSiguienteLetra() throws Exception{
        char[] letras = {'A','B','C','D','E','F','G','H','I','J','K','L','M'};
        DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Procesos.class)
                      .add(Restrictions.between("fechaInicio", formatter.parse(formatter.format(new Date())),
                              new Date()));
            q.setProjection(Projections.rowCount());
            Long procesosDelDia =  (Long) q.uniqueResult();
            tx.commit();
            return letras[procesosDelDia.intValue()];

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar los producto.");

        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los producto.");
            }
        }

    }
    
    public List<Procesos> getProcesosActivos() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Procesos> procesos = new ArrayList<Procesos>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Procesos.class)
                      .add(Restrictions.eq("estatus", "ACTIVO"));
              procesos = (List<Procesos>) q.list();
              tx.commit();
            return procesos;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar los procesos.");

        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los procesos.");
            }
        }
    }
    
    public List<Procesos> getProcesosActivosEInactivos() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Procesos> procesos = new ArrayList<Procesos>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Procesos.class);
              procesos = (List<Procesos>) q.list();
              tx.commit();
            return procesos;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar los procesos.");

        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los procesos.");
            }
        }
    }
    
    public Integer getConsecutivo(int procesoCodigo) throws Exception{
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        Integer consecutivo = 1;
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .setProjection(Projections.max("consecutivoProceso"))
                    .add(Restrictions.eq("procesosCodigoPadre", procesoCodigo));
              if(q.uniqueResult() != null){
                  consecutivo = (Integer) q.uniqueResult();
                  consecutivo++;
              }
              tx.commit();
            return consecutivo;

        } catch (HibernateException he) {
            throw new Exception(he.getMessage());

        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception(he.getMessage());
            }
        }
    }
    
    public List<ProductosInventario> getCajasPorProceso(int procesoCodigo) throws Exception{
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<ProductosInventario> productos = new ArrayList<>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .add(Restrictions.eq("procesosCodigoPadre", procesoCodigo));
              productos = q.list();
              for(ProductosInventario producto: productos){
                  Hibernate.initialize(producto.getProductosHasProveedores());
                  Hibernate.initialize(producto.getProductosHasProveedores().getProductos());
              }
              tx.commit();
            return productos;

        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al consultar las cajas.");
                }
            }
            throw new Exception("Ocurrió un error al consultar las cajas.");
        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las cajas.");
            }
        }
    }
    
    public List<ProductosInventario> getCajasPorProcesoHijo(int procesoCodigo) throws Exception{
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<ProductosInventario> productos = new ArrayList<>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .add(Restrictions.eq("procesosCodigoHijo", procesoCodigo));
              productos = q.list();
              for(ProductosInventario producto: productos){
                  Hibernate.initialize(producto.getProductosHasProveedores());
                  Hibernate.initialize(producto.getProductosHasProveedores().getProductos());
              }
              tx.commit();
            return productos;

        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al consultar las cajas.");
                }
            }
            throw new Exception("Ocurrió un error al consultar las cajas.");
        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las cajas.");
            }
        }
    }
    
    public void actualizarProceso(Procesos proceso) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(proceso);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el proceso.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el proceso.");
        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el proceso.");
            }
        }
    }
    
    public BigDecimal getPesoInicial(int procesoCodigo) throws Exception{
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        BigDecimal total = new BigDecimal("0.00");
        List<ProductosInventario> productos = new ArrayList<>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .add(Restrictions.eq("procesosCodigoHijo", procesoCodigo));
              productos = q.list();
              for(ProductosInventario producto: productos){
                  total = total.add(producto.getPeso());
              }
              tx.commit();
            return total;

        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al obtener el peso inicial.");
                }
            }
            throw new Exception("Ocurrió un error al obtener el peso inicial.");
        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al obtener el peso inicial.");
            }
        }
    }
    
    public BigDecimal getPesoHueso(int procesoCodigo) throws Exception{
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        BigDecimal total = new BigDecimal("0.00");
        List<ProductosInventario> productos = new ArrayList<>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .add(Restrictions.eq("procesosCodigoHijo", procesoCodigo));
            Criteria y = q.createCriteria("productosHasProveedores");
            Criteria x = y.createCriteria("productos");
            Criteria z = x.createCriteria("tipoProducto").add(Restrictions.eq("descripcion", "HUESO"));
              productos = q.list();
              for(ProductosInventario producto: productos){
                  total = total.add(producto.getPeso());
              }
              tx.commit();
            return total;

        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al calcular el hueso.");
                }
            }
            throw new Exception("Ocurrió un error al calcular el hueso.");
        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al calcular el hueso.");
            }
        }
    }
    
    public BigDecimal getPesoSebo(int procesoCodigo) throws Exception{
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        BigDecimal total = new BigDecimal("0.00");
        List<ProductosInventario> productos = new ArrayList<>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .add(Restrictions.eq("procesosCodigoHijo", procesoCodigo));
            Criteria y = q.createCriteria("productosHasProveedores");
            Criteria x = y.createCriteria("productos");
            Criteria z = x.createCriteria("tipoProducto").add(Restrictions.eq("descripcion", "SEBO"));
              productos = q.list();
              for(ProductosInventario producto: productos){
                  total = total.add(producto.getPeso());
              }
              tx.commit();
            return total;

        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al calcular el sebo.");
                }
            }
            throw new Exception("Ocurrió un error al calcular el sebo.");
        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al calcular el sebo.");
            }
        }
    }
    
    public BigDecimal getPesoAserrin(int procesoCodigo) throws Exception{
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        BigDecimal total = new BigDecimal("0.00");
        List<ProductosInventario> productos = new ArrayList<>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .add(Restrictions.eq("procesosCodigoHijo", procesoCodigo));
            Criteria y = q.createCriteria("productosHasProveedores");
            Criteria x = y.createCriteria("productos");
            Criteria z = x.createCriteria("tipoProducto").add(Restrictions.eq("descripcion", "ASERRIN"));
              productos = q.list();
              for(ProductosInventario producto: productos){
                  total = total.add(producto.getPeso());
              }
              tx.commit();
            return total;

        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al calcular el Aserrin.");
                }
            }
            throw new Exception("Ocurrió un error al calcular el Aserrin.");
        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al calcular el Aserrin.");
            }
        }
    }
}
