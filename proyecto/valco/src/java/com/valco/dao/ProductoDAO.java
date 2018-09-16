/*
     * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.CuentasXPagar;
import com.valco.pojo.InventarioGlobal;
import com.valco.pojo.OrdenesCompra;
import com.valco.pojo.Productos;
import com.valco.pojo.ProductosHasProveedores;
import com.valco.pojo.ProductosInventario;
import com.valco.pojo.Proveedores;
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
 * @author Enrique
 */
public class ProductoDAO {

    public void insertarProducto(Productos productos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        ProductosHasProveedores prodHasPorv = new ProductosHasProveedores();
        Proveedores proveedor = new Proveedores();
        proveedor.setCodigo(9999999);
        prodHasPorv.setProductos(productos);
        prodHasPorv.setProveedores(proveedor);
        prodHasPorv.setCodigoProveedor(String.format("%05d", productos.getCodigo()));
        prodHasPorv.setPrecioSugerido(productos.getPrecioSugerido());
        try {
            tx = session.beginTransaction();
            session.save(productos);
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

    public void actualizarProducto(Productos productos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(productos);
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
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el producto.");
            }
        }
    }
    
    public void actualizarProductosInventario(List<ProductosInventario> productos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for(ProductosInventario producto : productos){
                session.update(producto);
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
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el producto.");
            }
        }
    }

    public void borrarProducto(Productos productos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(productos);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el producto.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el producto.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el producto.");
            }
        }
    }

    public List<Productos> getProductos() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Productos> productos = new ArrayList<Productos>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Productos.class);
                      
              productos = (List<Productos>) q.list();
              
              for(Productos producto: productos){
                  Hibernate.initialize(producto.getSubfamilias());
                  Hibernate.initialize(producto.getSubfamilias().getFamilias());
                  Hibernate.initialize(producto.getTipoProducto());
                  Hibernate.initialize(producto.getUnidadesDeMedida());
              }
              tx.commit();
            return productos;

        } catch (HibernateException he) {
            tx.commit();
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
    
    public List<InventarioGlobal> getInventarioGlobal() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<InventarioGlobal> inventarioGlobal = new ArrayList<InventarioGlobal>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(InventarioGlobal.class);
                      
              inventarioGlobal = (List<InventarioGlobal>) q.list();
              
              
              tx.commit();
            return inventarioGlobal;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar el inventario.");

        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar el inventario.");
            }
        }
    }
    
    public Productos getProductosXDescripcion(String descripcion) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          Productos producto = new Productos();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Productos.class)
                      .add(Restrictions.eq("descripcion", descripcion));
              producto = (Productos)q.uniqueResult();
              tx.commit();
              return producto;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar los productos.");

          } finally {
              try {
                  if(session.isOpen()){
                    session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los productos.");
              }
        }
    }
    
    public ProductosInventario getProductosXCodigoBarras(String codigo) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          ProductosInventario producto = new ProductosInventario();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosInventario.class)
                      .add(Restrictions.eq("codigoBarras", codigo));
              producto = (ProductosInventario)q.uniqueResult();
              tx.commit();
              return producto;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar los productos.");

          } finally {
              try {
                  if(session.isOpen()){
                    session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los productos.");
              }
        }
    }
    
    public ProductosInventario getProductosXCodigoBarrastransferencia(String codigo) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          ProductosInventario producto = new ProductosInventario();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosInventario.class)
                      .add(Restrictions.eq("codigoBarras", codigo));
              producto = (ProductosInventario)q.uniqueResult();
              if(producto != null){
                Hibernate.initialize(producto.getTranferencias());
                Hibernate.initialize(producto.getTranferencias().getUbicacionesByDestino());
              }
              tx.commit();
              return producto;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar los productos.");

          } finally {
              try {
                  if(session.isOpen()){
                    session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los productos.");
              }
        }
    }
    
    public ProductosHasProveedores getProductoXProveYCodigo(Proveedores proveedor, String codigo) throws Exception{
        Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          ProductosHasProveedores producto = new ProductosHasProveedores();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosHasProveedores.class)
                      .add(Restrictions.eq("proveedores", proveedor))
                      .add(Restrictions.eq("codigoProveedor", codigo));
              producto = (ProductosHasProveedores)q.uniqueResult();
              tx.commit();
              return producto;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los productos.");

          } finally {
              try {
                  if(session.isOpen()){
                    session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los productos.");
              }
        }
    }
    
    public void recibirProductos(List<ProductosInventario> productos, OrdenesCompra orden) throws Exception{
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(orden);
            CuentasXPagar cuenta = new CuentasXPagar();
            cuenta.setEstatus("ACTIVO");
            cuenta.setFecha(new Date());
            cuenta.setOrdenesCompra(orden);
            cuenta.setImporte(orden.getTotal());
            session.save(cuenta);
            for(ProductosInventario producto : productos){
                producto.setOrdenesCompra(orden);
                session.save(producto);
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
    public List<ProductosHasProveedores> getProductosXProveedor(Proveedores proveedor) throws Exception{
        Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<ProductosHasProveedores> productos = new ArrayList<ProductosHasProveedores>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosHasProveedores.class)
                      .add(Restrictions.eq("proveedores", proveedor));
              productos = (List<ProductosHasProveedores>)q.list();
              for(ProductosHasProveedores producto: productos){
                  Hibernate.initialize(producto.getProductos());
                  Hibernate.initialize(producto.getProveedores());
              }
              tx.commit();
              return productos;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar los productos.");

          } finally {
              try {
                  if(session.isOpen()){
                    session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los productos.");
              }
        }
    }
    
    public List<ProductosHasProveedores> getProductosAbarrotesXProveedor(Proveedores proveedor) throws Exception{
        Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<ProductosHasProveedores> productos = new ArrayList<ProductosHasProveedores>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosHasProveedores.class)
                      .add(Restrictions.eq("proveedores", proveedor))
                      .createAlias("productos", "producto")
                      .add(Restrictions.eq("producto.abarrotes", true));
              productos = (List<ProductosHasProveedores>)q.list();
              for(ProductosHasProveedores producto: productos){
                  Hibernate.initialize(producto.getProductos());
                  Hibernate.initialize(producto.getProveedores());
              }
              tx.commit();
              return productos;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar los productos.");

          } finally {
              try {
                  if(session.isOpen()){
                    session.close();
                  }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los productos.");
              }
        }
    }
    
    public List<ProductosInventario> getProductosEnTransito(Repartidores repartidor) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<ProductosInventario> productos = new ArrayList<ProductosInventario>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                      .add(Restrictions.eq("repartidor", repartidor))
                    .add(Restrictions.eq("estatus", "EN TRANSITO"));
             
              productos = (List<ProductosInventario>) q.list();
             
              tx.commit();
            return productos;

        } catch (HibernateException he) {
            tx.commit();
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

}
