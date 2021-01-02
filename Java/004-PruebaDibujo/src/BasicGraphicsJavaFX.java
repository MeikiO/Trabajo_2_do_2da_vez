
import javafx.application.Application;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

public class BasicGraphicsJavaFX extends Application {
    
    @Override
    public void start(Stage primaryStage) {
       
        /* CREACIÓN DE LA VENTANA Y DE LOS CONTENEDORES PRINCIPALES */
        
        // Contenedor principal donde se alojarán todos los elementos
        Group root = new Group();  
        
        // Creación de una zona de dibujo (canvas) de 200 x 150 puntos
        Canvas canvas = new Canvas(60, 30);
        
        
        
        // Obtención del contexto gráfico del canvas anterior que permitirá
        //  realizar posteriormente los dibujos
        GraphicsContext gc = canvas.getGraphicsContext2D();
        
        
        
        // Se añade el canvas al contenedor principal (root)
        root.getChildren().add(canvas);
        
        
        // Creación del área (scene) correspondiente al contenido que tendrá la 
        //  ventana, de 600 x 400 puntos, con color gris claro, indicando que el
        //  elemento root va a ser el contenedor principal de este espacio
        Scene scene = new Scene(root, 600, 400, Color.LIGHTGRAY);
        // Se asocia la ventana (scene) al parámetro primaryStage (escenario
        //  principal). El parámetro primaryStage se recibe en este método start
        primaryStage.setScene(scene);
        // Título que se aparecerá en la ventana
        primaryStage.setTitle("Dibujando formas con JavaFX");
        // Orden para que se muestre la ventana        
        primaryStage.show();

        /* DIBUJO DE LAS FORMAS */
        
        /* Se utiliza el objeto gc (GraphicsContext) que se ha obtenido
            anteriormente a partir del canvas de se ha creado */
        
  


        // Dibujar un rectángulo con bordes redondeados a partir de la posición
        //  (110,60) de ancho 30, alto 30, radio de bordes con ancho 10 y alto 10 
        
        gc.setFill(Color.GREEN);
        
        gc.fillRoundRect(0,0, 30, 30, 0, 0);
       gc.setStroke(Color.GREEN);
        // Dibujar un rectángulo vacio
        gc.strokeRoundRect(30, 0, 30, 30, 10, 10);
        
        /* MÁS INFORMACIÓN
        
        En la API de JavaFX de la clase GraphicsContext se puede encontrar 
            más información sobre las distintas formas que se pueden dibujar
            http://docs.oracle.com/javase/8/javafx/api/javafx/scene/canvas/GraphicsContext.html
        
        Más información también en el artículo "Working with Canvas":
            http://docs.oracle.com/javafx/2/canvas/jfxpub-canvas.htm
        */
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }
    
}