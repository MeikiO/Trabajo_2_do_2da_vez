

import java.io.DataInput;
import java.io.DataInputStream;
import java.io.DataOutput;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.Calendar;





import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.filechooser.FileNameExtensionFilter;


import chesspresso.Chess;
import chesspresso.pgn.PGN;
import chesspresso.pgn.PGNReader;
import chesspresso.pgn.PGNSyntaxError;
import chesspresso.pgn.PGNWriter;
import chesspresso.game.Game;
import chesspresso.game.GameHeaderModel;
import chesspresso.game.GameModel;
import chesspresso.game.GameMoveModel;

import chesspresso.position.Position;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import chesspresso.move.Move;
import chesspresso.move.IllegalMoveException;



public class Partida {
     private Game juego;
     private GameModel modelo;
     private Position tablero;
     
     short movimientos[]=new short[10];

     public Game getJuego()
     {
         return juego;
     }


     public Partida()
     {
    	 
    	 
         juego = new Game();
  
         
      
         
         juego.setTag(PGN.TAG_EVENT, "Partida de pruebas");
         juego.setTag(PGN.TAG_SITE, "mi caaassaaaa...");
         Calendar calendario = Calendar.getInstance();
         calendario.set(2020, 12, 22);
         juego.setTag(PGN.TAG_DATE,
         PGN.dateToPGNDate(calendario.getTime()));
         juego.setTag(PGN.TAG_ROUND, "?!?");
         juego.setTag(PGN.TAG_WHITE, "Benzirpi Mirvento");
         juego.setTag(PGN.TAG_BLACK, "Eloiza Batiati");
         
         //juego.setTag(PGN.TAG_RESULT, "1. d4 d5 2. e4 dxe4 3. Nf3 Qd5 4. Ne5");
         
         //este no sirve para que se muevan, para que se se vea el resultado
         // y sea interactivo tienes que moverlos
         //movimientos[0]= Move.getRegularMove(Chess.E2, Chess.E4,false);
         
         
         
         tablero = juego.getPosition();
         
        
         
         //this.recrearMovientos();

          
     }


     
     
     private void recrearMovientos() {
    	 
    
    	 
         movimientos[0]= Move.getRegularMove(Chess.E2, Chess.E4,false);
         movimientos[1]= Move.getRegularMove(Chess.E7, Chess.E5,false);
    
         
         for(int i=0;i<=1;i++) {
        try
         {
             tablero.doMove(movimientos[i]);
         }
         catch (IllegalMoveException e)
         {
             System.out.println("No puedes hacer ese movimiento.");
             e.printStackTrace();
         } 
         }
        
        
        
         System.out.print( Move.getString(movimientos[0]));
         
     }
     
     
     private void ParaObtenerInformacionSobreElJuego()
     {
         //Esto son solo pruebas y comentarios, no vale para nada... porahora...
         GameModel modelo = juego.getModel();
         GameHeaderModel cabecera = modelo.getHeaderModel();
         GameMoveModel movimientos = modelo.getMoveModel();

     }

     
     public void guardarEnUnArchivo() {
         
         File archivo = elegirUnArchivoParaGuardar();
         
         if (archivo != null) {
             FileWriter escritor = null;
             try {
                 // Se puede guardar desde el propio juego
//                 DataOutputStream flujoDeSalida = new DataOutputStream(new FileOutputStream(archivo));
//                 juego.save(flujoDeSalida, GameHeaderModel.MODE_STANDARD_TAGS, GameMoveModel.MODE_EVERYTHING);
//                 flujoDeSalida.close();
                 // O se puede tambien guardar haciendo uso directo de las funciones a tal efecto de la clase PGN.
                 // (a JavaFX parece que le sienta mejor esta manera)
                 escritor = new FileWriter(archivo);
                 PGNWriter escritorPGN = new PGNWriter(escritor);
                 escritorPGN.write(juego.getModel());
                 escritor.close();
                 } catch (IOException e1) {
                     e1.printStackTrace();
                 } finally {
                     if (escritor != null) {
                         try {
                             escritor.close();
                         } catch (IOException e1) {
                             e1.printStackTrace();
                         }
                     }
                 }
             }
     }
     private File elegirUnArchivoParaGuardar() {
         final FileChooser selectorDeArchivos = new FileChooser();
         selectorDeArchivos.getExtensionFilters().add(new FileChooser.ExtensionFilter("Partida de ajedrez", "*.pgn"));
         return selectorDeArchivos.showSaveDialog(new Stage());
     }
  
    
     
     public Game crearUnNuevoJuegoDesdeUnArchivo() {
         
         File archivo = elegirUnArchivoParaLeer();
         
         if (archivo != null) {
             try {
                 DataInputStream flujoDeEntrada = new DataInputStream(new FileInputStream(archivo));
                 // Se puede recuperar creando un nuevo juego a partir de la lectura del contenido del archivo.
//                 GameModel modelo = new GameModel(flujoDeEntrada, GameHeaderModel.MODE_STANDARD_TAGS, GameMoveModel.MODE_EVERYTHING);
//                 flujoDeEntrada.close();
//                 return new Game(modelo);
                 // O se puede tambien recuperar creando un nuevo juego mediante las funciones a tal efecto de la clase PGN.
                PGNReader lectorPGN = new PGNReader(flujoDeEntrada, "?unNombre?");
                 try {
                     Game juego = lectorPGN.parseGame();
                     flujoDeEntrada.close();
                     return juego;
                 } catch (PGNSyntaxError e) {
                     e.printStackTrace();
                 }
             }
             catch (FileNotFoundException e1) {
                 e1.printStackTrace();
             }
             catch (IOException e2) {
                 e2.printStackTrace();
             }
         }
         return null;
     }
     private File elegirUnArchivoParaLeer() {
         final FileChooser selectorDeArchivos = new FileChooser();
         selectorDeArchivos.getExtensionFilters().add(new FileChooser.ExtensionFilter("Partida de ajedrez", "*.pgn"));
         return selectorDeArchivos.showOpenDialog(new Stage());
     }

     
     





	public GameModel getModelo() {
		return modelo;
	}


	public void setModelo(GameModel modelo) {
		this.modelo = modelo;
	}


	public Position getTablero() {
		return tablero;
	}


	public void setTablero(Position tablero) {
		this.tablero = tablero;
	}


	public void setJuego(Game juego) {
		this.juego = juego;
	}
     
     
     
}
