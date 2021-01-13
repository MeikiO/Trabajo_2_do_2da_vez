


import java.io.DataInputStream;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import java.io.FileWriter;
import java.io.IOException;

import java.util.Calendar;








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
         
         tablero = juego.getPosition();
                
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
     

public void guardarEnUnArchivo(File archivo)  {
           
         if (archivo != null) {
             FileWriter escritor = null;
             try {
            	 
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
                 
            
                    PGNReader lectorPGN = new PGNReader(flujoDeEntrada, "?unNombre?");
                     
                    try {
                         cargado= lectorPGN.parseGame(); //lee la siguiente partida que haya en el archivo PGN
                     } 									 
                    catch (PGNSyntaxError e) {
                         // TODO Auto-generated catch block
                         e.printStackTrace();
                     }
                 
                 flujoDeEntrada.close();
             }
             catch (FileNotFoundException e1) {
       
                 e1.printStackTrace();
             }
             catch (IOException e2) {
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
