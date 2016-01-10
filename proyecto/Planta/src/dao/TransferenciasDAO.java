/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import mapping.ProductosInventario;
import mapping.Tranferencias;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Administrador
 */
public class TransferenciasDAO {

    public void Transferir(Tranferencias transferencia, List<ProductosInventario> productos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(transferencia);
            for (ProductosInventario producto : productos) {
                session.update(producto);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al realizar la transferencia.");
                }
            }
            throw new Exception("Ocurrió un error al realizar la transferencia.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al realizar la transferencia.");
            }
        }
    }

    public void recibirProductoTransferido(List<ProductosInventario> productos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for (ProductosInventario producto : productos) {
                session.update(producto);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al recibir la transferencia.");
                }
            }
            throw new Exception("Ocurrió un error al recibir la transferencia.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al recibir la transferencia.");
            }
        }
    }

    public void actualizarTransferencias(Set<Tranferencias> transferencias) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Tranferencias trans = null;
        try {
            tx = session.beginTransaction();
            for (Tranferencias transferencia : transferencias) {
                Criteria q = session.createCriteria(Tranferencias.class)
                        .add(Restrictions.eq("codigo", transferencia.getCodigo()));
                trans = (Tranferencias) q.uniqueResult();
                boolean transferenciaCompleta = true;
                for (ProductosInventario producto : trans.getProductosInventarios()) {
                    if (producto.getEstatus().equals("EN TRANSFERENCIA")) {
                        transferenciaCompleta = false;
                        break;
                    }
                }
                if (transferenciaCompleta) {
                    trans.setEstatus("COMPLETA");
                    trans.setFechaLlegada(new Date());
                } else {
                    trans.setEstatus("INCOMPLETA");
                }
                session.update(trans);
            }
            tx.commit();
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al recibir la transferencia.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al recibir la transferencia.");
            }
        }
    }

    public List<Tranferencias> getTransferencias() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Tranferencias> transferencias = new ArrayList<Tranferencias>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Tranferencias.class);
            transferencias = (List<Tranferencias>) q.list();
            for (Tranferencias transferencia : transferencias) {
                Hibernate.initialize(transferencia.getProductosInventarios());
                Hibernate.initialize(transferencia.getMermas());
                Hibernate.initialize(transferencia.getUbicacionesBySalida());
                Hibernate.initialize(transferencia.getUbicacionesByDestino());
            }
            return transferencias;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar las transferencias.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las transferencias.");
            }
        }
    }
}
