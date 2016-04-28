/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.OrdenesCompra;
import com.valco.pojo.ProductosHasProveedores;
import com.valco.pojo.ProductosInventario;
import com.valco.pojo.ProductosInventarioAgrupados;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

/**
 *
 * @author Enrique
 */
public class OrdenesCompraDAO {

    public void insertarOrdenesCompra(OrdenesCompra ordenesCompra) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(ordenesCompra);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar la Orden de Compra.");
                }
            }
            throw new Exception("Ocurrió un error al registrar la Orden de Compra.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar la Orden de Compra.");
            }
        }
    }

    public void actualizarOrdenesCompra(OrdenesCompra ordenesCompra) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(ordenesCompra);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar la Orden de Compra.");
                }
            }
            throw new Exception("Ocurrió un error al modificar la Orden de Compra.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar la Orden de Compra.");
            }
        }
    }

    public void borrarOrdenesCompra(OrdenesCompra ordenesCompra) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(ordenesCompra);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar la Orden de Compra.");
                }
            }
            throw new Exception("Ocurrió un error al borrar la Orden de Compra.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar la Orden de Compra.");
            }
        }
    }

    public List<OrdenesCompra> getOrdenesCompra() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<OrdenesCompra> ordenesCompra = new ArrayList<OrdenesCompra>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(OrdenesCompra.class);
            ordenesCompra = (List<OrdenesCompra>) q.list();
            for (OrdenesCompra orden : ordenesCompra) {
                Hibernate.initialize(orden.getProveedores());
            }
            tx.commit();
            return ordenesCompra;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar la Orden de Compra.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar la Orden de Compra.");
            }
        }
    }

    public List<ProductosInventario> getProductosInventarioXOrden(OrdenesCompra ordenCompra) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<ProductosInventario> productoInventario = new ArrayList<ProductosInventario>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .add(Restrictions.eq("ordenesCompra", ordenCompra));
            productoInventario = (List<ProductosInventario>) q.list();
            tx.commit();
            return productoInventario;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar los Productos de la Orden.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los Productos de la Orden.");
            }
        }
    }

    public List<ProductosInventarioAgrupados> getProductosInventarioAgrupadoXOrden(OrdenesCompra ordenCompra) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<ProductosInventarioAgrupados> productoInventario = new ArrayList<ProductosInventarioAgrupados>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .add(Restrictions.eq("ordenesCompra", ordenCompra));
            q.setProjection(Projections.projectionList()
                    .add(Projections.groupProperty("productosHasProveedores").as("producto"))
                    .add(Projections.groupProperty("productosHasProveedores").as("productoModificado"))
                    .add(Projections.property("precio").as("precio"))
                    .add(Projections.property("precio").as("precioModificado"))
                    .add(Projections.sum("peso").as("peso"))
            );
            q.setResultTransformer(Transformers.aliasToBean(ProductosInventarioAgrupados.class));
            productoInventario = (List<ProductosInventarioAgrupados>) q.list();
            for (ProductosInventarioAgrupados productoAgrupado : productoInventario) {
                productoAgrupado.setProductos(this.getProductosInventarioXOrdenYProducto(ordenCompra, productoAgrupado.getProducto()));
            }
            tx.commit();
            return productoInventario;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar los Productos de la Orden.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los Productos de la Orden.");
            }
        }
    }

    public List<ProductosInventario> getProductosInventarioXOrdenYProducto(OrdenesCompra ordenCompra, ProductosHasProveedores producto) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<ProductosInventario> productoInventario = new ArrayList<ProductosInventario>();
        try {
            //tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .add(Restrictions.eq("ordenesCompra", ordenCompra))
                    .add(Restrictions.eq("productosHasProveedores", producto));

            productoInventario = (List<ProductosInventario>) q.list();
            tx.commit();
            return productoInventario;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar los Productos de la Orden.");

        }
    }

    public void actualizarOrdenYProductos(List<ProductosInventario> productosActualizar, List<ProductosInventario> productosBorrar, OrdenesCompra orden) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();

            session.saveOrUpdate(orden);

            if (productosActualizar != null) {
                for (ProductosInventario producto : productosActualizar) {
                    session.saveOrUpdate(producto);
                }
            }

            if (productosBorrar != null) {
                for (ProductosInventario producto : productosBorrar) {
                    session.delete(producto);
                }
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el producto.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el producto.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el producto.");
            }
        }
    }

}
