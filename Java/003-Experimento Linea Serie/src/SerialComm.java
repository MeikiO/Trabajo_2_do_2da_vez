
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import gnu.io.CommPort;
import gnu.io.CommPortIdentifier;
import gnu.io.SerialPort;

public class SerialComm {
	public static final String CARACTERFIN = "t";
	InputStream in;
	OutputStream out;
	CommPort commPort;

	public void conectar(CommPortIdentifier portIdentifier) throws Exception {
		if (portIdentifier.isCurrentlyOwned()) {
			System.out.println("Error puerta en uso");
		} else {
			commPort = portIdentifier.open("Mi programa", 2000);

			if (commPort instanceof SerialPort) {
				SerialPort serialPort = (SerialPort) commPort;
				serialPort.setSerialPortParams(9600, SerialPort.DATABITS_8, SerialPort.STOPBITS_1,
						SerialPort.PARITY_NONE);
				serialPort.disableReceiveTimeout();
				serialPort.enableReceiveThreshold(1);
				in = serialPort.getInputStream();
				out = serialPort.getOutputStream();
			} else {
				System.out.println("Error este programa solo funciona con linea serie");
			}
		}
	}

	/**
	 * @throws IOException
	 */

	public String leer() throws IOException {
		int max = 1024;
		byte[] buffer = new byte[max];
		int len = -1;
		int offset = 0;
		boolean fin = false;
		while (!fin) {
			System.out.println("leyendo");
			System.out.println("" + fin);
			len = this.in.read(buffer, offset, max - offset);
			System.out.println("" + buffer.toString());
			System.out.println("len: " + len);
			offset += len;
			if (new String(buffer, offset - 1, 1) != null) {
				fin = true;
			}
		}

		return (new String(buffer, 0, offset));
	}

	public void escribir(String msg) {
		try {
			this.out.write(msg.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public char convertirLetra(String msg) {
//      StringBuilder binary = new StringBuilder();
//	  for (byte b : bytes){
//		  int val = b;
//		  for (int i = 0; i < 8; i++){
//			  binary.append((val & 128) == 0 ? 0 : 1);
//			  val <<= 1;
//		  }
//	  }
//	  System.out.println("'" + bytes + "' to binary: " + binary);
//	  String msgBinary = binary.toString();	     
		int parseInt = Integer.parseInt(msg, 2);
		char c = (char) parseInt;
		System.out.println("Texto convertido en letra: " + c);
		return c;
	}

	public String convertirBinario(String msg) {
		byte[] bytes = msg.getBytes();
		StringBuilder binary = new StringBuilder();
		for (byte b : bytes) {
			int val = b;
			for (int i = 0; i < 8; i++) {
				binary.append((val & 128) == 0 ? 0 : 1);
				val <<= 1;
			}
			// binary.append(' ');
		}
		System.out.println("'" + msg + "' to binary: " + binary);
		return binary.toString();
	}

	public boolean[] convertirBoolean(String msg) {
		boolean[] estadosCasa = new boolean[8];
		for (int i = 0; i < msg.length(); i++) {
			int a = Integer.parseInt(String.valueOf(msg.charAt(i)));
			if (a == 1) {
				estadosCasa[i] = true;
				System.out.println("true");
			} else {
				estadosCasa[i] = false;
				System.out.println("false");
			}
		}
		return estadosCasa;
	}

	public CommPortIdentifier encontrarPuerto() {
		java.util.Enumeration<CommPortIdentifier> portEnum = CommPortIdentifier.getPortIdentifiers();
		while (portEnum.hasMoreElements()) {
			CommPortIdentifier portIdentifier = portEnum.nextElement();
			if (this.getPortTypeName(portIdentifier.getPortType()).equals("Serial")) {
				return portIdentifier;
			}
			System.out.println(portIdentifier.getName() + " - " + getPortTypeName(portIdentifier.getPortType()));
		}
		return null;
	}

	public String getPortTypeName(int portType) {
		switch (portType) {
		case CommPortIdentifier.PORT_I2C:
			return "I2C";
		case CommPortIdentifier.PORT_PARALLEL:
			return "Parallel";
		case CommPortIdentifier.PORT_RAW:
			return "Raw";
		case CommPortIdentifier.PORT_RS485:
			return "RS485";
		case CommPortIdentifier.PORT_SERIAL:
			return "Serial";
		default:
			return "unknown type";
		}
	}

	public void cerrar() {
		commPort.close();
	}
}
