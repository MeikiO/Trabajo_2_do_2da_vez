

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

     
     public enum FormatoDeSalida {
         BINARIO,
         PGN
     }
     
 
     
     public void guardarEnUnArchivo(File selectedFile,Partida partidaAGuardar) {
         
    	 
         if (selectedFile != null) {
             try {
                
                /*case BINARIO:
                     DataOutputStream flujoDeSalida = new DataOutputStream(new FileOutputStream(archivo));
                     juego.save(flujoDeSalida, GameHeaderModel.MODE_STANDARD_TAGS, GameMoveModel.MODE_EVERYTHING);
                     flujoDeSalida.close();
               */   
                     //pgn:
                     FileWriter escritor = new FileWriter(selectedFile);
                     PGNWriter escritorPGN = new PGNWriter(escritor);
                     escritorPGN.write(partidaAGuardar.getModelo());
                     escritor.close();
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
     }

    
     
     public Game CargarDesdeUnArchivo(File archivo) {
         
    	 Game cargado=new Game();
         
         FormatoDeSalida formato = null;
         if (archivo.getName().contains(".bin")) {
             formato = FormatoDeSalida.BINARIO;
         }
         else if (archivo.getName().contains(".pgn")) {
             formato = FormatoDeSalida.PGN;
         }
         
         if (archivo != null) {
             try {
                 DataInputStream flujoDeEntrada = new DataInputStream(new FileInputStream(archivo));
                 switch (formato) {
                 case BINARIO:
                     GameModel modelo = new GameModel(flujoDeEntrada, GameHeaderModel.MODE_STANDARD_TAGS, GameMoveModel.MODE_EVERYTHING);
                 
                 default: //pgn:
                    PGNReader lectorPGN = new PGNReader(flujoDeEntrada, "?unNombre?");
                     
                    try {
                         cargado= lectorPGN.parseGame(); //lee la siguiente partida que haya en el archivo PGN
                     } 									 //lee 1 partida por cada vez que se ejecuta el parse(pasar por la linea)
                    catch (PGNSyntaxError e) {
                         // TODO Auto-generated catch block
                         e.printStackTrace();
                     }
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
