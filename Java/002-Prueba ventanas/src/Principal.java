
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class Principal extends Application {

Scene scene1, scene2;
GridPane grid;
    
@Override
public void start(Stage primaryStage) {
        
primaryStage.setTitle("My First JavaFX GUI");

//Scene 1
Label label1= new Label("This is the first scene");
Button button1= new Button("Go to scene 2");
button1.setOnAction(e -> primaryStage.setScene(scene2));   
VBox layout1 = new VBox(20);     
layout1.getChildren().addAll(label1, button1);
scene1= new Scene(layout1, 300, 250);
               


//Scene 2
Label label2= new Label("This is the second scene");
Button button2= new Button("Go to scene 1");
button2.setOnAction(e -> primaryStage.setScene(scene1));
VBox layout2= new VBox(20);
layout2.getChildren().addAll(label2, button2);
scene2= new Scene(this.setBasePanel(), 300, 275); //tamaño del panel


this.contenido();


        
primaryStage.setScene(scene1);
primaryStage.show();
}








private Parent setBasePanel() {
	// TODO Auto-generated method stub
   
	//el grid es el contenedor para poner todos los demas contenidos
	
	grid = new GridPane();
     grid.setAlignment(Pos.CENTER);
     grid.setHgap(10);
     grid.setVgap(10);
     grid.setPadding(new Insets(25, 25, 25, 25));
     
     return grid;
}


private void contenido() {
	// TODO Auto-generated method stub
	
	//añadimos contenido haciendo add al grid
	
	 Text scenetitle = new Text("Welcome");
     scenetitle.setFont(Font.font("Tahoma", FontWeight.NORMAL, 20));
     grid.add(scenetitle, 0, 0, 2, 1);

     Label userName = new Label("User Name:");
     grid.add(userName, 0, 1);

     TextField userTextField = new TextField();
     grid.add(userTextField, 1, 1);

     Label pw = new Label("Password:");
     grid.add(pw, 0, 2);

     PasswordField pwBox = new PasswordField();
     grid.add(pwBox, 1, 2);
     
}






public static void main(String[] args) {
launch(args);
}
    
}
