import java.util.*;

public class ComputerAI {
	public-init var controller: GameController;
	public-init var gui: GameGUI;
	def rand: Random = new Random();
	//def rand: Random = new Random(1);
	def coordValues: Coord[] = Coord.values();

	public function move(): Void {
		controller.findValidMoves();
		def moveIndex: Integer = rand.nextInt(sizeof controller.game.validMoves);
		def move: Move = controller.game.validMoves[moveIndex];
		def source = findCoordForLocation(move.source);
		def destination = findCoordForLocation(move.destination);
		if(controller.game.isWhitesMove) {
			for(piece: Piece in gui.whitePieces) {
				if(piece.location == source) {
					gui.tryMakeMove(piece, source, destination);
					break;
				}
			}
		} else {
			for(piece: Piece in gui.blackPieces) {
				if(piece.location == source) {
					gui.tryMakeMove(piece, source, destination);
					break;
				}
			}
		}
	}

	public function findCoordForLocation(integerLocation: Integer): Coord {
		var retval: Coord = Coord.OFF_BOARD;
		for(coord: Coord in coordValues) {
			if(coord.getArrayIndex() == integerLocation) {
				retval = coord;
				break;
			}
		}
		return retval;
	}
}
