import java.lang.*;

public class Queen extends Piece {
	protected override var filename = "Queen.fxz";

	postinit {
		if(isWhite) {
			type = PieceType.WQUEEN;
		} else {
			type = PieceType.BQUEEN;
		}
	}
}
