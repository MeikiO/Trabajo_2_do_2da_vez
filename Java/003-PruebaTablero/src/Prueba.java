
import chesspresso.Chess;
import chesspresso.game.Game;
import chesspresso.game.view.GameBrowser;
import chesspresso.position.Position;
import chesspresso.move.Move;
import chesspresso.pgn.PGN;
import chesspresso.move.IllegalMoveException;
 
public class Prueba{
 
    static Position position;
    static String[] game;
     
    static final int MAX_PLY = 9;
 
    // Don't bother handling exceptions.
    public static void main(String[] args) throws Exception{
        // The initial position.
        position = Position.createInitialPosition();
 
        // Array of moves.
        game = new String[MAX_PLY + 1];
 
        // First move: e4.
        // Boolean input (third parameter) describes whether it's a capture.
        short firstmove = Move.getRegularMove(Chess.E2, Chess.E4, false);
 
        // Alter the position by making this move.
        position.doMove(firstmove);
 
        recurse();
    }
 
    // All the data is mutable and therefore is stored globally.
    // Calling this method should not change the state of the position
    // since any changes are eventually undone.
    static void recurse() throws IllegalMoveException {
        int ply = position.getPlyNumber();
        Move lastMove = position.getLastMove();
 
        // Record move.
        game[ply-1] = lastMove.getSAN();
 
        if(ply > MAX_PLY){
 
            // Check if we've found a position where a black knight captures
            // a white rook with checkmate on the fifth move.
            if(position.isMate() && lastMove.isCapturing()
                && lastMove.getMovingPiece() == Chess.KNIGHT
                && position.getPiece(lastMove.getToSqi()) == Chess.ROOK){
 
                // We found it, now print the sequence of moves.
                for(int i=0; i<ply; i++)
                    System.out.println(game[i]);
                System.out.println();
            }
            return;
        }
 
        // Recurse all the possible next positions.
        short[] nextMoves = position.getAllMoves();
 
        for(short thisMove : nextMoves){
            // Make the move, recurse, and undo the move.
            position.doMove(thisMove);
            recurse();
            position.undoMove();
        }
    }
    
    private Game setupChesspressoGame() {
        Game cpg = new Game();

       Move move=new Move((short) 0, 0, 0, 0, false, false, false);
       
       Chess ce;
       
       GameBrowser g=new GameBrowser(cpg);
       
       g.show(true);
       
      
       
        // seven tag roster
        cpg.setTag(PGN.TAG_EVENT, getName());
        cpg.setTag(PGN.TAG_SITE, site);
        cpg.setTag(PGN.TAG_DATE, ChessUtils.dateToPGNDate(created));
        cpg.setTag(PGN.TAG_ROUND, "?");
        cpg.setTag(PGN.TAG_WHITE, getPlayerId(Chess.WHITE));
        cpg.setTag(PGN.TAG_BLACK, getPlayerId(Chess.BLACK));
        cpg.setTag(PGN.TAG_RESULT, getPGNResult());
        // extra tags
        cpg.setTag(PGN.TAG_FEN, Position.createInitialPosition().getFEN());
        return cpg;
    }
    
}