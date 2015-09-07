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
import mapping.OrdenesCompra;
import mapping.Proveedores;
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
 * @author Karla
 */
public class ProveedorDAO implements Serializable {

    public void insertarProveedor(Proveedores proveedor) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(proveedor);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el proveedor.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el proveedor.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el proveedor.");
            }
        }
    }

    public void actualizarProveedor(Proveedores proveedor) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(proveedor);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el proveedor.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el proveedor.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el proveedor.");
            }
        }
    }

    public void borrarProveedor(Proveedores proveedor) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(proveedor);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el proveedor.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el proveedor.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el proveedor.");
            }
        }
    }

    public List<Proveedores> getProveedores() throws Exception {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            Transaction tx = null;
            List<Proveedores> proveedores = new ArrayList<Proveedores>();
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Proveedores.class);
            q.addOrder(Order.asc("razonSocial"));
            proveedores = (List<Proveedores>) q.list();
            return proveedores;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar los proveedores.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los proveedores.");
            }
        }
    }

    public Proveedores getProveedoresXRazonSocial(String razonSocial) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Proveedores proveedor = new Proveedores();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Proveedores.class)
                    .add(Restrictions.eq("razonSocial", razonSocial));
            proveedor = (Proveedores) q.uniqueResult();
            return proveedor;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar los proveedores.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los proveedores.");
            }
        }
    }

    public Proveedores getProveedoresXCodigo(String criterio) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Proveedores proveedor = new Proveedores();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Proveedores.class);
            
            if (StringUtils.isNumeric(criterio)) {
                q.add(Restrictions.eq("codigo",new Integer(criterio)));
            } else {
                q.add(Restrictions.eq("razonSocial", criterio));
            }
            

            proveedor = (Proveedores) q.uniqueResult();
            return proveedor;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar los proveedores.");

        }
    }

    public List<Proveedores> getOdenesProveedores() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Proveedores> proveedores = new ArrayList<Proveedores>();
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("FROM Proveedores");
            proveedores = (List<Proveedores>) q.list();
            for (Proveedores proveedor : proveedores) {

                for (OrdenesCompra orden : proveedor.getOrdenesCompras()) {

                    Hibernate.initialize(orden);

                    Hibernate.initialize(orden.getCuentasXPagars());

                }

            }
            return proveedores;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar los proveedores.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los proveedores.");
            }
        }
    }

}
