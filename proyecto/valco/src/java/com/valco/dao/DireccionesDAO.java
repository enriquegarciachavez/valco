/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.dao;

import com.valco.HibernateUtil;
import com.valco.pojo.CodigoPostalView;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Karla
 */
public class DireccionesDAO {
    
    public List<CodigoPostalView> getDireccionXCP(String cp) throws Exception {
          Session session = HibernateUtil.getSessionFactory().openSession();
          Transaction tx = null;
          List<CodigoPostalView> direcciones = new ArrayList<>();
          try {
              tx = session.beginTransaction();
              Criteria q = session.createCriteria(CodigoPostalView.class)
                      .add(Restrictions.eq("codigoPostal", cp));
              direcciones = q.list();
              tx.commit();
              return direcciones;

          } catch (HibernateException he) {
              tx.commit();
              throw new Exception("Ocurrió un error al consultar las direcciones en base al codigo postal.");

          } finally {
              try {
                  if (session.isOpen()) {
                    session.close();
                }
              } catch (HibernateException he) {
                  throw new Exception("Ocurrió un error al consultar las direcciones en base al codigo postal.");
              }
        }
    }
    
}
