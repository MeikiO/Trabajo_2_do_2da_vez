
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

import gnu.io.CommPortIdentifier;

public class Principal {
	SerialComm lineaSerie;
	Lector hiloLectura;
	Escritor hiloEscritura;
	CommPortIdentifier puerto;
	Scanner teclado = new Scanner(System.in);
	boolean[] estados = new boolean[8];
	int[] infoint = new int[2];
	boolean fin = false;

	public Principal() {
		lineaSerie = new SerialComm();
		puerto = lineaSerie.encontrarPuerto();

		if (puerto == null) {
			System.out.println("No se ha encontrado una linea serie");
			System.exit(0);
		} else {
			try {
				lineaSerie.conectar(puerto);
			} catch (Exception e) {

				e.printStackTrace();
			}
			System.out.println("Linea serie encontrada en: " + puerto.getName());
			// Thread hilo = new Thread (new Runnable() {
//				@Override
//				public void run() {
//					while (!fin) {
//						try {
//							Thread.sleep(5000);
//						} catch (InterruptedException e1) {
//							e1.printStackTrace();
//						}
//						System.out.println("thread");
			
			
			
			//leerDatos();
			
			enviar();
			
			
			// hiloLectura = new Lector(lineaSerie, puerto, this);
//					}
//				}
//			});
//			hilo.start();
		}
		// hiloEscritura = new Escritor (lineaSerie, puerto);
		// System.exit(0);
	}

	public void leerDatos() {
		String linea = null;
		String infor[];
		System.out.println("leer datos");
		try (BufferedReader in = new BufferedReader(new FileReader("estadosCasa.txt"))) {
			linea = in.readLine();
			String info[] = linea.split("[:]");
			infor = info[0].split("[;]");
			for (int o = 0; o < infor.length; o++) {
				if (infor[o].equals("true"))
					estados[o] = true;
				else if (infor[o].equals("false")) {
					estados[o] = false;
				}
			}

			infor = info[1].split("[;]");
			for (int o = 0; o < infor.length; o++) {

				infoint[o] = Integer.parseInt(infor[o]);

			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("datos leidos");
	}

	public void enviar() {
		System.out.println("enviando");
		String msg = "";
		for (boolean b : estados) {
			byte Out = (byte) (b ? 1 : 0);
			msg += Out;
		}
		System.out.println("" + msg);
		StringBuilder msg2 = new StringBuilder();

		msg2.append(msg);
		// msg2 = msg2.reverse();
		// System.out.println("mensaje al reves: "+(msg2.toString()));
		// msg = lineaSerie.convertirBinario(msg);
		// hiloEscritura.setTEXTO(msg2.toString());
		// for (int o = 0; o < infoint.length; o++) {
		// hiloEscritura.setTEXTO(String.valueOf(infoint[o]));
		// }
		lineaSerie.escribir(String.valueOf(0));
		System.out.println("enviado");
		System.out.println("enviando2");
		try {
			Thread.sleep(200);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(String.valueOf(6000));
		
		lineaSerie.escribir(String.valueOf(6000));

		System.out.println("enviado");

		try {
			Thread.sleep(200);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("enviado2");
		
		lineaSerie.escribir(String.valueOf(3000));
		try {
			Thread.sleep(200);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("enviado3");
		
	//	lineaSerie.escribir("]");
	}

	public void accion() {
		String linea;
		// hiloLectura.start();
		// hiloEscritura.start();
		System.out.println("Escriba texto y fin para parar");

		do {
			linea = teclado.nextLine();
			lineaSerie.escribir(linea);
			System.out.println("Enviado:" + linea);
		} while (!linea.equals("fin"));
		hiloEscritura.parar();
		lineaSerie.cerrar();
	}

	public static void main(String[] args) {
		Principal programa = new Principal();
		// programa.accion();
	}

}