
import chesspresso.game.GameModelChangeListener;
import chesspresso.Chess;
import chesspresso.game.Game;
import chesspresso.game.GameHeaderModel;
import chesspresso.game.GameMoveModel;
import chesspresso.move.Move;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.control.TextField;
import javafx.scene.paint.Color;

public class MiGestorDePartida implements GameModelChangeListener {

    private TextField informacion;
    private GraphicsContext gc;
    int i=0;

    
    public MiGestorDePartida(TextField informacion, GraphicsContext gc) {
        this.informacion = informacion;
        this.gc=gc;
    }
   
    @Override
    public void headerModelChanged(Game game) {
        System.out.println(game.getHeaderString(0) + game.getHeaderString(1));

        GameHeaderModel cabecera = game.getModel().getHeaderModel();
        
        System.out.println("El jugador con negras es " + cabecera.getBlack() + " con ELO " + cabecera.getBlackEloStr());
        System.out.println("El jugador con blancas es " + cabecera.getWhite() + " con ELO " + cabecera.getWhiteEloStr());
        System.out.println("Estamos jugando el torneo  " + cabecera.getEvent() + " en la ciudad de " + cabecera.getSite());
    }

    
    @Override
    public void moveModelChanged(Game game) {
        System.out.println("[" + game.getCurrentMoveNumber() + " -- " + game.getCurNode() + "]");

      
        
        GameMoveModel movimientos = game.getModel().getMoveModel();
        short ultimoMovimiento = movimientos.getMove(game.getCurNode());

        String texto = "El último movimiento ha sido " + Move.getString(ultimoMovimiento);
        System.out.println(texto);
        
    

        Move ultimo= game.getLastMove(); //cogemos el ultimo moviento
        ultimo.isWhiteMove(); //miramos si es blanco
        
        if(ultimo.isWhiteMove()) {
            texto = texto + " y lo han movido las blancas";
        }
        else {
        	 texto = texto + " y lo han movido las negras";
        }
        
      
        System.out.println(texto);
        informacion.setText(texto);
        
        
        LineaSerie enviador=new LineaSerie();
        String leido=enviador.leer();
        System.out.print(leido);
        
        this.dibujar_canvas(leido);
        
        
    }
    
    public void dibujar_canvas(String caracter) {
    	
    	gc.setFill(Color.WHITE);
 	    gc.fillRoundRect(0,0, 60, 30, 0, 0);
    	
    	
    	    switch (caracter) {
			case "i":
			{
			    gc.setFill(Color.GREEN);
	    	    gc.fillRoundRect(0,0, 30, 30, 0, 0);
	    	    
	    	    gc.setStroke(Color.GREEN);
	    	    // Dibujar un rectángulo vacio
	    	    gc.strokeRoundRect(30, 0, 30, 30, 10, 10);
				break;
			}
			case "d":
			{   
				gc.setStroke(Color.GREEN);
	    	    // Dibujar un rectángulo vacio
	    	    gc.strokeRoundRect(0, 0, 30, 30, 10, 10);
	    	    
	    	    
			    gc.setFill(Color.GREEN);
	    	    gc.fillRoundRect(30,0, 30, 30, 0, 0);
	    	    
				break;
			}	
			case "g":
			{
			    gc.setFill(Color.RED);
	    	    gc.fillRoundRect(0,0, 30, 30, 0, 0);
	    	    
	    	    gc.setStroke(Color.RED);
	    	    // Dibujar un rectángulo vacio
	    	    gc.strokeRoundRect(30, 0, 30, 30, 10, 10);
				break;
			}
			case "h":
			{
				gc.setStroke(Color.RED);
	    	    // Dibujar un rectángulo vacio
	    	    gc.strokeRoundRect(0, 0, 30, 30, 10, 10);
	    	    
	    	    
			    gc.setFill(Color.RED);
	    	    gc.fillRoundRect(30,0, 30, 30, 0, 0);
				break;
			}

			default:{
		 	    gc.setStroke(Color.GREEN);
	    	    // Dibujar un rectángulo vacio
		 	   gc.strokeRoundRect(0, 0, 30, 30, 10, 10);
	    	    gc.strokeRoundRect(30, 0, 30, 30, 10, 10);
				
				break;
			}
				
			}
    	
    	
    }
    
}
