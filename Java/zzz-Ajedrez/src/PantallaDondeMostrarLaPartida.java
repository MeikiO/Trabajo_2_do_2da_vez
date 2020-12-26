

import java.awt.FlowLayout;

import javax.swing.JFrame;
import javax.swing.JPanel;
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
     
     public PantallaDondeMostrarLaPartida(Partida partida)
     {
	     cuadro = new JPanel();
	
	     enJuego=partida;
	     
		     
	     buscador = new GameBrowser(partida.getJuego());
	     
	    
	     
	     buscador.setEditable(true); // con esto podemos editar las posiciones del tablero a mano
	     
	     cuadro.add(buscador);

	     
	     
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
		
     
     

}

