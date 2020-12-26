

import java.io.DataInput;
import java.io.DataInputStream;
import java.io.DataOutput;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
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
         
        
         
         this.recrearMovientos();
         
         GameModel modelo = juego.getModel();
         GameHeaderModel cabecera = modelo.getHeaderModel();
         GameMoveModel movimientos = modelo.getMoveModel();
       
       
   
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

     
     public void save() throws IOException {
    	 
    	 
    	  Writer file=  new FileWriter("C:\\Users\\mikel\\Desktop\\proyecto\\producto\\Java\\zzz-Ajedrez\\src\\files\\Partida"+"1"+".pgn",false);
       
         PGNWriter escritura=new PGNWriter(file);
            
         GameModel modelo = juego.getModel();
         GameHeaderModel cabecera = modelo.getHeaderModel();
         GameMoveModel movimientos = modelo.getMoveModel();
         

         escritura.write(modelo);
         
         file.close();
                    
     }
     
     public void load() {
    	 
    	    FileInputStream file = null;
    	    //PGNReader
    	    try {
				file = new FileInputStream("C:\\Users\\mikel\\Desktop\\proyecto\\producto\\Java\\zzz-Ajedrez\\src\\files\\Partida"+"1"+".txt");
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
     
    	   
          
    	     GameModel modelo = juego.getModel();
             GameHeaderModel cabecera = modelo.getHeaderModel();
             GameMoveModel movimientos = modelo.getMoveModel();
    	    
            
              

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
