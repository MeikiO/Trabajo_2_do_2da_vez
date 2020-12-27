

import gnu.io.CommPortIdentifier;

public class Escritor extends Thread {

	String TEXTO = null;

	SerialComm lineaSerie;
	CommPortIdentifier puerto;
	volatile boolean parar = false;

	public Escritor(SerialComm lineaSerie, CommPortIdentifier puerto) {
		this.lineaSerie = lineaSerie;
		this.puerto = puerto;
	}

	@Override
	public void run() {
		while (!parar) {
			try {
				Thread.sleep(50);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (TEXTO != null) {
				lineaSerie.escribir(TEXTO);
			}
		}
		System.out.println("Fin hilo escritor");
	}

	public void parar() {
		parar = true;
	}

	public void setTEXTO(String tEXTO) {
		TEXTO = tEXTO;
	}
}
