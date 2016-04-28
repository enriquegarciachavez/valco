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
import mapping.Mermas;
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

    public void actualizarTransferencias(Tranferencias transferencia, Mermas merma) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
                boolean transferenciaCompleta = true;
                for (ProductosInventario producto : transferencia.getProductosInventarios()) {
                    session.update(producto);
                    if (producto.getEstatus().equals("EN TRANSFERENCIA")) {
                        transferenciaCompleta = false;
                    }
                }
                if (transferenciaCompleta) {
                    transferencia.setEstatus("COMPLETA");
                    transferencia.setFechaLlegada(new Date());
                } else {
                    transferencia.setEstatus("INCOMPLETA");
                }
                if(merma != null){
                    session.save(merma);
                }
                session.update(transferencia);
            
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
            tx.commit();
            return transferencias;

        } catch (HibernateException he) {
            tx.commit();
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
    
    public Tranferencias getTransferenciaXCodigo(Integer codigo) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        Tranferencias transferencia = new Tranferencias();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Tranferencias.class)
                    .add(Restrictions.eq("codigo", codigo));
            if(q.uniqueResult() == null){
                throw new Exception("No se encontrò la transferencia buscada");
            }
            transferencia = (Tranferencias) q.uniqueResult();
            Hibernate.initialize(transferencia.getProductosInventarios());
            for(ProductosInventario producto : transferencia.getProductosInventarios()){
                Hibernate.initialize(producto.getProductosHasProveedores().getProveedores());
                Hibernate.initialize(producto.getProductosHasProveedores().getProductos());
                Hibernate.initialize(producto.getMermas());
            }
            Hibernate.initialize(transferencia.getMermas());
            Hibernate.initialize(transferencia.getUbicacionesBySalida());
            Hibernate.initialize(transferencia.getUbicacionesByDestino());
            tx.commit();
            return transferencia;

        } catch (HibernateException he) {
            tx.commit();
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
