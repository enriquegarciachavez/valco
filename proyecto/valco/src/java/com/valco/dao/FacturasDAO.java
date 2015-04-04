/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Clientes;
import com.valco.pojo.Facturas;
import com.valco.pojo.NotasDeVenta;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrador
 */
public class FacturasDAO implements Serializable {

    public void insertarFacturas(List<Facturas> facturas) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for (Facturas factura : facturas) {
                session.save(factura);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al crear las facturas.");
                }
            }
            throw new Exception("Ocurrió un error al crear las facturas.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al crear las facturas.");
            }
        }
    }

    public void insertarFacturasYActualizarNotas(List<NotasDeVenta> notas) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for (NotasDeVenta nota : notas) {
                session.update(nota);
                session.save(nota.getFacturas());
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al crear las facturas.");
                }
            }
            throw new Exception("Ocurrió un error al crear las facturas.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al crear las facturas.");
            }
        }
    }

    public void actualizarCliente(List<Facturas> facturas) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for (Facturas factura : facturas) {
                session.update(factura);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al actualizar la factura.");
                }
            }
            throw new Exception("Ocurrió un error al actualizar la factura.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al actualizar la factura.");
            }
        }
    }

    public void borrarCliente(List<Facturas> facturas) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for (Facturas factura : facturas) {
                session.delete(factura);
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

    public List<Clientes> getFacturas() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Clientes> clientes = new ArrayList<Clientes>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Clientes.class);
            clientes = (List<Clientes>) q.list();
            for (Clientes cliente : clientes) {
                for (NotasDeVenta nota : cliente.getNotasDeVentas()) {
                    Hibernate.initialize(nota);
                    Hibernate.initialize(nota.getCuentaXCobrar());
                }
            }
            return clientes;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar las facturas.");

        } finally {
            try {
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las facturas.");
            }
        }
    }

    public Integer getConsecutivo() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("SELECT SECUENCIA\n"
                    + "FROM SECUENCIAS\n"
                    + "WHERE TABLE_NAME = 'FACTURAS'");
            Integer consecutivo = (Integer) query.uniqueResult();
            return consecutivo;
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el número consecutivo.");

        } finally {
            try {
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar el número consecutivo.");
            }
        }
    }

}
