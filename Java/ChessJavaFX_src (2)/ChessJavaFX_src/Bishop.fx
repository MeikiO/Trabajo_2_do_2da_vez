public class Bishop extends Piece {
	protected override var filename = "Bishop.fxz";

	postinit {
		if(isWhite) {
			type = PieceType.WBISHOP;
		} else {
			type = PieceType.BBISHOP;
		}
	}
}
