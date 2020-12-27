

import java.awt.Button;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.WindowConstants;

import chesspresso.game.Game;
import chesspresso.game.GameModel;
import chesspresso.game.view.GameBrowser;
import javafx.embed.swing.SwingNode;

public class PantallaDondeMostrarLaPartida {
     private JPanel cuadro;
     Partida enJuego;
     GameBrowser buscador;
     private JTextField txtInformacion;
     
     public PantallaDondeMostrarLaPartida(Partida partida)
     {
	     cuadro = new JPanel();
	     cuadro.setLayout(new BoxLayout(cuadro, WindowConstants.EXIT_ON_CLOSE));
	     
	     
	     enJuego=partida;
	     
		 
	     buscador = new GameBrowser(partida.getJuego()); 
	       
	     buscador.setEditable(true); // con esto podemos editar las posiciones del tablero a mano
	     
	     cuadro.add(buscador);

	     
	    
	     txtInformacion = new JTextField();
	     cuadro.add(txtInformacion);
	     
	     /*
	      Por restricciones en las escenas de javafx en el menu, ya que 
	      no es posible pasar informacion de una escena a otra , he puesto los 
	      botones de guardar y resign aqui, ya que al poner los botones en el
	      menu pausa me daba null pointer exception, y no guardaba.
	      */
	

	     
	    	     
	     
	     cuadro.setVisible(true);
	     
	
     }


    public void corregirIlegales() {
    	
    }
     

	public JPanel getCuadro() {
		return cuadro;
	}

	public void setCuadro(JPanel cuadro) {
		this.cuadro = cuadro;
	}

	

	public void createAndSetSwingContent(SwingNode swingNode) {
      
          swingNode.setContent(cuadro);  
          //swingNode es una clase adaptador de javaFX para poder meter
          //elementos graficos de swing.
	}

	public Partida getEnJuego() {
		return enJuego;
	}

	public void setEnJuego(Partida enJuego) {
		this.enJuego = enJuego;
	}

	public GameBrowser getTablero() {
		return buscador;
	}

	public void setTablero(GameBrowser tablero) {
		this.buscador = tablero;
	}       
		
    public void setInformacion(String texto) {
        txtInformacion.setText(texto);
    }
    
    public void clearInformation() {
        txtInformacion.setText("");
    }
     

    
}

