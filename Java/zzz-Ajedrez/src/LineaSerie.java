



import com.fazecast.jSerialComm.SerialPort;

public class LineaSerie {
	
	
	public SerialPort seleccionarPrimerPuertoAbierto() {
        
		SerialPort puerto=null;
		
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
            
            
           
            int numeroElegido = 0; //es el indice del array de puertos, se cogera el primero
  
          
            if (numeroElegido < 0 || numeroElegido >= puertosDisponibles.length) {
                System.out.println("El puerto [" + numeroElegido + "] no esta disponible.");
            }
            else {
               puerto = puertosDisponibles[numeroElegido];
                //System.out.println("Trabajando con el puerto [" + numeroElegido + "]  " + puerto.getSystemPortName());
                
            }    
        }
        
		return puerto;
   }	

	
	public void configuracionLineaSerie(SerialPort puerto) {
		 
	     puerto.setComPortTimeouts(SerialPort.TIMEOUT_NONBLOCKING, 5000, 0);

	     puerto.setBaudRate(115200);
	     puerto.setNumDataBits(8);
	     puerto.setParity(SerialPort.NO_PARITY);
	     puerto.setNumStopBits(SerialPort.ONE_STOP_BIT);
	     puerto.setFlowControl(SerialPort.FLOW_CONTROL_DISABLED);
	}
	

	
    public void mandar(String textoAEnviar) {
        
    	
		SerialPort puerto=this.seleccionarPrimerPuertoAbierto();
		
		if(puerto!=null) {
		 
		puerto.openPort();


		 this.configuracionLineaSerie(puerto);
        

                 
         puerto.writeBytes(textoAEnviar.getBytes(), textoAEnviar.length());
         
         
         puerto.closePort();
        
         
         
		}
	
 }
    

    

public String leer () {

			String textoRecibido =null;
	
			SerialPort puerto=this.seleccionarPrimerPuertoAbierto();
			
			if(puerto!=null) {
			 
			puerto.openPort();

			 this.configuracionLineaSerie(puerto);
                   
             byte[] bufferDeLectura = new byte[1];
             int numeroDeBytesLeidos = puerto.readBytes(bufferDeLectura, bufferDeLectura.length);
             textoRecibido = new String(bufferDeLectura);
             System.out.println("Se han recibido " + numeroDeBytesLeidos + " caracteres:");
             System.out.println("[" + textoRecibido + "]");
            
           
             puerto.closePort();

			}
			
			return  textoRecibido;
            
}



}
