

import java.util.Scanner;

import com.fazecast.jSerialComm.SerialPort;

public class LineaSerie {

    public void mandar(String textoAEnviar) {
        
        SerialPort puertosDisponibles[] = SerialPort.getCommPorts();
        
        
        
        if (puertosDisponibles.length == 0) {
            System.out.println("No hay ningún puerto COM disponible.");
        }
        else {
            
            System.out.println("Puertos disponibles:");
            for (int i = 0; i < puertosDisponibles.length; i++) {
                System.out.println("[" + i + "]  " + puertosDisponibles[i].getSystemPortName()
                                   + " : " + puertosDisponibles[i].getDescriptivePortName()
                                   /*+ " : " + puertosDisponibles[i].getPortDescription()*/);
            }
            
            
            int numeroElegido = 0;
            System.out.println("Teclea el [numero] de puerto que deseas abrir:");
      
            
            if (numeroElegido < 0 || numeroElegido >= puertosDisponibles.length) {
                System.out.println("El puerto [" + numeroElegido + "] no esta disponible.");
            }
            else {
                SerialPort puerto = puertosDisponibles[numeroElegido];
                System.out.println("Trabajando con el puerto [" + numeroElegido + "]  " + puerto.getSystemPortName());
               
                puerto.openPort();
                puerto.setComPortTimeouts(SerialPort.TIMEOUT_NONBLOCKING, 1000, 0);
                
                puerto.setBaudRate(115200);
                puerto.setNumDataBits(8);
                puerto.setParity(SerialPort.NO_PARITY);
                puerto.setNumStopBits(SerialPort.ONE_STOP_BIT);
                puerto.setFlowControl(SerialPort.FLOW_CONTROL_DISABLED);

               
                puerto.writeBytes(textoAEnviar.getBytes(), textoAEnviar.length());
               
                /*
                byte[] bufferDeLectura = new byte[1024];
                int numeroDeBytesLeidos = puerto.readBytes(bufferDeLectura, bufferDeLectura.length);
                String textoRecibido = new String(bufferDeLectura);
                System.out.println("Se han recibido " + numeroDeBytesLeidos + " caracteres:");
                System.out.println("[" + textoRecibido + "]");
                 */
                
                puerto.closePort();
            }
    
        }
    }
    

}
