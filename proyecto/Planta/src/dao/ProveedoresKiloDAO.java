/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import mapping.Proveedores;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Component;

/**
 *
 * @author Administrador
 */
@Component
public class ProveedoresKiloDAO implements ProveedoresDAO {

   
    

  
    

    @Override
    public Collection getElements() throws Exception{
        Session session = null;
        Transaction tx = null;
        try {
            session = HibernateUtil.getSessionFactory().getCurrentSession();
            List<Proveedores> proveedores = new ArrayList<Proveedores>();
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Proveedores.class);
     
            q.addOrder(Order.asc("nombres"));
            proveedores = (List<Proveedores>) q.list();
            Set<Proveedores> proveedoresSet = new LinkedHashSet<>(proveedores);
            tx.commit();
            return new ArrayList<>(proveedoresSet);

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar los proveedores.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los proveedores.");
            }
        }
    }

    @Override
    public Object getElementsByCodeOrDesc(String criteria) throws Exception{
         Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Proveedores proveedor = new Proveedores();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(Proveedores.class);
      
            if (StringUtils.isNumeric(criteria)) {
                q.add(Restrictions.eq("codigo", new Integer(criteria)));
            } else {
                q.add(Restrictions.like("razonSocial", criteria, MatchMode.ANYWHERE));
            }

            q.setMaxResults(1);
            proveedor = (Proveedores) q.uniqueResult();
            tx.commit();
            return proveedor;

        } catch (HibernateException he) {
            tx.commit();
            throw new Exception("Ocurrió un error al consultar los proveedores.");
        }
    }

    @Override
    public Object[] getElementsArray() {
        try {
            return getElements().toArray();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return new ArrayList().toArray();
    }

}
