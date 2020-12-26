import java.lang.*;

public class Rook extends Piece {
	protected override var filename = "Rook.fxz";

	postinit {
		if(isWhite) {
			type = PieceType.WROOK;
		} else {
			type = PieceType.BROOK;
		}
	}
}
