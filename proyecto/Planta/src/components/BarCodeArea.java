/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package components;

import dao.ProductoDAO;
import java.awt.event.KeyEvent;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import mapping.ProductosHasProveedores;
import mapping.ProductosInventario;
import mapping.Proveedores;
import mapping.ProveedoresCodigo;
import observables.BarCodeAreaObservable;
import observables.BarCodeTxtObservable;
import observers.BarCodeAreaObserver;
import observers.BarCodeTxtObserver;
import observers.Observer;
import utilities.UsuarioFirmado;

/**
 *
 * @author Karla
 */
public class BarCodeArea extends javax.swing.JPanel implements BarCodeAreaObservable {

    private ProductoDAO productosDAO = new ProductoDAO();
    private List<ProductosHasProveedores> productos;
    private boolean productoExistente;
    private Integer[] codigos;
    private List<BarCodeAreaObserver> observers = new ArrayList<>();
    private String peso;
    private String[] barCodes;
    private String modoOperacion;
    private CustomDropDown proveedoresDropDown;
    private List<ProductosInventario> productosInventario = new ArrayList();

    /**
     * Creates new form BarCodeArea
     */
    public BarCodeArea() {
        initComponents();
    }

    private void armarProductoConCodigo() {
        int barCodeSize = 0;
        barCodes = barCodeArea.getText().split("\\n");
        barCodeArea.setText("");
        for (String barCode : barCodes) {
            ProductosInventario productoInv = new ProductosInventario();
            ProductosHasProveedores producto = new ProductosHasProveedores();
            for (ProveedoresCodigo codigo : ((Proveedores) proveedoresDropDown.getSelectedItem()).getProveedoresCodigos()) {
                try {
                    barCodeSize = barCode.length();
                    if (barCodeSize < codigo.getPosicionCodigoInicial()
                            || barCodeSize < codigo.getPosicionCodigoFinal()
                            || barCodeSize < codigo.getPosicionPesoInicial()
                            || barCodeSize < codigo.getPosicionPesoFinal()) {
                        continue;
                    }

                    String codigoProducto
                            = barCode.substring(codigo.getPosicionCodigoInicial() - 1,
                                    codigo.getPosicionCodigoFinal());
                    peso
                            = barCode.substring(codigo.getPosicionPesoInicial() - 1,
                                    codigo.getPosicionPesoFinal());
                    peso = new StringBuilder(peso).insert(peso.length() - codigo.getDecimales(), ".").toString();

                    System.out.println(codigoProducto + " " + peso);
                    producto
                            = productosDAO.getProductoXProveYCodigo(((Proveedores) proveedoresDropDown.getSelectedItem()),
                                    String.valueOf(Integer.parseInt(codigoProducto)));
                    if (producto != null) {
                        productoInv.setProductosHasProveedores(producto);
                        productoInv.setPeso(new BigDecimal(peso));
                        productoInv.setCodigoBarras(barCode);
                        productoInv.setCosto(producto.getPrecioSugerido());
                        productoInv.setPrecio(producto.getProductos().getPrecioSugerido());
                        productoInv.setUbicaciones(UsuarioFirmado.getUsuarioFirmado().getUbicaciones());
                        productoInv.setEstatus("ACTIVO");
                        productosInventario.add(productoInv);
                        break;
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    producto = null;
                }
            }
        }
        notifyObservers();

    }

    private void changeScanned(String texto) {
        barCodes = texto.split("\\n");
        barCodeArea.setText("");
        for (String barCode : barCodes) {
            ProductosInventario productoInventario = new ProductosInventario();
            try {
                if (modoOperacion.equals("ENTRADA")) {
                    productoInventario = productosDAO.getProductosXCodigoBarrasTransito(barCode, codigos);
                } else {
                    productoInventario = productosDAO.getProductosXCodigoBarrasActivos(barCode, codigos);
                }
                notifyObservers();
            } catch (Exception ex) {
                productoInventario.setCodigoBarras(barCode);
            }
            productosInventario.add(productoInventario);
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

        jButton1 = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        barCodeArea = new javax.swing.JTextArea();
        barCodeLbl = new javax.swing.JLabel();
        btnCargar = new javax.swing.JButton();

        jButton1.setText("jButton1");

        setPreferredSize(new java.awt.Dimension(481, 300));

        barCodeArea.setColumns(20);
        barCodeArea.setRows(99999);
        barCodeArea.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                barCodeAreaKeyReleased(evt);
            }
        });
        jScrollPane1.setViewportView(barCodeArea);

        barCodeLbl.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        barCodeLbl.setText("Código de Barras:");

        btnCargar.setText("Cargar codigos");
        btnCargar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCargarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addComponent(barCodeLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 94, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 308, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnCargar, javax.swing.GroupLayout.DEFAULT_SIZE, 131, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(72, 72, 72)
                        .addComponent(barCodeLbl))
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 136, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(68, 68, 68)
                        .addComponent(btnCargar)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void barCodeAreaKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_barCodeAreaKeyReleased

    }//GEN-LAST:event_barCodeAreaKeyReleased

    private void btnCargarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCargarActionPerformed
        if (!productoExistente) {
            armarProductoConCodigo();
        } else {
            changeScanned(barCodeArea.getText());
        }
    }//GEN-LAST:event_btnCargarActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextArea barCodeArea;
    private javax.swing.JLabel barCodeLbl;
    private javax.swing.JButton btnCargar;
    private javax.swing.JButton jButton1;
    private javax.swing.JScrollPane jScrollPane1;
    // End of variables declaration//GEN-END:variables

    @Override
    public void registerObserver(BarCodeAreaObserver observer) {
        observers.add(observer);
    }

    @Override
    public void removeObserver(BarCodeAreaObserver observer) {
        observers.remove(observer);
    }

    @Override
    public void notifyObservers() {
        for (BarCodeAreaObserver observer : observers) {
            observer.updateBarCodeAreaObserver();
        }
    }

    public JTextArea getBarCodeArea() {
        return barCodeArea;
    }

    public void setBarCodeArea(JTextArea barCodeArea) {
        this.barCodeArea = barCodeArea;
    }

    public JLabel getBarCodeLbl() {
        return barCodeLbl;
    }

    public void setBarCodeLbl(JLabel barCodeLbl) {
        this.barCodeLbl = barCodeLbl;
    }

    public ProductoDAO getProductosDAO() {
        return productosDAO;
    }

    public void setProductosDAO(ProductoDAO productosDAO) {
        this.productosDAO = productosDAO;
    }

    public String getModoOperacion() {
        return modoOperacion;
    }

    public void setModoOperacion(String modoOperacion) {
        this.modoOperacion = modoOperacion;
    }

    public Integer[] getCodigos() {
        return codigos;
    }

    public void setCodigos(Integer[] codigos) {
        this.codigos = codigos;
    }

    public List<ProductosHasProveedores> getProductos() {
        return productos;
    }

    public void setProductos(List<ProductosHasProveedores> productos) {
        this.productos = productos;
    }

    public List<ProductosInventario> getProductosInventario() {
        return productosInventario;
    }

    public void setProductosInventario(List<ProductosInventario> productosInventario) {
        this.productosInventario = productosInventario;
    }

    public List<BarCodeAreaObserver> getObservers() {
        return observers;
    }

    public void setObservers(List<BarCodeAreaObserver> observers) {
        this.observers = observers;
    }

    public String getPeso() {
        return peso;
    }

    public void setPeso(String peso) {
        this.peso = peso;
    }

    public String[] getBarCodes() {
        return barCodes;
    }

    public void setBarCodes(String[] barCodes) {
        this.barCodes = barCodes;
    }

    public boolean isProductoExistente() {
        return productoExistente;
    }

    public void setProductoExistente(boolean productoExistente) {
        this.productoExistente = productoExistente;
    }

    public CustomDropDown getProveedoresDropDown() {
        return proveedoresDropDown;
    }

    public void setProveedoresDropDown(CustomDropDown proveedoresDropDown) {
        this.proveedoresDropDown = proveedoresDropDown;
    }

}
