package ajedrez;

import chesspresso.game.GameModelChangeListener;
import chesspresso.game.Game;
import chesspresso.game.GameHeaderModel;
import chesspresso.game.GameMoveModel;
import chesspresso.move.Move;

public class GestorDePartida implements GameModelChangeListener {

    private InterfazFxParaJugar pantallaGrafica;
    
    
    public GestorDePartida(InterfazFxParaJugar pantalla) {
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

        Move ultimo = game.getLastMove();
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
