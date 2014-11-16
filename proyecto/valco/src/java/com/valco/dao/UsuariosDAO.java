/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Usuarios;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

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
                session.close();
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
                session.close();
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar el usuario.");
            }
        }
    }
    
}
