/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import mapping.ProductosInventario;
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
public class ReetiquetadoDAO implements ProcesosDAO {

    @Override
    public List<ProductosInventario> getCajasPorProceso(int procesoCodigo) throws Exception {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        List<ProductosInventario> productos = new ArrayList<ProductosInventario>();
        try {
            tx = session.beginTransaction();
            Criteria q = session.createCriteria(ProductosInventario.class)
                    .add(Restrictions.eq("reetiquetado", true));

            productos = q.list();
            tx.commit();
            return productos;

        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar los productos.");

        } finally {
            try {
                if (session.isOpen()) {
                    session.close();
                }
            } catch (HibernateException he) {
                throw new Exception("Ocurrió un error al consultar los productos.");
            }
        }
    }

}
