/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package panels;

import components.CustomDropDown;
import components.NotaVentaTxt;
import components.ProductosTableModel;
import dao.BarCodeDAO;
import dao.NotaVentaDAOInterface;
import dao.ProductosDAO;
import java.awt.Component;
import java.awt.KeyboardFocusManager;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.AbstractButton;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.table.TableModel;
import keydispatchers.BarCodeScannerKeyDispatcher;
import mapping.Clientes;
import mapping.Productos;
import mapping.ProductosInventario;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import utilities.ClienteUtility;

/**
 *
 * @author Administrador
 */
public class PuntoVenta extends barcode.BarCodableImpl implements ActionListener {

    ProductosTableModel tableModel;
    BarCodeDAO dao;
    CustomDropDown productosDropDown;
    String state = "inicio";
    ProductosDAO productoDAO;
    List<ProductosInventario> productoMaestro = new ArrayList<>();
    NotaVentaTxt notaVentaTxt;
    CustomDropDown clienteDropDown;
    NotaVentaDAOInterface notaVentaDAO;

    /**
     * Creates new form PuntoVenta
     */
    public PuntoVenta() {

    }

    public void init() {
        initComponents();
        List<Component> exeptions = new ArrayList<>();
        basculaPanel1.init();
        exeptions.add(basculaPanel1.getPesoManualTxt());
        exeptions.add(productosDropDown.getTxt());
        exeptions.add(barCodeTxt1.getBarCodeTxt());
        exeptions.add(notaVentaTxt.getNotaTextField());
        exeptions.add(clienteDropDown.getTxt());
        exeptions.add(productosTable);
        setManager(KeyboardFocusManager.getCurrentKeyboardFocusManager());
        setDispacher(new BarCodeScannerKeyDispatcher(barCodeTxt.getBarCodeTxt(), getManager(), exeptions) {
            @Override
            public boolean dispatchKeyEvent(KeyEvent e) {
                if (e.getKeyCode() == KeyEvent.VK_F1 && e.getID() == KeyEvent.KEY_RELEASED) {
                    basculaHandler();
                    return true;
                } else {
                    return super.dispatchKeyEvent(e);

                }
            }
        });
        getManager().addKeyEventDispatcher(getDispacher());
        barCodeTxt.getBarCodeTxt().addActionListener(this);
        barCodeTxt1.getBarCodeTxt().addActionListener(this);
        productosDialog.add(productosDropDown);
        productosDropDown.setBounds(50, 50, 300, 300);
        productosDialog.setLocationRelativeTo(null);
        codigoBarrasDialog.setLocationRelativeTo(null);
        this.add(notaVentaTxt);
        notaVentaTxt.setBounds(10, 20, 300, 300);
        clientesPanel.add(clienteDropDown);
        clienteDropDown.setBounds(20, 55, 300, 100);
        publicoGeneralCheck.setSelected(true);
        clienteDropDown.setVisible(false);
        

    }

    public void basculaHandler() {
        try {
            if (basculaPanel1.getPeso() == null) {
                return;
            }
            if (state.equals("inicio")) {
                state = "seleccionProducto";
                productosDialog.setVisible(true);

            } else if (state.equals("seleccionProducto")) {
                Productos productoSeleccionado;
                productoSeleccionado = (Productos) productosDropDown.getSelectedItem();
                if (productoSeleccionado.isProductoPesado()) {

                    ProductosInventario productoMaster = productoDAO.getProductoMaster(productoSeleccionado);
                    if (productoMaster == null) {
                        JOptionPane.showMessageDialog(productosDialog, "No se encontro el producto maestro");
                    }
                    for (ProductosInventario producto : productoMaestro) {
                        if (productoMaster.getCodigo() == producto.getCodigo()) {
                            productoMaster = producto;
                            break;
                        }
                    }
                    ProductosInventario productoHijo = (ProductosInventario) productoMaster.getBasicClone();
                    productoHijo.setCodigo(null);
                    productoHijo.setProductoMaestro(false);
                    productoHijo.setPeso(basculaPanel1.getPeso());
                    tableModel.agregarProducto(productoHijo);
                    state = "inicio";
                    productosDialog.setVisible(false);

                } else {
                    state = "codigo de Barras";
                    productosDialog.setVisible(false);
                    codigoBarrasDialog.setVisible(true);

                }

            } else if (state.equals("codigo de Barras")) {

            }
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        List<Integer> codigos = new ArrayList<>();

        if (e.getSource().equals(barCodeTxt.getBarCodeTxt())) {
            try {
                int x = 0;
                for (ProductosInventario productoInv : tableModel.getProductos()) {
                    codigos.add(productoInv.getCodigo());
                    x++;
                }
                ProductosInventario producto = productoDAO.getProductosXCodigoBarrasActivos(((JTextField) e.getSource()).getText(), codigos);

                tableModel.agregarProducto(producto);

            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex);
            }
            barCodeTxt.getBarCodeTxt().setText("");

        } else if (e.getSource().equals(barCodeTxt1.getBarCodeTxt())) {
            try {
                ProductosInventario producto = dao.getProductoByBarCode(((JTextField) e.getSource()).getText());
                for (ProductosInventario productoInventario : productoMaestro) {
                    if (productoInventario.getCodigo() == producto.getCodigo()) {
                        producto = productoInventario;
                        break;
                    }
                }
                if (basculaPanel1.getPeso().compareTo(producto.getPeso()) == 1) {
                    JOptionPane.showMessageDialog(codigoBarrasDialog, "El peso capturado es mayor al peso de la caja");
                    return;
                } else {
                    ProductosInventario productoHijo = (ProductosInventario) producto.getBasicClone();
                    productoHijo.setPeso(basculaPanel1.getPeso());
                    producto.setPeso(producto.getPeso().subtract(basculaPanel1.getPeso()));
                    tableModel.agregarProducto(productoHijo);
                    productoMaestro.add(producto);
                    ((JTextField) e.getSource()).setText("");
                    state = "inicio";
                    codigoBarrasDialog.setVisible(false);

                }
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, ex);
            }
        }

    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        productosDialog = new javax.swing.JDialog();
        codigoBarrasDialog = new javax.swing.JDialog();
        barCodeTxt1 = new components.BarCodeTxt();
        basculaPanel1 = new components.BasculaPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        productosTable = new javax.swing.JTable();
        barCodeTxt = new components.BarCodeTxt();
        finalizar = new javax.swing.JButton();
        clientesPanel = new javax.swing.JPanel();
        publicoGeneralCheck = new javax.swing.JCheckBox();

        productosDialog.setTitle("Seleccion de Producto");
        productosDialog.setAlwaysOnTop(true);
        productosDialog.setBounds(new java.awt.Rectangle(0, 0, 350, 200));
        productosDialog.setModalExclusionType(java.awt.Dialog.ModalExclusionType.APPLICATION_EXCLUDE);
        productosDialog.setModalityType(java.awt.Dialog.ModalityType.APPLICATION_MODAL);
        productosDialog.setResizable(false);
        productosDialog.setType(java.awt.Window.Type.POPUP);
        productosDialog.addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                productosDialogWindowClosing(evt);
            }
        });

        javax.swing.GroupLayout productosDialogLayout = new javax.swing.GroupLayout(productosDialog.getContentPane());
        productosDialog.getContentPane().setLayout(productosDialogLayout);
        productosDialogLayout.setHorizontalGroup(
            productosDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 592, Short.MAX_VALUE)
        );
        productosDialogLayout.setVerticalGroup(
            productosDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 379, Short.MAX_VALUE)
        );

        codigoBarrasDialog.setAlwaysOnTop(true);
        codigoBarrasDialog.setBounds(new java.awt.Rectangle(0, 0, 481, 93));
        codigoBarrasDialog.addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                codigoBarrasDialogWindowClosing(evt);
            }
        });

        javax.swing.GroupLayout codigoBarrasDialogLayout = new javax.swing.GroupLayout(codigoBarrasDialog.getContentPane());
        codigoBarrasDialog.getContentPane().setLayout(codigoBarrasDialogLayout);
        codigoBarrasDialogLayout.setHorizontalGroup(
            codigoBarrasDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, codigoBarrasDialogLayout.createSequentialGroup()
                .addComponent(barCodeTxt1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
        );
        codigoBarrasDialogLayout.setVerticalGroup(
            codigoBarrasDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(codigoBarrasDialogLayout.createSequentialGroup()
                .addGap(26, 26, 26)
                .addComponent(barCodeTxt1, javax.swing.GroupLayout.PREFERRED_SIZE, 34, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(33, Short.MAX_VALUE))
        );

        setPreferredSize(new java.awt.Dimension(1558, 755));

        productosTable.setModel((TableModel)this.tableModel);
        productosTable.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                productosTableKeyReleased(evt);
            }
        });
        jScrollPane1.setViewportView(productosTable);

        finalizar.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N
        finalizar.setText("Finalizar");
        finalizar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                finalizarActionPerformed(evt);
            }
        });

        clientesPanel.setBorder(javax.swing.BorderFactory.createTitledBorder("Seleccion de Cliente"));

        publicoGeneralCheck.setText("Publico en General");
        publicoGeneralCheck.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                publicoGeneralCheckActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout clientesPanelLayout = new javax.swing.GroupLayout(clientesPanel);
        clientesPanel.setLayout(clientesPanelLayout);
        clientesPanelLayout.setHorizontalGroup(
            clientesPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(clientesPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(publicoGeneralCheck)
                .addContainerGap(211, Short.MAX_VALUE))
        );
        clientesPanelLayout.setVerticalGroup(
            clientesPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(clientesPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(publicoGeneralCheck)
                .addContainerGap(220, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(barCodeTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(clientesPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(basculaPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(finalizar, javax.swing.GroupLayout.PREFERRED_SIZE, 133, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(431, 431, 431))
            .addGroup(layout.createSequentialGroup()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 1471, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(29, 29, 29)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(clientesPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(basculaPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(barCodeTxt, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(finalizar, javax.swing.GroupLayout.PREFERRED_SIZE, 49, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 18, Short.MAX_VALUE)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );
    }// </editor-fold>//GEN-END:initComponents

    private void finalizarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_finalizarActionPerformed

        Clientes cliente = null;

        if (tableModel.getProductos() == null || tableModel.getProductos().isEmpty()) {
            JOptionPane.showMessageDialog(null, "Debes ingresar por lo menos un producto para la venta");
            return;

        }
        if (notaVentaTxt.getNotaSeleccionada() == null) {
            JOptionPane.showMessageDialog(null, "Debe ingresar la nota de venta ");
            return;
        }
        if (!publicoGeneralCheck.isSelected() && clienteDropDown.getSelectedItem() == null) {
            JOptionPane.showMessageDialog(null, "Debe seleccionar el cliente");
            return;
        }

        if (publicoGeneralCheck.isSelected()) {
            cliente = ClienteUtility.getPublicoGeneral();

        } else {
            cliente = (Clientes) clienteDropDown.getSelectedItem();

        }

        for (ProductosInventario producto : tableModel.getProductos()) {
            notaVentaTxt.getNotaSeleccionada().getProductosInventarios().add(producto);
            producto.setRepartidores(notaVentaTxt.getNotaSeleccionada().getRepartidores());
            producto.setNotasDeVenta(notaVentaTxt.getNotaSeleccionada());

        }
        for (ProductosInventario productoMaestro : productoMaestro) {
            for (ProductosInventario producto : tableModel.getProductos()) {
                if (productoMaestro.getCodigo().equals(producto.getCodigo()) ) {
                    producto.setCodigo(null);
                }
            }
        }
        notaVentaTxt.getNotaSeleccionada().setClientes(cliente);
        notaVentaTxt.getNotaSeleccionada().setEstatus("VENDIDA");
        notaVentaTxt.getNotaSeleccionada().setTotal(tableModel.getTotalSeleccionado());
        notaVentaTxt.getNotaSeleccionada().setFechaDeVenta(new Date());
        try {
            notaVentaDAO.actualizarNotaDeVenta(notaVentaTxt.getNotaSeleccionada(), productoMaestro);
            JOptionPane.showMessageDialog(null, "La nota se vendio correctamente");
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage());
        }


    }//GEN-LAST:event_finalizarActionPerformed

    private void publicoGeneralCheckActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_publicoGeneralCheckActionPerformed
        AbstractButton abstractButton = (AbstractButton) evt.getSource();
        boolean selected = abstractButton.getModel().isSelected();
        if (selected) {
            clienteDropDown.setVisible(false);

        } else {
            clienteDropDown.setVisible(true);
        }

    }//GEN-LAST:event_publicoGeneralCheckActionPerformed

    private void productosTableKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_productosTableKeyReleased
        if (evt.getKeyCode() == KeyEvent.VK_DELETE) {
            Collection<ProductosInventario> productosEliminados = tableModel.eliminarProductos(productosTable.getSelectedRows());
            for (ProductosInventario productoEliminado : productosEliminados) {
                for (ProductosInventario maestro : productoMaestro) {
                    if (productoEliminado.getCodigo() == maestro.getCodigo()) {
                        maestro.setPeso(maestro.getPeso().add(productoEliminado.getPeso()));
                    }
                }
            }
            barCodeTxt.getBarCodeTxt().requestFocusInWindow();
        }
    }//GEN-LAST:event_productosTableKeyReleased

    private void productosDialogWindowClosing(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_productosDialogWindowClosing
       this.state = "inicio";
    }//GEN-LAST:event_productosDialogWindowClosing

    private void codigoBarrasDialogWindowClosing(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_codigoBarrasDialogWindowClosing
         this.state = "inicio";
    }//GEN-LAST:event_codigoBarrasDialogWindowClosing

    public void setTableModel(ProductosTableModel tableModel) {
        this.tableModel = tableModel;
    }

    public void setDao(BarCodeDAO dao) {
        this.dao = dao;
    }

    public void setProductosDropDown(CustomDropDown productosDropDown) {
        this.productosDropDown = productosDropDown;
    }

    public void setProductoDAO(ProductosDAO productoDAO) {
        this.productoDAO = productoDAO;
    }

    public void setNotaVentaTxt(NotaVentaTxt notaVentaTxt) {
        this.notaVentaTxt = notaVentaTxt;
    }

    public void setClienteDropDown(CustomDropDown clienteDropDown) {
        this.clienteDropDown = clienteDropDown;
    }

    public void setNotaVentaDAO(NotaVentaDAOInterface notaVentaDAO) {
        this.notaVentaDAO = notaVentaDAO;
    }


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private components.BarCodeTxt barCodeTxt;
    private components.BarCodeTxt barCodeTxt1;
    private components.BasculaPanel basculaPanel1;
    private javax.swing.JPanel clientesPanel;
    private javax.swing.JDialog codigoBarrasDialog;
    private javax.swing.JButton finalizar;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JDialog productosDialog;
    private javax.swing.JTable productosTable;
    private javax.swing.JCheckBox publicoGeneralCheck;
    // End of variables declaration//GEN-END:variables

}
