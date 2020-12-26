public class Pawn extends Piece {
	protected override var filename = "Pawn.fxz";

	postinit {
		if(isWhite) {
			type = PieceType.WPAWN;
		} else {
			type = PieceType.BPAWN;
		}
	}
}
