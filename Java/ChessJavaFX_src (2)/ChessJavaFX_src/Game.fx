public class Game {
	public var isWhitesMove: Boolean;
	public var canWhiteCastleKingSide: Boolean;
	public var canWhiteCastleQueenSide: Boolean;
	public var canBlackCastleKingSide: Boolean;
	public var canBlackCastleQueenSide: Boolean;
	public var gameArray: Integer[] = [0..63];
	public var numWhitePieces: Integer;
	public var whitePieceLocations: Integer[] = [0..15];
	public var numBlackPieces: Integer;
	public var blackPieceLocations: Integer[] = [0..15];
	public var moveList: Move[];
	public var validMoves: Move[] = null;
}
