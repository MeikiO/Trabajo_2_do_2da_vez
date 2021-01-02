package ajedrez;

import javax.swing.JFrame;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.JFileChooser;

import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import java.util.Calendar;
import java.util.concurrent.TimeUnit;

import chesspresso.Chess;
import chesspresso.pgn.PGN;
import chesspresso.pgn.PGNReader;
import chesspresso.pgn.PGNSyntaxError;
import chesspresso.game.Game;
import chesspresso.game.GameHeaderModel;
import chesspresso.game.GameModel;
import chesspresso.game.GameMoveModel;

import chesspresso.position.Position;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import chesspresso.move.Move;
import chesspresso.move.IllegalMoveException;

import chesspresso.pgn.PGNWriter;


public class Partida {
    private Game juego;
    private Position tablero;

    public Game getJuego() {
        return juego;
    }

    public Partida() {
        
        juego = new Game();
        
        juego.setTag(PGN.TAG_EVENT, "Gran Campeonato de Pruebas");
        juego.setTag(PGN.TAG_SITE, "MiiPueeblooo...");
        Calendar calendario = Calendar.getInstance();
        calendario.set(2020, 5, 22);
        juego.setTag(PGN.TAG_DATE, PGN.dateToPGNDate(calendario.getTime()));
        juego.setTag(PGN.TAG_ROUND, "?round?");
        
        juego.setTag(PGN.TAG_WHITE, "Benzirpi Mirvento");
        juego.setTag(PGN.TAG_WHITE_ELO, "2323");
        juego.setTag(PGN.TAG_BLACK, "Eliza Batiati");
        juego.setTag(PGN.TAG_BLACK_ELO, "3232");
        juego.setTag(PGN.TAG_RESULT, "(?result?)");

        tablero = juego.getPosition();

        hacerUnParDeMovimientosIniciales();
    }

    
   
    public void guardarEnUnArchivo() {
        
        File archivo = elegirUnArchivoParaGuardar();
        
        if (archivo != null) {
            try {
                // Se puede guardar desde el propio juego
//                DataOutputStream flujoDeSalida = new DataOutputStream(new FileOutputStream(archivo));
//                juego.save(flujoDeSalida, GameHeaderModel.MODE_STANDARD_TAGS, GameMoveModel.MODE_EVERYTHING);
//                flujoDeSalida.close();
                // O se puede tambien guardar haciendo uso directo de las funciones a tal efecto de la clase PGN.
                FileWriter escritor = new FileWriter(archivo);
                PGNWriter escritorPGN = new PGNWriter(escritor);
                escritorPGN.write(juego.getModel());
                escritor.close();
            }
            catch (FileNotFoundException e1) {
                e1.printStackTrace();
            }
            catch (IOException e2) {
                e2.printStackTrace();
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
//                GameModel modelo = new GameModel(flujoDeEntrada, GameHeaderModel.MODE_STANDARD_TAGS, GameMoveModel.MODE_EVERYTHING);
//                flujoDeEntrada.close();
//                return new Game(modelo);
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

    
    
    
// De aqu� en adelante es una parte de experimentos y pruebas con la bibioteca Chesspresso. No es parte funcional del programa.     
    
    private void hacerUnParDeMovimientosIniciales() {
        short unMovimiento = Move.getRegularMove(Chess.E2, Chess.E4, false);
        short otroMovimiento = Move.getRegularMove(Chess.B7, Chess.B5, false);
        try {
            tablero.doMove(unMovimiento);
            // tablero.doMove(Move.ILLEGAL_MOVE);
            tablero.doMove(otroMovimiento);
        } catch (IllegalMoveException e) {
            System.out.println("No puedes hacer ese movimiento.");
            e.printStackTrace();
        }

    }


    
    
}
