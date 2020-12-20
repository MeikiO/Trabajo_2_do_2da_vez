
 
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
import javafx.scene.layout.HBox;
import javafx.scene.layout.StackPane;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.Text;
import javafx.stage.Stage;
 
public class Principal extends Application {
   
	GridPane grid;
	
	public static void main(String[] args) {
        launch(args);
    }
    
    @Override
    public void start(Stage primaryStage) {

            primaryStage.setTitle("Login page");
           
            
            Scene scene = new Scene(this.setBasePanel(), 300, 275); //tamaño del panel
            primaryStage.setScene(scene);
            
            
            this.contenido();
          
           
            
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

	
}