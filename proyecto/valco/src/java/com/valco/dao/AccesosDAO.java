/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Accesos;
import com.valco.pojo.UsuariosAccesos;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

/**
 *
 * @author 10015097
 */
public class AccesosDAO {

    public void insertarAccesos(Accesos accesos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(accesos);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el acceso.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el usuario.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el usuario.");
            }
        }
    }

    public void actualizarAccesos(Accesos accesos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(accesos);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el acceso.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el acceso.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el acceso.");
            }
        }
    }

    public void borrarAccesos(Accesos accesos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(accesos);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el acceso.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el acceso.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el acceso.");
            }
        }
    }

    public List<Accesos> getAccesos() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Criteria cr = session.createCriteria(Accesos.class);
            List<Accesos> accesos = (List<Accesos>) cr.list();
            return accesos;
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el acceso.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar el acceso.");
            }
        }
    }

    public List<Accesos> getAccesos(String nombre) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
        try {
            Criteria cr = session.createCriteria(Accesos.class);
            cr.add(Expression.eq("nombre", nombre));
            List<Accesos> accesos = (List<Accesos>) cr.list();
            return accesos;
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el acceso.");
        }
    }

    public List getAccesosGroupByCategorias() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Criteria cr = session.createCriteria(Accesos.class);
            cr.setProjection(Projections.projectionList()
                    .add(Projections.groupProperty("categoria"))
            );
            List categorias = cr.list();
            return categorias;
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el acceso.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar el acceso.");
            }
        }
    }

    public List<Accesos> getAccesosByCategoria(String categoria) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Criteria cr = session.createCriteria(Accesos.class);
            cr.add(Expression.eq("categoria", categoria));
            List<Accesos> usuarios = (List<Accesos>) cr.list();
            return usuarios;
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el acceso.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar el acceso.");
            }
        }
    }

    /**
     * Regresa Accesos por Correo, haciendo INNER JOIN con la tabla Usuarios
     *
     * @param correo
     * @return listAccesos
     * @throws java.lang.Exception
     */
    public List<UsuariosAccesos> getAccesosByCorreo(String correo) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Criteria cr = session.createCriteria(UsuariosAccesos.class, "usuariosAccesos");
            cr.createAlias("usuariosAccesos.usuarios", "usuarios");
            cr.createAlias("usuariosAccesos.accesos", "accesos");
            cr.add(Restrictions.eq("usuarios.correo", correo));
            List<UsuariosAccesos> listAccesos = (List) cr.list();
            return listAccesos;
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el acceso.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar el acceso.");
            }
        }
    }

    public List<UsuariosAccesos> getAccesosByCorreoCategoria(String correo, String categoria) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Criteria cr = session.createCriteria(UsuariosAccesos.class, "usuariosAccesos");
            cr.createAlias("usuariosAccesos.usuarios", "usuarios");
            cr.createAlias("usuariosAccesos.accesos", "accesos");
            cr.add(Restrictions.eq("usuarios.correo", correo));
            cr.add(Restrictions.eq("accesos.categoria", categoria));
            List<UsuariosAccesos> listAccesos = (List) cr.list();
            return listAccesos;
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el acceso.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar el acceso.");
            }
        }
    }
}
