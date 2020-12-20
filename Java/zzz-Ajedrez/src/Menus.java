import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class Menus extends Application {

Scene inicio, seleccion,cargarPartida,partida,pausa,terminacion;
GridPane grid;
    

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

partida=new Scene(this.juego(primaryStage),300,250);


//scene 5

pausa=new Scene(this.pausa(primaryStage),300,250);


primaryStage.setScene(inicio);
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
 	button1.setOnAction(e -> primaryStage.setScene(partida));   
 	
	Button button2= new Button("Volver al inicio");
 	button2.setOnAction(e -> primaryStage.setScene(inicio));   
 	
 	VBox layout1 = new VBox(20);     
 	layout1.getChildren().addAll(grid,label1,button1,button2);
     
     return layout1;
}


private Parent juego(Stage primaryStage) {
	// TODO Auto-generated method stub
	Label label1= new Label("partida");
	
	
	Button button1= new Button("Pausa");
	button1.setOnAction(e -> primaryStage.setScene(pausa));   
	
	
	VBox layout1 = new VBox(20);     
	layout1.getChildren().addAll(label1,button1);
	
	return layout1;
}



private Parent pausa(Stage primaryStage) {
	// TODO Auto-generated method stub
	Label label1= new Label("Pausa");
	
	Button button1= new Button("Continue");
	button1.setOnAction(e -> primaryStage.setScene(partida));   
	
	Button button2= new Button("Save game");
	//accion de guardar
	
	
	Button button3= new Button("Resign");
	//acabar la partida y borrar la partida guardada que habia antes   
	
	
	VBox layout1 = new VBox(20);     
	layout1.getChildren().addAll(label1, button1,button2,button3);
	
	return layout1;
}




private Parent menuCarga(Stage primaryStage) {
	// TODO Auto-generated method stub
	Label label1= new Label("Menu Carga");
	

	
	Button button1= new Button("Accept");
	button1.setOnAction(e -> primaryStage.setScene(partida));   
	
	
	VBox layout1 = new VBox(20);     
	layout1.getChildren().addAll(label1,button1);
	
	return layout1;
}



    
}
