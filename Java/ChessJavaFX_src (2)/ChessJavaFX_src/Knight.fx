public class Knight extends Piece {
	protected override var filename = "Knight.fxz";

	postinit {
		if(isWhite) {
			type = PieceType.WKNIGHT;
		} else {
			type = PieceType.BKNIGHT;
		}
	}
}
