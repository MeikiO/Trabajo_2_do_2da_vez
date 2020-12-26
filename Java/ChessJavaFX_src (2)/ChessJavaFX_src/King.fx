public class King extends Piece {
	protected override var filename = "King.fxz";

	postinit {
		if(isWhite) {
			type = PieceType.WKING;
		} else {
			type = PieceType.BKING;
		}
	}
}
