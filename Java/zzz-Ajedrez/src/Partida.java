

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
     private Position tablero;
     
     short movimientos[]=new short[10];

     public Game getJuego()
     {
         return juego;
     }


     public Partida()
     {

         juego = new Game();
  
       /* 
         juego.setTag(PGN.TAG_EVENT, "Partida de pruebas");
         juego.setTag(PGN.TAG_SITE, "mi caaassaaaa...");
         Calendar calendario = Calendar.getInstance();
         calendario.set(2020, 12, 22);
         juego.setTag(PGN.TAG_DATE,
         PGN.dateToPGNDate(calendario.getTime()));

         juego.setTag(PGN.TAG_WHITE, "Benzirpi Mirvento");
         juego.setTag(PGN.TAG_BLACK, "Eloiza Batiati");
          
         juego.setTag(PGN.TAG_RESULT, "1. d4 d5 2. e4 dxe4 3. Nf3 Qd5 4. Ne5");
         */ 
         
         //este no sirve para que se muevan, para que se se vea el resultado
         // y sea interactivo tienes que moverlos
        
         //movimientos[0]= Move.getRegularMove(Chess.E2, Chess.E4,false);
         
         
         
         tablero = juego.getPosition();
         
        
         
         //this.recrearMovientos();

          
     }


     
     public void ponerTagsIniciales(String evento,String sitio,String blanco,String negro) {
    	
    	 juego.setTag(PGN.TAG_RESULT, "");
    	 juego.setTag(PGN.TAG_ROUND, "");
    	 
    	
    	 if(evento.isEmpty()) {
    		 evento="partida";
    	 }
    	juego.setTag(PGN.TAG_EVENT, evento);
    	 
    	 
    	 if(sitio.isEmpty()) {
    		 sitio="aqui";
    	 }
         juego.setTag(PGN.TAG_SITE, sitio);
         
         
         Calendar calendario = Calendar.getInstance();
         calendario.set(2020, 12, 22);
         juego.setTag(PGN.TAG_DATE,
         PGN.dateToPGNDate(calendario.getTime()));

         
         
         if(blanco.isEmpty()) {
        	 blanco="Jugador Blanco";
         }
         
         juego.setTag(PGN.TAG_WHITE, blanco);
         
         juego.setTag(PGN.TAG_WHITE_ELO, "0");
         
         
         
         if(negro.isEmpty()) {
        	 negro="Jugador Negro";
         }
         
         juego.setTag(PGN.TAG_BLACK, negro);
         
         juego.setTag(PGN.TAG_BLACK_ELO, "0");
         
         
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

     

     
 
     
public void guardarEnUnArchivo(File archivo)  {
         
    
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
                	 
                	 //este finaly es para suprimir el error que da a la hora de escribir en archivo 
                	 //usando el PGNWritter,teniendo java 8 en el sistema y la version 11 jdk javafx da error NullPointerException.
                	 //por la informacion vista para ser que el thead de java fx interfiere con la escritura de esta clase.
                	 //para ello usamos esta excepcion
                	 //aunque lo curioso es que aunque de excepcion deja guardar.
                	 
                     if (escritor != null) {
                         try {
                             escritor.close();
                         } catch (IOException e1) {
                             e1.printStackTrace();
                         }
                         catch(NullPointerException e) {
                        	 System.out.print(" se ha guardado /n");
                         }
                     }
                 }
             }
     }

    
     
     public Game CargarDesdeUnArchivo(File archivo) {
         
    	 Game cargado=new Game();
         
    
         if (archivo != null) {
             try {
                 DataInputStream flujoDeEntrada = new DataInputStream(new FileInputStream(archivo));
                 
                 
                 /*Guardar de otra manera
                     GameModel modelo = new GameModel(flujoDeEntrada, GameHeaderModel.MODE_STANDARD_TAGS, GameMoveModel.MODE_EVERYTHING);
                 
                  * */
                  
              
                    PGNReader lectorPGN = new PGNReader(flujoDeEntrada, "?unNombre?");
                     
                    try {
                         cargado= lectorPGN.parseGame(); //lee la siguiente partida que haya en el archivo PGN
                     } 									 //lee 1 partida por cada vez que se ejecuta el parse(pasar por la linea)
                    catch (PGNSyntaxError e) {
                         // TODO Auto-generated catch block
                         e.printStackTrace();
                     }
                 
                 flujoDeEntrada.close();
             }
             catch (FileNotFoundException e1) {
                 // TODO Auto-generated catch block
                 e1.printStackTrace();
             }
             catch (IOException e2) {
                 // TODO Auto-generated catch block
                 e2.printStackTrace();
             }
         }
         
         return cargado;
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
