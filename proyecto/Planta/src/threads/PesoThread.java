/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package threads;

import com.opencsv.CSVReader;
import gnu.io.CommPort;
import gnu.io.CommPortIdentifier;
import gnu.io.NoSuchPortException;
import gnu.io.PortInUseException;
import gnu.io.SerialPort;
import gnu.io.UnsupportedCommOperationException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JLabel;

/**
 *
 * @author Karla
 */
public class PesoThread implements Runnable {

    private JLabel pesoLbl;
    private InputStream in;
    private OutputStream out;

    public PesoThread() throws Exception {
        CommPortIdentifier portIdentifier = null;
        String cadenaPedir = null;
        String puerto = null;
        String baudios = null;
        String parity = null;
        String data = null;
        String stop = null;
        
        String csvFilename = "C:\\apps\\valco\\valco\\proyecto\\Planta\\src\\confBascula.csv";
        CSVReader csvReader = new CSVReader(new FileReader(csvFilename));
        String[] row = null;
        while ((row = csvReader.readNext()) != null) {
            cadenaPedir = row[1];
            puerto = row[0];
            baudios = row[2];
            parity = row[3];
            data = row[4];
            stop = row[5];
        }
//...
        csvReader.close();
        
        try {
            portIdentifier = CommPortIdentifier.getPortIdentifier(puerto);
        } catch (NoSuchPortException ex) {
            throw new Exception("No se encontro el puerto especificado en la configuracion");
        }
        if (portIdentifier.isCurrentlyOwned()) {
             throw new Exception("El puerto de la bascula ya se encuentra en uso");
        } else {
            CommPort commPort = null;
            try {
                commPort = portIdentifier.open(this.getClass().getName(), 2000);
            } catch (PortInUseException ex) {
                throw new Exception("El puerto de la bascula ya se encuentra en uso");
            }

            if (commPort instanceof SerialPort) {
                SerialPort serialPort = (SerialPort) commPort;
                try {
                    serialPort.setSerialPortParams(new Integer(baudios), new Integer(data), new Integer(stop), new Integer(parity));
                } catch (UnsupportedCommOperationException ex) {
                    throw new Exception("Ocurrio un error al leer la bascula");
                }
                try {
                    this.in = serialPort.getInputStream();
                    this.out = serialPort.getOutputStream();
                } catch (IOException ex) {
                    throw new Exception("Ocurrio un error al leer la bascula");
                }
            }
        }
    }
    

    public void run() {
        byte[] buffer = new byte[1024];
        int len = -1;
        try {
            out.write('P');
            while ((len = this.in.read(buffer)) > -1) {
                System.out.print(new String(buffer, 0, len));
                this.pesoLbl.setText(new String(buffer, 0, len));
            }
        } catch (IOException ex) {
            Logger.getLogger(PesoThread.class.getName()).log(Level.SEVERE, null, ex);
        }

        System.out.print(new String(buffer, 0, len) + "\n");
    }

    public JLabel getPesoLbl() {
        return pesoLbl;
    }

    public void setPesoLbl(JLabel pesoLbl) {
        this.pesoLbl = pesoLbl;
    }

    public InputStream getIn() {
        return in;
    }

    public void setIn(InputStream in) {
        this.in = in;
    }

    public OutputStream getOut() {
        return out;
    }

    public void setOut(OutputStream out) {
        this.out = out;
    }

    
    
}
