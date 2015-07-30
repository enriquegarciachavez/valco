/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.beans;

import com.sun.faces.component.visit.FullVisitContext;
import com.valco.converters.EntityConverter;
import com.valco.dao.AccesosDAO;
import com.valco.dao.UsuariosAccesosDAO;
import com.valco.pojo.Accesos;
import com.valco.pojo.Usuarios;
import com.valco.pojo.UsuariosAccesos;
import com.valco.utility.MsgUtility;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Iterator;
import javax.annotation.PostConstruct;
import javax.el.ExpressionFactory;
import javax.el.MethodExpression;
import javax.faces.application.Application;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.component.UIComponent;
import javax.faces.component.UIForm;
import javax.faces.component.UIOutput;
import javax.faces.component.UIPanel;
import javax.faces.component.UISelectItem;
import javax.faces.component.UISelectItems;
import javax.faces.component.UISelectMany;
import javax.faces.component.UISelectOne;
import javax.faces.component.UIViewRoot;
import javax.faces.component.visit.VisitCallback;
import javax.faces.component.visit.VisitContext;
import javax.faces.component.visit.VisitResult;
import javax.faces.context.FacesContext;
import javax.faces.event.AjaxBehaviorEvent;
import javax.faces.event.BehaviorEvent;
import org.omnifaces.component.output.OutputLabel;
import org.omnifaces.converter.SelectItemsConverter;
import org.primefaces.behavior.ajax.AjaxBehavior;
import org.primefaces.behavior.ajax.AjaxBehaviorListenerImpl;
import org.primefaces.component.commandbutton.CommandButton;
import org.primefaces.component.panel.Panel;
import org.primefaces.component.panelgrid.PanelGrid;

/**
 *
 * @author 10015097
 */
@ManagedBean
@ViewScoped
public class AccesosBean implements java.io.Serializable {

    /**
     * Creates a new instance of AccesosBean
     */
    //BEANs
    private UsuariosBean usuariosBean;
    //DAOs
    private AccesosDAO accesosDao;
    private UsuariosAccesosDAO usuariosAccesosDao;
    //Create component
    private UIForm form;
    private UIPanel grid;
    private UIPanel panel;
    private UISelectOne menuUsuarios;
    private UISelectItems itemsUsuaros;
    private UISelectItem itemDefault;
    private CommandButton botonGuardar;
    private OutputLabel labelMenuUsuarios;
    private UIOutput breakLine;
    //Lists
    private List accesosGroupByCategoria;
    private List<Usuarios> listUsuarios;
    private List<UsuariosAccesos> listAccesosByUsuariosAccesos;
    private List<Accesos> listAccesos;
    //HashMaps
    private HashMap<String, Accesos[]> hashAccesosOriginales;
    private HashMap<String, Object[]> hashAccesosNuevos;
    //Aux variables
    private String categorias = "";

    private MethodExpression meUpdateGridAccesos;
    private MethodExpression meSaveGridAccesos;
    private AjaxBehavior ajaxChange;
    private AjaxBehavior ajaxSubmit;
    private ExpressionFactory efChange;
    private ExpressionFactory efSubmit;
    private EntityConverter ec;
    private SelectItemsConverter sic;

    @PostConstruct
    public void init() {
        try {
            //Instance of components
            FacesContext facesContext = FacesContext.getCurrentInstance();
            Application app = facesContext.getApplication();
            form = new UIForm();
            grid = new PanelGrid();
            menuUsuarios = new UISelectOne();
            
            itemsUsuaros = new UISelectItems();
            labelMenuUsuarios = new OutputLabel();
            itemDefault = new UISelectItem();
            labelMenuUsuarios.setValue("Usuarios:");
            labelMenuUsuarios.setEscape(true);
            panel = (Panel) app.createComponent(facesContext,
                    "org.primefaces.component.Panel",
                    "org.primefaces.component.PanelRender");
            //Define types
            ((Panel) panel).setHeader("Accesos");
            ((Panel) panel).setToggleable(false);
            panel.setId("panel");
            grid.setRendererType("javax.faces.Grid");
            grid.getAttributes().put("columns", 3);
            grid.getAttributes().put("cellpadding", 5);
            grid.getAttributes().put("style", "margin-bottom:10px");
            accesosDao = new AccesosDAO();
            usuariosBean = new UsuariosBean();
            usuariosBean.init();
            menuUsuarios = (UISelectOne) app.createComponent(facesContext,
                    "org.primefaces.component.SelectOneMenu",
                    "org.primefaces.component.SelectOneMenuRenderer");
            listUsuarios = usuariosBean.getUsuarios();
            menuUsuarios.setId("usuariosSelectOneChoice");
            itemsUsuaros.setValue(listUsuarios);
            itemDefault.setItemLabel("Selecciona uno:");
            itemDefault.setItemValue("Selecciona uno:");
            itemDefault.setNoSelectionOption(true);
            menuUsuarios.getChildren().add(itemDefault);
            menuUsuarios.getChildren().add(itemsUsuaros);
            labelMenuUsuarios.setFor(menuUsuarios.getId());
            accesosGroupByCategoria = accesosDao.getAccesosGroupByCategorias();
            Iterator i = accesosGroupByCategoria.iterator();
            efChange = app.getExpressionFactory();
            meUpdateGridAccesos = efChange.createMethodExpression(facesContext.getELContext(),
                    "#{accesosBean.updateGridAccesos()}",
                    null,
                    new Class<?>[]{BehaviorEvent.class});
            ajaxChange = (AjaxBehavior) app.createBehavior(AjaxBehavior.BEHAVIOR_ID);
            ajaxChange.setProcess("@this");
            ajaxChange.addAjaxBehaviorListener(new AjaxBehaviorListenerImpl(meUpdateGridAccesos, meUpdateGridAccesos));
            while (i.hasNext()) {
                String accesoCategoria = i.next().toString();
                categorias = categorias + accesoCategoria + " ";
            }
            ajaxChange.setUpdate(categorias);
            menuUsuarios.addClientBehavior("change", ajaxChange);
            menuUsuarios.setConverter(sic);
            grid.getChildren().add(labelMenuUsuarios);
            grid.getChildren().add(menuUsuarios);
            breakLine = new UIOutput();
            breakLine.setValue("<br/><br/>");
            grid.getChildren().add(breakLine);
            Iterator j = accesosGroupByCategoria.iterator();
            while (j.hasNext()) {
                String accesoCategoria = j.next().toString();
                UISelectMany checkAccesosCategoria;
                UISelectItems itemsAccesosCategoria = new UISelectItems();
                List<Accesos> listAccesosCategoria;
                OutputLabel labelAccesosCategoria = new OutputLabel();
                listAccesosCategoria = accesosDao.getAccesosByCategoria(accesoCategoria);
                itemsAccesosCategoria.setValue(listAccesosCategoria);
                checkAccesosCategoria = (UISelectMany) app.createComponent(facesContext,
                        "org.primefaces.component.SelectManyCheckbox",
                        "org.primefaces.component.SelectManyCheckboxRenderer");
                checkAccesosCategoria.setId(accesoCategoria);
                checkAccesosCategoria.getChildren().add(itemsAccesosCategoria);
                checkAccesosCategoria.getAttributes().put("layout", "grid");
                checkAccesosCategoria.getAttributes().put("columns", 3);
                checkAccesosCategoria.setConverter(ec);
                labelAccesosCategoria.setValue(accesoCategoria + ":");
                labelAccesosCategoria.setFor(checkAccesosCategoria.getId());
                labelAccesosCategoria.setEscape(true);
                grid.getChildren().add(labelAccesosCategoria);
                grid.getChildren().add(checkAccesosCategoria);
            }
            botonGuardar = new CommandButton();
            botonGuardar.setValue("Guardar");
            botonGuardar.setId("guardar");
            botonGuardar.setUpdate("formPermisos");
            ajaxSubmit = (AjaxBehavior) app.createBehavior(AjaxBehavior.BEHAVIOR_ID);
            ajaxSubmit.setProcess("@this");
            efSubmit = app.getExpressionFactory();
            meSaveGridAccesos = efSubmit.createMethodExpression(facesContext.getELContext(),
                    "#{accesosBean.saveGridAccesos()}",
                    void.class,
                    new Class<?>[]{AjaxBehaviorEvent.class});
            ajaxSubmit.addAjaxBehaviorListener(new AjaxBehaviorListenerImpl(meSaveGridAccesos, meSaveGridAccesos));
            botonGuardar.setActionExpression(meSaveGridAccesos);
            botonGuardar.addClientBehavior("submit", ajaxSubmit);
            grid.getChildren().add(botonGuardar);
            panel.getChildren().add(grid);
            form.getChildren().add(panel);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public UIForm getForm() {
        return form;
    }

    public void setForm(UIForm form) {
        this.form = form;
    }

    public void saveGridAccesos() {
        try {
            usuariosAccesosDao = new UsuariosAccesosDAO();
            String usuario = menuUsuarios.getValue().toString();
            if ((usuario != null) && (!usuario.equals("Selecciona uno:"))) {
                Iterator i = accesosGroupByCategoria.iterator();
                hashAccesosNuevos = new HashMap<String, Object[]>();
                UISelectMany component;
                while (i.hasNext()) {
                    String accesoCategoria = i.next().toString();
                    component = (UISelectMany) findComponent(accesoCategoria);
                    hashAccesosNuevos.put(accesoCategoria, (Object[]) component.getValue());
                }
                usuariosAccesosDao.insertDeleteUsuariosAccesos(usuario, hashAccesosOriginales, hashAccesosNuevos);
                MsgUtility.showInfoMeage("Actualización exitosa al usuario: " + usuario + " y sus accesos. ");
            } else {
                MsgUtility.showErrorMeage("¡Por favor selecciona algún usuario!");
            }
        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Error al guardar los accesos...");
        }

    }

    public UIComponent findComponent(final String id) {
        FacesContext context = FacesContext.getCurrentInstance();
        UIViewRoot root = context.getViewRoot();
        final UIComponent[] found = new UIComponent[1];
        root.visitTree(new FullVisitContext(context), new VisitCallback() {
            @Override
            public VisitResult visit(VisitContext context, UIComponent component) {
                if (component.getId().equals(id)) {
                    found[0] = component;
                    return VisitResult.COMPLETE;
                }
                return VisitResult.ACCEPT;
            }
        });
        return found[0];
    }

    public void updateGridAccesos() {
        try {
            String usuario = menuUsuarios.getValue().toString();
            Iterator i = accesosGroupByCategoria.iterator();
            UISelectMany component;
            hashAccesosOriginales = new HashMap<String, Accesos[]>();
            while (i.hasNext()) {
                listAccesos = new ArrayList<Accesos>();
                String accesoCategoria = i.next().toString();
                component = (UISelectMany) findComponent(accesoCategoria);
                if ((usuario != null) && (!usuario.equals("Selecciona uno:"))) {
                    listAccesosByUsuariosAccesos = accesosDao.getAccesosByCorreoCategoria(usuario, accesoCategoria);
                    Iterator j = listAccesosByUsuariosAccesos.iterator();
                    while (j.hasNext()) {
                        UsuariosAccesos ua = (UsuariosAccesos) j.next();
                        listAccesos.add(ua.getAccesos());
                    }
                    component.setSelectedValues(listAccesos.toArray(new Accesos[0]));
                    hashAccesosOriginales.put(accesoCategoria, (Accesos[]) component.getSelectedValues());
                } else {
                    component.setSelectedValues(new Accesos[0]);
                }
            }

        } catch (Exception ex) {
            MsgUtility.showErrorMeage("Error al actualizar los accesos...");
        }

    }

}
