/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
            return productos;

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
}
