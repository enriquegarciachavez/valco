/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.math.BigDecimal;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.swing.table.DefaultTableModel;
import mapping.CuentasXPagar;
import mapping.OrdenesCompra;
import mapping.Productos;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import mapping.Tranferencias;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.StatelessSession;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
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
              tx.commit();
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
    
    public Productos getProductosXDescripcionOCodigo(String criterio) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          Productos producto = new Productos();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Productos.class);
                      if(StringUtils.isNumeric(criterio)){
                          q.add(Restrictions.eq("codigo", new Integer( criterio)));
                      }else{
                          
                          q.add(Restrictions.like("descripcion", criterio + "%"))
                                  .addOrder(Order.asc("descripcion"))
                                 .setMaxResults(1);
                      }
                      
                              
                      
                      
              producto = (Productos)q.uniqueResult();
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
    
    public ProductosInventario getProductosXCodigoBarras(String codigo) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          ProductosInventario producto = new ProductosInventario();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosInventario.class)
                      .add(Restrictions.eq("codigoBarras", codigo))
                      .add(Restrictions.eq("estatus", "ACTIVO"));
              q.setMaxResults(1);
              if(q.uniqueResult() == null){
                  throw new Exception("No se encontró el producto buscado.");
              }
              producto = (ProductosInventario)q.uniqueResult();
              Hibernate.initialize(producto.getProductosHasProveedores().getProductos());
              Hibernate.initialize(producto.getUbicaciones());
              Hibernate.initialize(producto.getProductosHasProveedores().getProveedores());
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
    
    public ProductosInventario getProductosXCodigoBarrasActivos(String codigo,Integer[] codigos) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          ProductosInventario producto = new ProductosInventario();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosInventario.class)
                      .add(Restrictions.eq("codigoBarras", codigo))
                      .add(Restrictions.eq("estatus", "ACTIVO"));
              if(codigos != null && codigos.length > 0){
                  q.add(Restrictions.not(Restrictions.in("codigo", codigos)));
              }
              q.setMaxResults(1);
              if(q.uniqueResult() == null){
                  throw new Exception("No se encontró el producto buscado.");
              }
              producto = (ProductosInventario)q.uniqueResult();
              Hibernate.initialize(producto.getProductosHasProveedores().getProductos());
              Hibernate.initialize(producto.getUbicaciones());
              Hibernate.initialize(producto.getProductosHasProveedores().getProveedores());
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
    
    public ProductosInventario getProductosXCodigoBarrasTransito(String codigo,Integer[] codigos) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          ProductosInventario producto = new ProductosInventario();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(ProductosInventario.class)
                      .add(Restrictions.eq("codigoBarras", codigo))
                      .add(Restrictions.eq("estatus", "EN TRANSITO"));
              if(codigos != null && codigos.length > 0){
                  q.add(Restrictions.not(Restrictions.in("codigo", codigos)));
              }
              q.setMaxResults(1);
              if(q.uniqueResult() == null){
                  throw new Exception("No se encontró el producto buscado.");
              }
              producto = (ProductosInventario)q.uniqueResult();
              Hibernate.initialize(producto.getProductosHasProveedores().getProductos());
              Hibernate.initialize(producto.getUbicaciones());
              Hibernate.initialize(producto.getProductosHasProveedores().getProveedores());
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
    
    public List<ProductosInventario> getCanalesDisponibles() throws Exception {
          Session session = HibernateUtil.getSessionFactory().getCurrentSession();
          //session.clear();
          Transaction tx = null;
          List<ProductosInventario> productos = new ArrayList<ProductosInventario>();

          try {
              tx = session.beginTransaction();
              //session.clear();
              Criteria q = session.createCriteria(ProductosInventario.class).add(Restrictions.eq("estatus","ACTIVO"));
              Criteria y = q.createCriteria("productosHasProveedores");
              Criteria x = y.createCriteria("productos").add(Restrictions.eq("generarSubproducto",true));
              //Query x = session.createQuery("FROM ProductosInventario");
              productos = (List<ProductosInventario>)x.list();
              for(ProductosInventario producto : productos){
                Hibernate.initialize(producto.getProductosHasProveedores());
                Hibernate.initialize(producto.getProductosHasProveedores().getProductos());
              }
              tx.commit();
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
              Hibernate.initialize(producto.getProductos());
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
              Criteria y= x.createCriteria("tipoProducto").add( Restrictions.disjunction()
                      .add(Restrictions.eq("descripcion", "CANAL DE RES"))
                       .add(Restrictions.eq("descripcion", "CANAL DE EQUINO"))
                        .add(Restrictions.eq("descripcion", "RES CASO ESPECIAL")));
              
              productos = (List<ProductosHasProveedores>)q.list();
              for(ProductosHasProveedores producto: productos){
                  Hibernate.initialize(producto.getProductos());
                  Hibernate.initialize(producto.getProveedores());
              }
              tx.commit();
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
              tx.commit();
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
        StatelessSession session = HibernateUtil.getSessionFactory().openStatelessSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.insert(producto);
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
                    session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el producto.");
            }
        }
    
    }
    
    public ProductosInventario getProductoPesadoActivo(String peso, Productos producto,DefaultTableModel model) throws Exception{
        Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          tx = session.beginTransaction();
          ProductosInventario productoInventario = new ProductosInventario();
          String hql = "From ProductosInventario PI "
                  + "inner join PI.productosHasProveedores as PHP"
                  + " inner join PHP.productos as P "
                  + "where PI.estatus = \"ACTIVO\" and  P.codigo ="+producto.getCodigo()
                  + " and PI.peso >= "+peso;
          if(model.getRowCount()>0){
              hql += " AND PI.codigo not in (";
              for(int row = 0; row < model.getRowCount(); row++){
                  hql += ((ProductosInventario)model.getValueAt(row, 0)).getCodigo();
                  if(model.getRowCount()-1 != row){
                      hql += ",";
                  }
              }
              hql += ")";
          }
              hql += " order by abs(peso - "+peso+")";
          try {
              Query query = session.createQuery(hql);
              query.setMaxResults(1);
              if(query.uniqueResult() == null){
                  throw new Exception("No se encontró el producto buscado en el inventario.");
              }
              productoInventario = (ProductosInventario) ((Object[])query.uniqueResult())[0];
              Hibernate.initialize(productoInventario.getProductosHasProveedores().getProductos());
              Hibernate.initialize(productoInventario.getUbicaciones());
              Hibernate.initialize(productoInventario.getProductosHasProveedores().getProveedores());
              tx.commit();
              return productoInventario;

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
    
    public ProductosInventario getProductoPesadoTransito(String peso, Productos producto,DefaultTableModel model) throws Exception{
        Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          ProductosInventario productoInventario = new ProductosInventario();
          String hql = "From ProductosInventario PI "
                  + "inner join PI.productosHasProveedores as PHP"
                  + " inner join PHP.productos as P "
                  + "where PI.estatus = \"EN TRANSITO\" and  P.codigo ="+producto.getCodigo()
                  + " and PI.peso >= "+peso;
          if(model.getRowCount()>0){
              hql += " AND PI.codigo not in (";
              for(int row = 0; row < model.getRowCount(); row++){
                  hql += ((ProductosInventario)model.getValueAt(row, 0)).getCodigo();
                  if(model.getRowCount()-1 != row){
                      hql += ",";
                  }
              }
              hql += ")";
          }
              hql += " order by abs(peso - "+peso+")";
          try {
              Query query = session.createQuery(hql);
              query.setMaxResults(1);
              if(query.uniqueResult() == null){
                  throw new Exception("No se encontró el producto buscado en el inventario.");
              }
              productoInventario = (ProductosInventario) ((Object[])query.uniqueResult())[0];
              Hibernate.initialize(productoInventario.getProductosHasProveedores().getProductos());
              Hibernate.initialize(productoInventario.getUbicaciones());
              Hibernate.initialize(productoInventario.getProductosHasProveedores().getProveedores());
              return productoInventario;

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
    
    public ProductosInventario getProductoPesado(String peso, Productos producto,Tranferencias transferencia) throws Exception{
        Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          tx = session.beginTransaction();
          ProductosInventario productoInventario = new ProductosInventario();
          String hql = "From Tranferencias TR "
                  + "inner join TR.productosInventarios PI "
                  + "inner join PI.productosHasProveedores as PHP"
                  + " inner join PHP.productos as P "
                  + "where PI.estatus = \"EN TRANSFERENCIA\" and  P.codigo ="+producto.getCodigo()
                  + " and TR.codigo="+transferencia.getCodigo()
                  + " and PI.peso >= "+peso;
          
              hql += " order by abs(peso - "+peso+")";
          try {
              Query query = session.createQuery(hql);
              query.setMaxResults(1);
              if(query.uniqueResult() == null){
                  throw new Exception("No se encontró el producto buscado en el inventario.");
              }
              productoInventario = (ProductosInventario) ((Object[])query.uniqueResult())[1];
              Hibernate.initialize(productoInventario.getProductosHasProveedores().getProductos());
              Hibernate.initialize(productoInventario.getUbicaciones());
              Hibernate.initialize(productoInventario.getProductosHasProveedores().getProveedores());
              tx.commit();
              return productoInventario;

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
    
}

