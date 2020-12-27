

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import gnu.io.CommPortIdentifier;

public class Lector extends Thread {
	SerialComm lineaSerie;
	CommPortIdentifier puerto;
	volatile boolean parar = false;
	Principal principal;
	boolean fin = false;

	public Lector(SerialComm lineaSerie, CommPortIdentifier puerto, Principal principal) {
		this.principal = principal;
		this.lineaSerie = lineaSerie;
		this.puerto = puerto;
		this.run();
	}

	@Override
	public void run() {
		String mensaje = null;

		try {
			do {
				mensaje = lineaSerie.leer();
				System.out.println(mensaje);
				mensaje = lineaSerie.convertirBinario(mensaje);
				System.out.println(mensaje);
				actualizarFicheros(lineaSerie.convertirBoolean(mensaje));

				// mensaje = mensaje.substring(0,mensaje.length()-1);
				System.out.println(mensaje);
			} while (fin != true);

		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("fin hilo lector");
	}

	public void actualizarFicheros(boolean[] b) {
		FileWriter fichero = null;
		PrintWriter pw = null;
		int i = 0;
		try {
			fichero = new FileWriter("estadosCasa.txt");
			pw = new PrintWriter(fichero);
			while (i < b.length) {
				if (b[i] == true) {
					pw.print(b[i] + ";");
				} else
					pw.print(b[i] + ";");
				i++;
			}
			fichero.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		principal.leerDatos();
		principal.enviar();
		// fin = true;

	}

	public void parar() {
		parar = true;
	}

}
