/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 *
 * @author Karla
 */

import Hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import mapping.Usuarios;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Enrique
 */
public class UsuariosDAO {
    
     public void insertarUsuario(Usuarios usuarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(usuarios);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el usuario.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el usuario.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al registrar el usuario.");
            }
        }
    }
     public void actualizarUsuario(Usuarios usuarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(usuarios);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al modificar el usuario.");
                }
            }
            throw new Exception("Ocurrió un error al modificar el usuario.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al modificar el usuario.");
            }
        }
    }
      public void borrarUsuario(Usuarios usuarios) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(usuarios);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al borrar el usuario.");
                }
            }
            throw new Exception("Ocurrió un error al borrar el usuario.");
        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al borrar el usuario.");
            }
        }
    }
     public List<Usuarios> getUsuarios() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Usuarios> usuarios = new ArrayList<Usuarios>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Usuarios.class)
                    .setFetchMode("ubicaciones", FetchMode.JOIN);

            usuarios = (List<Usuarios>) q.list();
            return usuarios;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el usuario.");

        } finally {
            try {
                if(session.isOpen()){
                session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar el usuario.");
            }
        }
    }
     
     public Usuarios getUsuariosXCorreo(String correo) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          Usuarios usuario = new Usuarios();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(Usuarios.class)
                      .add(Restrictions.eq("correo", correo));
              usuario = (Usuarios)q.uniqueResult();
              return usuario;

          } catch (HibernateException he) {
              throw new Exception("Ocurrió un error al consultar los clientes.");

          } finally {
              try {
                  if(session.isOpen()){
                session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar los clientes.");
              }
        }
    }
     
     public Usuarios getUsuarios(String correo, String password) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();           
            Criteria cr = session.createCriteria(Usuarios.class);
            cr.add(Expression.eq("correo", correo));
            cr.add(Expression.eq("password", password));
            Usuarios usuarios = (Usuarios) cr.uniqueResult();
            Hibernate.initialize(usuarios.getUbicaciones());
            return usuarios;
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el usuario.");
        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar el usuario.");
            }
        }
    }
     
      public List<Usuarios> getUsuarios(String correo) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
        try {
            Criteria cr = session.createCriteria(Usuarios.class);
            cr.add(Expression.eq("correo", correo));
            List<Usuarios> usuarios = (List<Usuarios>) cr.list();
            return usuarios;
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el usuario.");
        } 
    }
    
}
