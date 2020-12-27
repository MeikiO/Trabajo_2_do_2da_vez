
import chesspresso.game.GameModelChangeListener;
import chesspresso.Chess;
import chesspresso.game.Game;
import chesspresso.game.GameHeaderModel;
import chesspresso.game.GameMoveModel;
import chesspresso.move.Move;

public class MiGestorDePartida implements GameModelChangeListener {

    private PantallaDondeMostrarLaPartida pantallaGrafica;
    int i=0;

    
    public MiGestorDePartida(PantallaDondeMostrarLaPartida pantalla) {
        this.pantallaGrafica = pantalla;
      
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
        pantallaGrafica.setInformacion(texto);
    }

    
}
