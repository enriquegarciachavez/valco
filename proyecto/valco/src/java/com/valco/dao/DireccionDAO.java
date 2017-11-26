/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.Estado;
import com.valco.pojo.Municipio;
import com.valco.pojo.Pais;
import java.util.ArrayList;
import java.util.List;
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
public class DireccionDAO {

    public List<Pais> getPaises() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Pais> paises = new ArrayList<Pais>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Pais.class);
            paises = (List<Pais>) q.list();
            tx.commit();
            return paises;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar los paises.");

        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los paises.");
            }
        }
    }
    
    public List<Estado> getEstados(Pais pais) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Estado> estados = new ArrayList<Estado>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Estado.class)
                    .add(Restrictions.eq("pais", pais));
            
            estados = (List<Estado>) q.list();
            tx.commit();
            return estados;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar los Estados.");

        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los Estados.");
            }
        }
    }
    
    
    public List<Municipio> getEstados(Estado estado) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Municipio> municipios = new ArrayList<Municipio>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Municipio.class)
                    .add(Restrictions.eq("estado", estado));
            
            municipios = (List<Municipio>) q.list();
            tx.commit();
            return municipios;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar los Estados.");

        } finally {
            try {
                if(session.isOpen()){
                    session.close();
                  }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los Estados.");
            }
        }
    }

}
