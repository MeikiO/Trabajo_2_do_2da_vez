import java.io.File;
import java.io.IOException;

import chesspresso.game.Game;
import chesspresso.game.GameModel;
import chesspresso.game.view.GameBrowser;
import javafx.application.Application;
import javafx.embed.swing.SwingNode;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.geometry.Side;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextField;
import javafx.scene.control.ToggleGroup;
import javafx.scene.image.Image;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundImage;
import javafx.scene.layout.BackgroundPosition;
import javafx.scene.layout.BackgroundRepeat;
import javafx.scene.layout.BackgroundSize;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.paint.ImagePattern;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

public class Menus extends Application {

public Scene inicio, seleccion,cargarPartida,juego,pausa,terminacion;
public GridPane grid;
public Partida partida;

public boolean paraGuardar;
public File selectedFile;


/*
 Notas del programa: 
 El programa para su funcionamientos Utiliza la version 8 de java , 11 de javaFx , y la version estandar de chespresso
 
 +Solo lee y escribe archivos PGN de formato estandar, cuya estension sea .pgn
 
 +PGN se refiere con Portable Game Notation, no confundir con archivo de imagen PNG.
 
 
 Para procurar archivos pgn la pagina que recomiendo es
 
 https://www.pgnmentor.com/files.html 
 
 
 * */



public static void main(String[] args) {
launch(args);
}


@Override
public void start(Stage primaryStage) {
        
primaryStage.setTitle("Juego Ajedrez");


//Scene 1

inicio= new Scene(this.menuInicio(primaryStage), 250, 180);
               
//Scene 2

seleccion= new Scene(this.menuSeleccion(primaryStage), 350, 300); 


//scene 3


//scene 4

//juego=new Scene(this.juego(primaryStage),600,500); 

//este se crea cada vez que accedamos al juego


//scene 5

pausa=new Scene(this.pausa(primaryStage),250,180);


primaryStage.setScene(inicio);

//primaryStage.setScene(juego);


primaryStage.show();

}


private  GridPane setBasePanel(Stage primaryStage) {
	// TODO Auto-generated method stub
   
	//el grid es el contenedor para poner todos los demas contenidos
	
	grid = new GridPane();
     grid.setAlignment(Pos.CENTER);
     grid.setHgap(10);
     grid.setVgap(20);
     grid.setPadding(new Insets(30, 50, 50, 50));
     
    primaryStage.getIcons().add(new Image(getClass().getResourceAsStream("imagen/icon.png")));
     
 	Image tile = new Image(getClass().getResourceAsStream("imagen/imagen.jpg"));
 	
 	// create a background fill for this node from the tile image
 	BackgroundPosition backgroundPosition = new BackgroundPosition(
 			Side.LEFT, 0, false, Side.TOP, 0, false);
 	
 	BackgroundImage backgroundImage = new BackgroundImage(tile,
 			BackgroundRepeat.REPEAT, BackgroundRepeat.REPEAT,
 			backgroundPosition, BackgroundSize.DEFAULT);
 	
 	Background background = new Background(backgroundImage);
 	
 	
 	// apply that background fill
 	
 	grid.setBackground(background);
     
     
     return grid;
}





private Parent menuInicio(Stage primaryStage) {
	

	grid = this.setBasePanel(primaryStage);
	
	
	Button button1= new Button("New game");
	button1.setOnAction(e -> primaryStage.setScene(seleccion));   
	grid.add(button1, 0, 0);
	
	
	Button button2= new Button("Load game");
	button2.setOnAction(e -> {
		
		this.setParaGuardar(false);
		
		
		selectedFile=this.abrirArchivos(primaryStage);
        
      
		Partida cargada=new Partida();

        Game loaded=cargada.CargarDesdeUnArchivo(selectedFile);

		cargada.setJuego(loaded);
		
		this.setPartida(cargada);
		
	
	 	juego=new Scene(this.juego(primaryStage),600,500); // en vez de crear partida nueva 
	 														//tenemos que crear la escena(panel) de nuevo

	 	primaryStage.setScene(juego);
		   
	});   
	grid.add(button2, 0, 1);
	  
	
	Button button3= new Button("Exit");
	button3.setOnAction(e -> primaryStage.close());  
	grid.add(button3, 0, 2);
	
	
	VBox layout1 = new VBox(20);     
 	layout1.getChildren().addAll(grid);
 	
     
     return layout1;

}







private Parent menuSeleccion(Stage primaryStage) {
	// TODO Auto-generated method stub
	
	//añadimos contenido haciendo add al grid
	
	grid = this.setBasePanel(primaryStage);

	// TODO Auto-generated method stub
	
		//añadimos contenido haciendo add al grid
		
	     Label label1 = new Label("Event:");
	    
	   
	    // label1.setTextFill(Color.BLANCHEDALMOND);
	     //label1.setFont(new Font("Arial", 24));
	     grid.add(label1, 0, 1);

	     TextField event = new TextField();
	     grid.add(event, 1, 1);


	     Label label2 = new Label("Lugar:");
	     grid.add(label2, 0, 2);

	     TextField lugar = new TextField();
	     grid.add(lugar, 1, 2);
	     
	     Label label3 = new Label("Jugador Blanco:");
	     grid.add(label3, 0, 3);

	     TextField jugadorblanco = new TextField();
	     grid.add(jugadorblanco, 1, 3);
	     
	     Label label4 = new Label("Jugador Negro:");
	     grid.add(label4, 0, 4);

	     TextField jugadornegro = new TextField();
	     grid.add(jugadornegro , 1, 4);
	     
	     
	     
	   //A radio button para el tiempo de la plaka
	     
	     final ToggleGroup group = new ToggleGroup();

	     RadioButton rb1 = new RadioButton("33");
	     rb1.setToggleGroup(group);
	     rb1.setSelected(true);
	     grid.add(rb1, 0, 5);
	     
	     //A radio button with the specified label
	     RadioButton rb2 = new RadioButton("99");
	     rb2.setToggleGroup(group);
	      grid.add(rb2, 1, 5);
	     
	     
	     
	  	Button button1= new Button("Jugar");
	  	
	  	button1.setOnAction(e ->{

	  	
	  	System.out.println(group.selectedToggleProperty().toString());
	  		
	  	LineaSerie aMandar=new LineaSerie();
	  	
	  	if(group.selectedToggleProperty().toString().contains("'33'")) {
	  		aMandar.mandar("a");
	  	}
	  	else {
	  		aMandar.mandar("b");
	  	}
	  	
	  		
	  		

	  	Partida nueva=new Partida();
	 	
	  	nueva.ponerTagsIniciales(event.getText(), lugar.getText(), jugadorblanco.getText(), jugadornegro.getText());
	  	
	  	this.setPartida(nueva);
	 	
	  	juego=new Scene(this.juego(primaryStage),600,500); // en vez de crear partida nueva 
	  													   //tenemos que crear la escena(panel) de nuevo
	  		
	  	primaryStage.setScene(juego);
	  	
	  	
	  	});
	  	
	  	grid.add(button1, 0, 6);
	  		
	  
	  	
	  	
	 	Button button2= new Button("Volver al inicio");
	  	button2.setOnAction(e -> {
	  		
	  		primaryStage.setScene(inicio);
	  	
	  	});   
	    
		grid.add(button2, 1, 6);
	    
		
		
	 	
		VBox layout1 = new VBox(20);     
	 	layout1.getChildren().addAll(grid);
	 	
	     
	  return layout1;

}






private Parent juego(Stage primaryStage) {
	// TODO Auto-generated method stub
	
	grid = this.setBasePanel(primaryStage);
	
	
	Button button1= new Button("Pausa");
	button1.setOnAction(e -> primaryStage.setScene(pausa));   
	grid.add(button1, 0, 1);
	
	Pane pane = new Pane();	
	pane=this.enseñarPartida(partida);
	grid.add(pane, 0, 2);
		

	VBox layout1 = new VBox(20);     
 	layout1.getChildren().addAll(grid);
 	
     
 	return layout1;
}



private Pane enseñarPartida(Partida partida2) {
	// TODO Auto-generated method stub
	
	//en vez de crear una clase para ello, es mas seguro
	//hacerlo aqui mismo, ya que hasi el proceso esta accesible
	//para las escenas de javaFx
   
	GameBrowser buscador = new GameBrowser(partida.getJuego()); 
    buscador.setEditable(true); // con esto podemos editar las posiciones del tablero a mano
	 
   
    final SwingNode swingNode = new SwingNode();
   swingNode.setContent(buscador);  //se adapta el componente Swing del tablero a JavaFx

    
   TextField txtInformacion = new TextField();
   
  
   MiGestorDePartida gestor = new MiGestorDePartida(txtInformacion);
    partida.getJuego().addChangeListener(gestor); 
   
	 
   VBox layout1 = new VBox(20);
   layout1.getChildren().addAll(swingNode, txtInformacion);
   
   return layout1;
}





private Parent pausa(Stage primaryStage) {
	// TODO Auto-generated method stub
	
	grid = this.setBasePanel(primaryStage);
	
	Button button1= new Button("Continue");
	button1.setOnAction(e -> primaryStage.setScene(juego));   
	grid.add(button1, 0, 0);

	Button button3= new Button("Save game");
	button3.setOnAction(e -> {
		
	this.setParaGuardar(true);
	
	selectedFile=this.abrirArchivos(primaryStage);
	
	primaryStage.setScene(inicio);
	
	this.partida.guardarEnUnArchivo(selectedFile); 
	   
	}); 
	grid.add(button3, 0, 1);
	
	
	
	Button button4= new Button("Resign");
	//acabar la partida y borrar la partida guardada que habia antes   
	
	button4.setOnAction(e -> {
		

	primaryStage.setScene(inicio);
		   
	}); 
	grid.add(button4, 0, 2);
	
	
 	VBox layout1 = new VBox(20);     
 	layout1.getChildren().addAll(grid);
 	
     
     return layout1;
}






private File abrirArchivos(Stage primaryStage) {
	// TODO Auto-generated method stub
	File selectedFile;
	
	FileChooser fileChooser = new FileChooser();
	
    fileChooser.setInitialDirectory(new File("C:\\Users\\mikel\\Desktop\\proyecto\\producto\\Java\\zzz-Ajedrez\\src\\files"));

    fileChooser.getExtensionFilters().addAll(
    	     new FileChooser.ExtensionFilter("PGN", "*.pgn")
    	    ,new FileChooser.ExtensionFilter("Binario", "*.bin")
    );
    
    if(this.isParaGuardar()) {
    	 selectedFile = fileChooser.showSaveDialog(primaryStage);	
    }
    else {
    	selectedFile = fileChooser.showOpenDialog(primaryStage);
    }
	
 
    return selectedFile;
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



public boolean isParaGuardar() {
	return paraGuardar;
}


public void setParaGuardar(boolean paraGuardar) {
	this.paraGuardar = paraGuardar;
}




}
