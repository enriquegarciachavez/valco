/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Hibernate.HibernateUtil;
import mapping.UsuariosAccesos;
import mapping.Accesos;
import mapping.Usuarios;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author 10015097
 */
public class UsuariosAccesosDAO {

    private UsuariosAccesos usuarioAcceso;
    private List<UsuariosAccesos> listDeleteUsuariosAccesos;
    private List<Usuarios> listInsertUsuarios;
    private List<Accesos> listInsertAccesos;
    private UsuariosDAO usuariosDao;
    private AccesosDAO accesosDao;

    public void insertDeleteUsuariosAccesos(String usuario, HashMap<String, Accesos[]> hashOrgAccesos, HashMap<String, Object[]> hashNewAccesos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        usuariosDao = new UsuariosDAO();
        accesosDao = new AccesosDAO();
        try {
            tx = session.beginTransaction();
            for (Map.Entry<String, Accesos[]> entrySet : hashOrgAccesos.entrySet()) {
                String key = entrySet.getKey();
                Accesos[] arrayOrgAccesos = entrySet.getValue();
                for (Accesos selectedAcceso : arrayOrgAccesos) {
                    listDeleteUsuariosAccesos = this.getUsuariosAccesos(usuario, selectedAcceso);
                    session.delete((UsuariosAccesos) listDeleteUsuariosAccesos.get(0));
                }
            }
            for (Map.Entry<String, Object[]> entrySet : hashNewAccesos.entrySet()) {
                String key = entrySet.getKey();
                Object[] arrayNewAccesos = entrySet.getValue();
                for (Object selectedAcceso : arrayNewAccesos) {
                    usuarioAcceso = new UsuariosAccesos();
                    listInsertUsuarios = usuariosDao.getUsuarios(usuario);
                    usuarioAcceso.setUsuarios(listInsertUsuarios.get(0));
                    usuarioAcceso.setEstatus(Boolean.TRUE);
                    //recuperar el acceso
                    listInsertAccesos = accesosDao.getAccesos((String) selectedAcceso);
                    usuarioAcceso.setAccesos(listInsertAccesos.get(0));
                    session.save(usuarioAcceso);
                }
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (HibernateException he) {
                    throw new Exception("Ocurrió un error al registrar el acceso.");
                }
            }
            throw new Exception("Ocurrió un error al registrar el acceso.");
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

    public void insertUsuariosAccesos(UsuariosAccesos usuariosAccesos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(usuariosAccesos);
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

    public void updateUsuariosAccesos(UsuariosAccesos usuariosAccesos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(usuariosAccesos);
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

    public void deleteUsuariosAccesos(UsuariosAccesos usuariosAccesos) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.delete(usuariosAccesos);
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

    public List<UsuariosAccesos> getUsuariosAccesos() throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Criteria cr = session.createCriteria(UsuariosAccesos.class);
            List<UsuariosAccesos> usuariosAccesos = (List<UsuariosAccesos>) cr.list();
            return usuariosAccesos;
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
    
        public List<UsuariosAccesos> getUsuarioAcceso(String usuario, String acceso) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Criteria cr = session.createCriteria(UsuariosAccesos.class, "usuariosAccesos");
            cr.createAlias("usuariosAccesos.usuarios", "usuarios");
            cr.createAlias("usuariosAccesos.accesos", "accesos");
            cr.add(Restrictions.eq("usuarios.correo", usuario));
            cr.add(Restrictions.eq("accesos.nombre", acceso));       
            List<UsuariosAccesos> usuariosAccesos = (List<UsuariosAccesos>) cr.list();
            return usuariosAccesos;
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

    public List<UsuariosAccesos> getUsuariosAccesos(String usuario, Accesos acceso) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
        try {
            Criteria cr = session.createCriteria(UsuariosAccesos.class, "usuariosAccesos");
            cr.createAlias("usuariosAccesos.usuarios", "usuarios");
            cr.createAlias("usuariosAccesos.accesos", "accesos");
            cr.add(Restrictions.eq("usuarios.correo", usuario));
            cr.add(Restrictions.eq("accesos.nombre", acceso.getNombre()));       
            List<UsuariosAccesos> usuariosAccesos = (List<UsuariosAccesos>) cr.list();
            return usuariosAccesos;
        } catch (HibernateException he) {
            throw new Exception("Ocurrió un error al consultar el acceso.");
        }
    }

    public List<UsuariosAccesos> getUsuariosAccesos(String correo,String url) throws Exception {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Criteria cr = session.createCriteria(UsuariosAccesos.class, "usuariosAccesos");
            cr.createAlias("usuariosAccesos.usuarios", "usuarios");
            cr.createAlias("usuariosAccesos.accesos", "accesos");
            cr.add(Restrictions.eq("usuarios.correo", correo));
            cr.add(Restrictions.eq("accesos.url", url));            
            List<UsuariosAccesos> listusuariosAccesos = (List<UsuariosAccesos>) cr.list();
            return listusuariosAccesos;
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
