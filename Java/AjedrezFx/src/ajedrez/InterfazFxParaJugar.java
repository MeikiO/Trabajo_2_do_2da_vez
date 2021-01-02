package ajedrez;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

import chesspresso.Chess;
import chesspresso.game.Game;
import chesspresso.game.GameHeaderModel;
import chesspresso.game.GameMoveModel;
import chesspresso.game.view.GameBrowser;
import chesspresso.game.view.HTMLGameBrowser;
import chesspresso.move.IllegalMoveException;
import chesspresso.move.Move;
import chesspresso.pgn.PGN;
import chesspresso.pgn.PGNWriter;
import chesspresso.position.Position;
import javafx.application.Application;
import javafx.collections.ObservableList;
import javafx.embed.swing.SwingNode;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import javafx.scene.control.TextField;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.scene.web.WebEngine;
import javafx.scene.web.WebView;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;

public class InterfazFxParaJugar extends Application {
    
    private static Partida partida;
    private TextField txtInformacion;
    
   
    @Override
    public void start(Stage primaryStage) throws Exception {
        
        VBox nodoRaiz = new VBox();
        ObservableList<Node> arbolDeNodos = nodoRaiz.getChildren();

//        final SwingNode gbTableroDeJuego = new SwingNode();
//        GameBrowser tablero = new  GameBrowser(partida.getJuego());
//        tablero.setEditable(true);
//        gbTableroDeJuego.setContent(tablero);
//        arbolDeNodos.add(gbTableroDeJuego);
        
        HTMLGameBrowser webTableroDeJuego = new HTMLGameBrowser();
        WebView webVistaDelTablero = new WebView();
        WebEngine webMotorDelTablero = webVistaDelTablero.getEngine();
        ByteArrayOutputStream flujoDeSalida = new ByteArrayOutputStream();
        webTableroDeJuego.produceHTML(flujoDeSalida, partida.getJuego());
        webMotorDelTablero.loadContent(flujoDeSalida.toString());
        arbolDeNodos.add(webVistaDelTablero);
        
        txtInformacion = new TextField();
        arbolDeNodos.add(txtInformacion);
        
        Button btnGuardarPartida = new Button();
        btnGuardarPartida.setText("Guardar la partida");
        btnGuardarPartida.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                partida.guardarEnUnArchivo();
            }
        });
        arbolDeNodos.add(btnGuardarPartida);
        
        Button btnCargarPartida = new Button();
        btnCargarPartida.setText("Cargar partida");
        btnCargarPartida.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                Game unNuevoJuego = partida.crearUnNuevoJuegoDesdeUnArchivo();
                //Pero ahora, ¿que hago con este nuevo juego?
            }
        });
        arbolDeNodos.add(btnCargarPartida);
        
        Scene escenaPrincipal = new Scene(nodoRaiz, 800, 600);
        
        primaryStage.setTitle("Ajedrez");
        primaryStage.setScene(escenaPrincipal);
        primaryStage.show();
        
    }

    
    public void setInformacion(String texto) {
        txtInformacion.setText(texto);
    }
    
    public void clearInformation() {
        txtInformacion.setText("");
    }    
    
    
    public static void main(String[] args) {

        partida = new Partida();

        //GestorDePartida gestor = new GestorDePartida(this);
        //partida.getJuego().addChangeListener(gestor); 

        launch(args);
    }

    
}
