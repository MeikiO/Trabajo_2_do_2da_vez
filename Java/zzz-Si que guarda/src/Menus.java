import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

import chesspresso.game.Game;
import chesspresso.game.GameModel;
import chesspresso.game.view.GameBrowser;
import chesspresso.pgn.PGN;
import chesspresso.pgn.PGNWriter;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.embed.swing.SwingNode;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

public class Menus extends Application {

public Scene inicio, seleccion,cargarPartida,juego,pausa,terminacion;
public GridPane grid;
public Partida partida;
public boolean cargado;
public boolean paraGuardar;
public File selectedFile;


public static void main(String[] args) {
launch(args);
}


@Override
public void start(Stage primaryStage) {
        
primaryStage.setTitle("Juego Ajedrez");


//Scene 1

inicio= new Scene(this.menuInicio(primaryStage), 300, 250);
               
//Scene 2

seleccion= new Scene(this.menuSeleccion(primaryStage), 300, 275); 


//scene 3

cargarPartida=new Scene(this.menuCarga(primaryStage),300,250);

//scene 4
//juego=new Scene(this.juego(primaryStage),600,500);  

//scene 5

pausa=new Scene(this.pausa(primaryStage),300,250);


primaryStage.setScene(inicio);

//primaryStage.setScene(juego);


primaryStage.show();

}




private Parent menuInicio(Stage primaryStage) {
	// TODO Auto-generated method stub
	Label label1= new Label("Menu principal");
	
	Button button1= new Button("New game");
	button1.setOnAction(e -> primaryStage.setScene(seleccion));   
	
	Button button2= new Button("Load game");
	button2.setOnAction(e -> primaryStage.setScene(cargarPartida));   
	
	Button button3= new Button("Exit");
	button3.setOnAction(e -> primaryStage.close());   
	
	
	VBox layout1 = new VBox(20);     
	layout1.getChildren().addAll(label1, button1,button2,button3);
	
	return layout1;
}


private Parent menuSeleccion(Stage primaryStage) {
	// TODO Auto-generated method stub
   
	//el grid es el contenedor para poner todos los demas contenidos

	grid = new GridPane();
     grid.setAlignment(Pos.CENTER);
     grid.setHgap(10);
     grid.setVgap(10);
     grid.setPadding(new Insets(25, 25, 25, 25));
     
    Label label1= new Label("menu seleccion");
 	
 	Button button1= new Button("Jugar");
 	
 	button1.setOnAction(e ->{
 	
 	this.setCargado(false);	
 	juego=new Scene(this.juego(primaryStage),600,500); // en vez de crear partida nueva 
 													   //tenemos que crear la escena(panel) de nuevo
 		
 	primaryStage.setScene(juego);
 	
 	
 	});
 		
 
	Button button2= new Button("Volver al inicio");
 	button2.setOnAction(e -> {
 		
 		primaryStage.setScene(inicio);
 	
 	});   
 	
 	VBox layout1 = new VBox(20);     
 	layout1.getChildren().addAll(grid,label1,button1,button2);
     
     return layout1;
}




private Parent juego(Stage primaryStage) {
	// TODO Auto-generated method stub
	Label label1= new Label("partida");
	
	Button button1= new Button("Pausa");
	button1.setOnAction(e -> primaryStage.setScene(pausa));   
	

	if(!this.isCargado()) {
		this.setPartida(new Partida()); //mejor aqui sino la partida cargada se reinicia	
		
	}
	
	
	Pane pane = new Pane();	
	pane=this.enseñarPartida(partida);

		
	VBox layout1 = new VBox(20);
	layout1.getChildren().addAll(label1,button1,pane);
	

	
	return layout1;
}





private Pane enseñarPartida(Partida partida2) {
	// TODO Auto-generated method stub
    GameBrowser buscador = new GameBrowser(partida.getJuego()); 
    buscador.setEditable(true); // con esto podemos editar las posiciones del tablero a mano
	 
   final SwingNode swingNode = new SwingNode();
   swingNode.setContent(buscador);  //se adapta el componente Swing a JavaFx

    
   TextField txtInformacion = new TextField();
   
    MiGestorDePartida gestor = new MiGestorDePartida(txtInformacion);
    partida.getJuego().addChangeListener(gestor); 
   
	 
   VBox layout1 = new VBox(20);
   layout1.getChildren().addAll(swingNode, txtInformacion);
   
   return layout1;
}
                             
         


private Parent pausa(Stage primaryStage) {
	// TODO Auto-generated method stub
	Label label1= new Label("Pausa");
	
	
	
	Button button1= new Button("Continue");
	button1.setOnAction(e -> primaryStage.setScene(juego));   
	

	
	
	Button button3= new Button("Save game");
	button3.setOnAction(e -> {
	    

    	this.setParaGuardar(true);
    	this.getPartida().guardarEnUnArchivo(); 
    	primaryStage.setScene(inicio);
	}); 
	
	
	
	Button button4= new Button("Resign");
	//acabar la partida y borrar la partida guardada que habia antes   
	
	button4.setOnAction(e -> {
		
		
		
	primaryStage.setScene(inicio);
		   
	}); 
	
	
	VBox layout1 = new VBox(20);     
	layout1.getChildren().addAll(label1, button1,button3,button4);
	
	return layout1;
}




private Parent menuCarga(Stage primaryStage) {
	// TODO Auto-generated method stub
	Label label1= new Label("Menu Carga");
	

	Button button1= new Button("Accept");
	button1.setOnAction(e ->{
		
		this.setParaGuardar(false);
		
        Partida cargada=new Partida();

        Game loaded=cargada.crearUnNuevoJuegoDesdeUnArchivo();

		cargada.setJuego(loaded);
		
		this.setPartida(cargada);
		
		
		this.setCargado(true);
		
		
	 	juego=new Scene(this.juego(primaryStage),600,500); // en vez de crear partida nueva 
	 														//tenemos que crear la escena(panel) de nuevo

	 	primaryStage.setScene(juego);
		   
	});   
	
	
	VBox layout1 = new VBox(20);     
	layout1.getChildren().addAll(label1,button1);
	
	return layout1;
}





//en caso de que se acceda a la variable desde distintas escenas
//para evitar que se vuelva null al cambiar de escena 
//tenemos que acceder con getter y seters sino las variables seran null


public Partida getPartida() {
	return partida;
}


public void setPartida(Partida partida) {
	this.partida = partida;
}


public boolean isCargado() {
	return cargado;
}


public void setCargado(boolean cargado) {
	this.cargado = cargado;
}


public boolean isParaGuardar() {
	return paraGuardar;
}


public void setParaGuardar(boolean paraGuardar) {
	this.paraGuardar = paraGuardar;
}




    
}
