/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.AbonosCuentasXPagar;
import com.valco.pojo.CuentasXPagar;
import com.valco.pojo.OrdenesCompra;
import com.valco.pojo.OrdenesCompraView;
import com.valco.pojo.Proveedores;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Enrique
 */
public class AbonosCuentasXPagarDAO {

    public void insertarAbono(AbonosCuentasXPagar abono) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(abono);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el abono.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el abono.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el abono.");
            }
        }
    }

    public void actualizarAbono(AbonosCuentasXPagar abono) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(abono);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el abono.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el abono.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el abono.");
            }
        }
    }

    public void borrarAbono(AbonosCuentasXPagar abono) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(abono);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el abono.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el abono.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el abono.");
            }
        }
    }

    public List<AbonosCuentasXPagar> getAbonosCuentasXCobrar() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<AbonosCuentasXPagar> abonos = new ArrayList<AbonosCuentasXPagar>();
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("FROM AbonosCuentasXPagar");
            abonos = (List<AbonosCuentasXPagar>) q.list();
            tx.commit();
            return abonos;

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

    public List<OrdenesCompra> getOrdenesCompras() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<OrdenesCompra> ordenes = new ArrayList<OrdenesCompra>();
        try {
            tx = session.beginTransaction();
            Query q = session.createQuery("FROM OrdenesCompra");
            ordenes = (List<OrdenesCompra>) q.list();
            tx.commit();
            return ordenes;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar las OrdenesCompra.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las OrdenesCompra.");
            }
        }
    }

    //karla para ConsultaAbonosCuentasPagar

    public List<OrdenesCompra> getOrdenesCompra(Date fechaInicial, Date fechaFinal,
            Proveedores proveedor, Integer numeroOrden,
            String estatus) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<OrdenesCompra> ordenes = new ArrayList<OrdenesCompra>();
        try {
            tx = session.beginTransaction();
            Criteria criteria = session.createCriteria(OrdenesCompra.class);
            if (fechaInicial != null && fechaFinal != null) {
                criteria.add(Restrictions.between("fecha", fechaInicial, fechaFinal));
            } else if (fechaInicial != null) {
                criteria.add(Restrictions.eq("fecha", fechaInicial));
            } else if (fechaFinal != null) {
                criteria.add(Restrictions.eq("fecha", fechaFinal));
            }

            if (proveedor != null) {
                criteria.add(Restrictions.eq("proveedores", proveedor));
            }
            if (numeroOrden != null) {
                criteria.add(Restrictions.eq("codigo", numeroOrden));
            }
            if (estatus != null) {
                criteria.add(Restrictions.eq("estatus", estatus));
            }
            ordenes = (List<OrdenesCompra>) criteria.list();
            for (OrdenesCompra orden : ordenes) {
                Hibernate.initialize(orden.getCuentasXPagars());
                if (orden.getCuentaXPagar() != null) {
                    Hibernate.initialize(orden.getCuentaXPagar().getAbonosCuentasXPagars());
                }
            }
            tx.commit();
            return ordenes;

        } catch (HibernateException he) {
            tx.commit();
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

    public List<OrdenesCompra> getOrdenesComprasXProveedor(Proveedores proveedor) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<OrdenesCompra> ordenes = new ArrayList<OrdenesCompra>();
        try {
            tx = session.beginTransaction();

            Criteria q = session.createCriteria(OrdenesCompra.class)
                    .add(Restrictions.eq("proveedores", proveedor));

            ordenes = (List<OrdenesCompra>) q.list();
            for (OrdenesCompra orden : ordenes) {
                orden.setTotalAbonado(this.getTotalAbonado(orden.getCuentaXPagar()));
            }

            tx.commit();
            return ordenes;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar las OrdenesCompra.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las OrdenesCompra.");
            }
        }
    }
    
    public List<OrdenesCompraView> getOrdenesComprasViewXProveedor(Integer proveedoresCodigo) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<OrdenesCompraView> ordenes = new ArrayList<OrdenesCompraView>();
        try {
            tx = session.beginTransaction();

            Criteria q = session.createCriteria(OrdenesCompraView.class)
                    .add(Restrictions.eq("proveedoresCodigo", proveedoresCodigo));

            ordenes = (List<OrdenesCompraView>) q.list();

            tx.commit();
            return ordenes;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar las OrdenesCompra.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las OrdenesCompra.");
            }
        }
    }

    public BigDecimal getTotalAbonado(CuentasXPagar cuenta) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        BigDecimal total = new BigDecimal("0.00");
        try {


            Criteria q = session.createCriteria(AbonosCuentasXPagar.class)
                    .add(Restrictions.eq("cuentasXPagar", cuenta))
                    .setProjection(Projections.sum("importe"));

            total = (BigDecimal) q.uniqueResult();

            return total;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar las OrdenesCompra.");

        } 
    }
}
