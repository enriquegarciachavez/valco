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
import mapping.Productos;
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
    private boolean productoExistente;
    private List<Integer> codigos = new ArrayList<>();
    private List<BarCodeAreaObserver> observers = new ArrayList<>();
    private String peso;
    private String[] barCodes;
    private String modoOperacion;
    private CustomDropDown proveedoresDropDown;
    private List<ProductosInventario> productosInventario = new ArrayList();
    private boolean productoEnCodigo;
    private boolean pesoEnCodigo;
    private boolean puntoDecimal;
    private boolean pesoEnLibras;

    /**
     * Creates new form BarCodeArea
     */
    public BarCodeArea() {
    }

    public void init() {
        initComponents();
    }

    private void armarProductoConCodigo() {
        int barCodeSize = 0;
        boolean found = false;
        barCodes = barCodeArea.getText().split("\\n");
        barCodeArea.setText("");
        System.out.println(((Proveedores) proveedoresDropDown.getSelectedItem()).getCodigo());
        for (String barCode : barCodes) {
            barCode = barCode.trim();
            ProductosInventario productoInv = new ProductosInventario();
            found = false;
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
                    peso = calcularPeso(barCode);

                    System.out.println(codigoProducto + " " + peso);
                    producto
                            = productosDAO.getProductoXProveYCodigo(((Proveedores) proveedoresDropDown.getSelectedItem()),
                                    codigoProducto);
                    if (producto != null) {
                        productoInv.setProductosHasProveedores(producto);
                        productoInv.setPeso(new BigDecimal(peso));
                        productoInv.setCodigoBarras(barCode);
                        productoInv.setCosto(producto.getPrecioSugerido());
                        productoInv.setPrecio(producto.getProductos().getPrecioSugerido());
                        productoInv.setUbicaciones(UsuarioFirmado.getUsuarioFirmado().getUbicaciones());
                        productoInv.setEstatus("ACTIVO");
                        productosInventario.add(productoInv);
                        found = true;
                        break;
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    producto = null;
                }
            }
            if (!found) {
                noReconocidosArea.append(barCode + "\n");
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
            } catch (Exception ex) {
                noReconocidosArea.append(barCode + "\n");
                continue;
            }
            productosInventario.add(productoInventario);
            codigos.add(productoInventario.getCodigo());
            notifyObservers();
        }
    }

    private void armarProductoCodigoNoConfigurado() {
        barCodes = barCodeArea.getText().split("\\n");
        barCodeArea.setText("");
        System.out.println(((Proveedores) proveedoresDropDown.getSelectedItem()).getCodigo());
        for (String barCode : barCodes) {
            barCode = barCode.trim();
            ProductosInventario productoInv = new ProductosInventario();
            productoInv.setProductosHasProveedores(new ProductosHasProveedores());
            productoInv.getProductosHasProveedores().setProductos(new Productos());
            productoInv.getProductosHasProveedores().getProductos().setDescripcion("PENDIENTE");
            productoInv.setPeso(new BigDecimal(calcularPeso(barCode)));
            productoInv.setCodigoBarras(barCode);
            productoInv.setCosto(BigDecimal.ONE);
            productoInv.setPrecio(BigDecimal.ONE);
            productoInv.setUbicaciones(UsuarioFirmado.getUsuarioFirmado().getUbicaciones());
            productoInv.setEstatus("ACTIVO");
            productosInventario.add(productoInv);
        }
        notifyObservers();
    }

    private String calcularPeso(String barCode) {
        int barCodeSize = 0;
        String peso = "0.00";
        for (ProveedoresCodigo codigo : ((Proveedores) proveedoresDropDown.getSelectedItem()).getProveedoresCodigos()) {
            barCodeSize = barCode.length();
            if (barCodeSize < codigo.getPosicionPesoInicial()
                    || barCodeSize < codigo.getPosicionPesoFinal()) {
                continue;
            }

            if (pesoEnCodigo) {
                peso = barCode.substring(codigo.getPosicionPesoInicial() - 1,
                        codigo.getPosicionPesoFinal());
                if (!puntoDecimal) {
                    peso = new StringBuilder(peso).insert(peso.length() - codigo.getDecimales(), ".").toString();
                }
                if (pesoEnLibras) {
                    BigDecimal pesoLibras = new BigDecimal(peso);
                    pesoLibras = pesoLibras.divide(new BigDecimal("2.20462"));
                    peso = pesoLibras.toString();
                }
            }
            break;
        }
        return peso;
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
        jScrollPane2 = new javax.swing.JScrollPane();
        noReconocidosArea = new javax.swing.JTextArea();
        jLabel1 = new javax.swing.JLabel();
        reconocidosLbl = new javax.swing.JLabel();
        noReconocidosLbl = new javax.swing.JLabel();
        copiarNoReconoBtn = new javax.swing.JButton();

        jButton1.setText("jButton1");

        setPreferredSize(new java.awt.Dimension(461, 300));

        barCodeArea.setColumns(20);
        barCodeArea.setRows(99999);
        barCodeArea.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyTyped(java.awt.event.KeyEvent evt) {
                barCodeAreaKeyTyped(evt);
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

        noReconocidosArea.setColumns(20);
        noReconocidosArea.setRows(99999);
        jScrollPane2.setViewportView(noReconocidosArea);

        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        jLabel1.setText("No reconocidos:");

        reconocidosLbl.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        reconocidosLbl.setText("0");

        noReconocidosLbl.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        noReconocidosLbl.setText("0");

        copiarNoReconoBtn.setText("<");
        copiarNoReconoBtn.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                copiarNoReconoBtnActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(76, 76, 76)
                .addComponent(barCodeLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 104, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(reconocidosLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 51, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 92, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(noReconocidosLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(97, 97, 97))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(btnCargar, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 308, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(copiarNoReconoBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 42, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 277, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(53, 53, 53))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(reconocidosLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 24, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(barCodeLbl)
                    .addComponent(noReconocidosLbl, javax.swing.GroupLayout.PREFERRED_SIZE, 24, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel1))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 117, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 117, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(43, 43, 43)
                        .addComponent(copiarNoReconoBtn, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnCargar)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void btnCargarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCargarActionPerformed
        if (!productoExistente) {
            System.out.println("Luego "+productoEnCodigo);
            if (productoEnCodigo) {
                armarProductoConCodigo();
            } else {
                armarProductoCodigoNoConfigurado();
            }
        } else {
            changeScanned(barCodeArea.getText());
        }
        reconocidosLbl.setText("0");
        noReconocidosLbl.setText(String.valueOf(noReconocidosArea.getLineCount() - 1));
    }//GEN-LAST:event_btnCargarActionPerformed

    private void copiarNoReconoBtnActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_copiarNoReconoBtnActionPerformed
        barCodeArea.append(noReconocidosArea.getText());
        noReconocidosArea.setText("");
        noReconocidosLbl.setText("0");
        reconocidosLbl.setText(String.valueOf(barCodeArea.getLineCount() - 1));
    }//GEN-LAST:event_copiarNoReconoBtnActionPerformed

    private void barCodeAreaKeyTyped(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_barCodeAreaKeyTyped
        reconocidosLbl.setText(String.valueOf(barCodeArea.getLineCount() - 1));
    }//GEN-LAST:event_barCodeAreaKeyTyped


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextArea barCodeArea;
    private javax.swing.JLabel barCodeLbl;
    private javax.swing.JButton btnCargar;
    private javax.swing.JButton copiarNoReconoBtn;
    private javax.swing.JButton jButton1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTextArea noReconocidosArea;
    private javax.swing.JLabel noReconocidosLbl;
    private javax.swing.JLabel reconocidosLbl;
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

    public List<Integer> getCodigos() {
        return codigos;
    }

    public void setCodigos(List<Integer> codigos) {
        this.codigos = codigos;
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

    public boolean isProductoEnCodigo() {
        return productoEnCodigo;
    }

    public void setProductoEnCodigo(boolean productoEnCodigo) {
        this.productoEnCodigo = productoEnCodigo;
    }

    public boolean isPesoEnCodigo() {
        return pesoEnCodigo;
    }

    public void setPesoEnCodigo(boolean pesoEnCodigo) {
        this.pesoEnCodigo = pesoEnCodigo;
    }

    public boolean isPuntoDecimal() {
        return puntoDecimal;
    }

    public void setPuntoDecimal(boolean puntoDecimal) {
        this.puntoDecimal = puntoDecimal;
    }

    public boolean isPesoEnLibras() {
        return pesoEnLibras;
    }

    public void setPesoEnLibras(boolean pesoEnLibras) {
        this.pesoEnLibras = pesoEnLibras;
    }

}
