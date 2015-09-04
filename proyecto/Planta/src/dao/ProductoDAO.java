/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import mapping.CuentasXPagar;
import mapping.OrdenesCompra;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Karla
 */
public class ProductoDAO {

    public void insertarProducto(Productos productos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
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

    public void actualizarProductosInventario(Object[] productos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for(Object producto : productos){
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
            Criteria q = session.createCriteria(Productos.class)
                      .setFetchMode("tipoProducto", FetchMode.JOIN);
              q.setFetchMode("unidadesDeMedida", FetchMode.JOIN);
              productos = (List<Productos>) q.list();
            return productos;

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
    
    public Productos getProductosXDescripcion(String descripcion) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          Productos producto = new Productos();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Productos.class)
                      .add(Restrictions.eq("descripcion", descripcion));
              producto = (Productos)q.uniqueResult();
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
    
    public ProductosInventario getProductosXCodigoBarras(String codigo) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          ProductosInventario producto = new ProductosInventario();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosInventario.class)
                      .add(Restrictions.eq("codigoBarras", codigo));
              producto = (ProductosInventario)q.uniqueResult();
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
    
    public List<ProductosInventario> getCanalesDisponibles() throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<ProductosInventario> productos = new ArrayList<ProductosInventario>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosInventario.class).add(Restrictions.eq("estatus","ACTIVO"));
              Criteria y = q.createCriteria("productosHasProveedores");
              Criteria x = y.createCriteria("productos").add(Restrictions.eq("generarSubproducto",true));
              productos = (List<ProductosInventario>)x.list();
              for(ProductosInventario producto : productos){
                Hibernate.initialize(producto.getProductosHasProveedores());
                Hibernate.initialize(producto.getProductosHasProveedores().getProductos());
              }
              return productos;

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
              return productos;

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
    
    public List<ProductosHasProveedores> getCanalesXProveedor(Proveedores proveedor) throws Exception{
        Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<ProductosHasProveedores> productos = new ArrayList<ProductosHasProveedores>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosHasProveedores.class)
                      .add(Restrictions.eq("proveedores", proveedor));
              Criteria x = q.createCriteria("productos").add(Restrictions.eq("generarSubproducto",true));
              Criteria y= x.createCriteria("tipoProducto").add(Restrictions.eq("descripcion", "CANAL"));
              productos = (List<ProductosHasProveedores>)q.list();
              for(ProductosHasProveedores producto: productos){
                  Hibernate.initialize(producto.getProductos());
                  Hibernate.initialize(producto.getProveedores());
              }
              return productos;

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
    
    public ProductosHasProveedores getProductosXProveedorYProducto(Proveedores proveedor, int productoCodigo) throws Exception{
        Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          ProductosHasProveedores productos = new ProductosHasProveedores();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosHasProveedores.class)
                      .add(Restrictions.eq("proveedores", proveedor));
              q.createCriteria("productos").add(Restrictions.eq("codigo", productoCodigo));
              productos = (ProductosHasProveedores)q.uniqueResult();
              return productos;

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

    public void insertarProducto(ProductosInventario producto) throws Exception{
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(producto);
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
    
}

