public class Move {
	public-init var pieceType: Integer;
	public-init var source: Integer;
	public-init var destination: Integer;

	public function equals(otherMove: Move): Boolean {
		var retval: Boolean = false;
		if(pieceType == otherMove.pieceType and
		   source == otherMove.source and
		   destination == otherMove.destination) {
			retval = true;
		}
		return retval;
	}
}
