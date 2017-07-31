/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Clientes;
import com.valco.pojo.ConceptosFactura;
import com.valco.pojo.Devoluciones;
import com.valco.pojo.Facturas;
import com.valco.pojo.Impuestos;
import com.valco.pojo.NotasCredito;
import com.valco.pojo.NotasDeVenta;
import com.valco.pojo.ProductosInventario;
import com.valco.servlets.ReportesXls;
import java.io.OutputStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

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

    public void insertarFactura(Facturas factura) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(factura);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al crear la factura.");
                }
            }
            throw new Exception("Ocurrió un error al crear la factura.");
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
                for (ConceptosFactura concepto : nota.getFacturas().getConceptosFacturas()) {
                    concepto.setFacturas(nota.getFacturas());
                    session.save(concepto);
                }
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

    /*public void insertarFacturaYActualizarNota(Facturas factura) throws Exception {
     Session session = HibernateUtil.getSessionFactory().getCurrentSession();
     Transaction tx = null;
     try {
     tx = session.beginTransaction();
     session.saveOrUpdate(factura.getNotasDeVenta());
     session.save(factura);
     for (ConceptosFactura concepto : factura.getConceptosFacturas()) {
     concepto.setFacturas(factura);
     session.save(concepto);
     }
     for (Impuestos impuesto : factura.getImpuestoses()) {
     impuesto.setFacturas(factura);
     session.save(impuesto);
     }
     tx.commit();
     } catch (Exception e) {
     if (tx != null) {
     try {
     tx.rollback();
     } catch (HibernateException he) {
     throw new Exception("Factura " + this.getConsecutivo() + ": Ocurrió un error al crear la factura.1" + he.getMessage());
     }
     } 
     String error = new String();
     for(StackTraceElement ste: Thread.currentThread().getStackTrace()){
     error += "\n" + ste;
     }
     throw new Exception("Factura " + this.getConsecutivo() + ":Ocurrió un error al crear la factura.2"+ e.getMessage() + error);
            
     } finally {
     try {
     if (session.isOpen()) {
     session.close();
     }
     } catch (HibernateException he) {
     throw new Exception("Factura " + this.getConsecutivo() + ":Ocurrió un error al crear las facturas.3"+ he.getMessage());
     }
     }
     }*/
    public void insertarFacturaYActualizarNota(Facturas factura) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;

        tx = session.beginTransaction();
        try {
            session.saveOrUpdate(factura.getNotasDeVenta());
        } catch (Exception e) {
            throw new Exception("Fallo en el primero" + e.getMessage());
        }
        try {
            
            session.save(factura);
        } catch (Exception e) {
            throw new Exception("Fallo en el segundo" + e.getMessage());
        }
        try {
            for (ConceptosFactura concepto : factura.getConceptosFacturas()) {
                concepto.setFacturas(factura);
                session.save(concepto);
            }
        } catch (Exception e) {
            throw new Exception("Fallo en el tercero " + e.getMessage() + e.getCause());
        }

        try {
            for (Impuestos impuesto : factura.getImpuestoses()) {
                impuesto.setFacturas(factura);
                session.save(impuesto);
            }
        } catch (Exception e) {
            throw new Exception("Fallo en el cuarto " + e.getMessage());
        }

        tx.commit();

    }

    public void ActualizarFacturaYNotas(Facturas factura) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(factura);
            for (NotasDeVenta nota : factura.getNotasDeVentas()) {
                session.update(nota);
            }

            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Factura " + this.getConsecutivo() + ": Ocurrió un error al crear la factura.");
                }
            }
            throw new Exception("Factura " + this.getConsecutivo() + ":Ocurrió un error al crear la factura.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Factura " + this.getConsecutivo() + ":Ocurrió un error al crear las facturas.");
            }
        }
    }

    public void actualizarFacturas(List<Facturas> facturas) throws Exception {
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

    public void actualizarFactura(Facturas factura) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(factura);
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

    public void borrarFacturas(List<Facturas> facturas) throws Exception {
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
            tx.commit();
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

    public List<Facturas> getFacturas(Integer noFactura, Integer noNota) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Facturas> facturas = new ArrayList<Facturas>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Facturas.class);
            if (noFactura != null) {
                q.add(Restrictions.eq("codigo", noFactura));
            }
            if (noNota != null) {
                q.createCriteria("notasDeVenta").add(Restrictions.eq("folio", noNota));
                //q.createAlias("notasDeVenta", "nota").add(Restrictions.eqProperty("codigo", noNota.toString()));
            }
            facturas = (List<Facturas>) q.list();
            tx.commit();
            return facturas;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar las facturas.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las facturas.");
            }
        }
    }

    public List<Facturas> getFacturasActivas(Integer noFactura, Integer noNota) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Facturas> facturas = new ArrayList<Facturas>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Facturas.class);
            if (noFactura != null) {
                q.add(Restrictions.eq("codigo", noFactura));
            }
            if (noNota != null) {
                q.createCriteria("notasDeVenta").add(Restrictions.eq("folio", noNota));
                //q.createAlias("notasDeVenta", "nota").add(Restrictions.eqProperty("codigo", noNota.toString()));
            }
            q.add(Restrictions.eq("estatus", "ACTIVO"));
            facturas = (List<Facturas>) q.list();
            tx.commit();
            return facturas;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar las facturas.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las facturas.");
            }
        }
    }

    public Integer getConsecutivo() throws Exception {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReportesXls.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(ReportesXls.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(ReportesXls.class.getName()).log(Level.SEVERE, null, ex);
        }
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/valco", "admin3ZheGrA", "1VtHQW5M-3g-");) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT SECUENCIA\n"
                    + "FROM SECUENCIAS\n"
                    + "WHERE TABLE_NAME = 'FACTURAS'");
            rs.next();
            Integer consecutivo = rs.getInt("SECUENCIA");
            return consecutivo;
        } catch (Exception e) {
            throw new Exception("Ocurrió un error al consultar el consecutivo");
        }

    }

    public List<NotasDeVenta> getNotasXFactura(Facturas factura) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<NotasDeVenta> notasDeVenta = new ArrayList<NotasDeVenta>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(NotasDeVenta.class);
            q.add(Restrictions.eq("facturas", factura));

            notasDeVenta = (List<NotasDeVenta>) q.list();
            for (NotasDeVenta nota : notasDeVenta) {
                for (ProductosInventario producto : nota.getProductosInventarios()) {
                    Hibernate.initialize(producto);
                }
            }
            tx.commit();
            return notasDeVenta;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar las Notas de venta.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar las Notas de venta.");
            }
        }
    }

    public void crearNotadeCredito(NotasCredito nota, List<ProductosInventario> productos, List<Devoluciones> devoluciones) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(nota);
            for (ProductosInventario producto : productos) {
                session.saveOrUpdate(producto);
            }
            for (Devoluciones devolucion : devoluciones) {
                session.save(devolucion);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    tx.commit();
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

}
