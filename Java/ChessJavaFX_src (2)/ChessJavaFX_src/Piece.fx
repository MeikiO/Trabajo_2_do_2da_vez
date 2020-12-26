import javafx.fxd.*;
import javafx.scene.*;
import javafx.scene.input.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.transform.*;

public abstract class Piece {
	public-init var gameGUI: GameGUI;
	public-init var board: Board;
	public-init var isWhite: Boolean;
	protected var filename: String = "";
	public var location: Coord;

	// the graphics for this piece
	public-read var pieceNode: Node;
	public-read var activePieceNode: Node;

	public var type: Integer;

	var group: Group;

	def rootDir = "{__DIR__}".replaceAll("%20", " ");

	var movingPiece: Boolean = false;

	var highlightedSquare: Coord = null;
	var squareHighlight: Rectangle = null;

	// custom cursors
	def grabCursor: CustomCursor = CustomCursor {
		imageURL: "{rootDir}res/grab.png"
		cursorName: "Grab"
	}
	def grabbingCursor: CustomCursor = CustomCursor {
		imageURL: "{rootDir}res/grabbing.png"
		cursorName: "Grabbing"
	}

	postinit {
		if (isWhite) {
			if(type == PieceType.WPAWN) {
				filename = "Pawn.fxz";
			} else if(type == PieceType.WKNIGHT) {
				filename = "Knight.fxz";
			} else if(type == PieceType.WBISHOP) {
				filename = "Bishop.fxz";
			} else if(type == PieceType.WROOK) {
				filename = "Rook.fxz";
			} else if(type == PieceType.WQUEEN) {
				filename = "Queen.fxz";
			} else if(type == PieceType.WKING) {
				filename = "King.fxz";
			}

			//pieceNode = FXDLoader.load("{__DIR__}res/W{filename}");
			pieceNode = FXDLoader.load("{rootDir}res/W{filename}");
			activePieceNode = FXDLoader.load("{rootDir}res/AGW{filename}");
		} else {
			if(type == PieceType.BPAWN) {
				filename = "Pawn.fxz";
			} else if(type == PieceType.BKNIGHT) {
				filename = "Knight.fxz";
			} else if(type == PieceType.BBISHOP) {
				filename = "Bishop.fxz";
			} else if(type == PieceType.BROOK) {
				filename = "Rook.fxz";
			} else if(type == PieceType.BQUEEN) {
				filename = "Queen.fxz";
			} else if(type == PieceType.BKING) {
				filename = "King.fxz";
			}

			pieceNode = FXDLoader.load("{rootDir}res/B{filename}");
			activePieceNode = FXDLoader.load("{rootDir}res/ARB{filename}");
		}

		def pieceHeight = pieceNode.boundsInLocal.height;
		def pieceWidth = pieceNode.boundsInLocal.width;

		// we use these to center the piece properly in the square
		var scaledHeight = bind board.scale * pieceHeight;
		var scaledWidth = bind board.scale * pieceWidth;
		var pieceXOffset = bind (board.squareSize - scaledWidth) / 2;
		var pieceYOffset = bind (board.squareSize - scaledHeight) / 2;

		// figure out the position of the piece on the board
		// 1, 1 is the upper left square of the board, 8, 8 the lower right square
		var xSquare = bind (location.getArrayIndex() mod 8) + 1;
		var ySquare = bind (location.getArrayIndex() / 8) + 1;

		var xCoord = bind board.xOffset + pieceXOffset + xSquare * board.squareSize;
		var yCoord = bind board.yOffset + pieceYOffset + ySquare * board.squareSize;

		var currentCursor = Cursor.DEFAULT;

		var dragXOffset: Number = 0;
		var dragYOffset: Number = 0;

		var myMove = bind (isWhite and gameGUI.gameController.game.isWhitesMove and gameGUI.gameController.humanIsWhite) or (not isWhite and not gameGUI.gameController.game.isWhitesMove and not gameGUI.gameController.humanIsWhite);

		var kingGroup = Group {
			var i: Integer = bind location.getArrayIndex()
			translateX: bind xCoord + dragXOffset
			translateY: bind yCoord + dragYOffset
			transforms: bind Transform.scale(board.scale, board.scale);
			content: [
				pieceNode
			]
			//effect: Reflection { fraction: 0.8, topOpacity: 0.5, topOffset: 2.5 }
			cursor: bind currentCursor
			onMousePressed: function(e: MouseEvent) {
				if(myMove) {
					delete pieceNode from group.content;
					insert activePieceNode into group.content;
					currentCursor = grabbingCursor;
					board.cursor = currentCursor;
				}
			}
			onMouseReleased: function(e: MouseEvent) {
				if(myMove) {
					delete activePieceNode from group.content;
					insert pieceNode into group.content;
					currentCursor = Cursor.DEFAULT;
					//currentCursor = grabCursor;
					board.cursor = currentCursor;
					dragXOffset = 0;
					dragYOffset = 0;
					if(movingPiece) {
						var dropLocation = findDropLocation(e);
						gameGUI.tryMakeMove(this, location, dropLocation);
					}
					if(highlightedSquare != null) {
						delete squareHighlight from board.content;
						highlightedSquare = null;
						squareHighlight = null;
					}
				}
				movingPiece = false;
			}
			onMouseDragged: function(e: MouseEvent) {
				if(myMove) {
					// highlight the square that the piece is over
					var dropLocation = findDropLocation(e);
					// these 2 calls are required to make the piece
					// being dragged appear on top of the other pieces
					removePieceFromBoard();
					addPieceToBoard();
					dragXOffset = e.dragX;
					dragYOffset = e.dragY;
					movingPiece = true;
					if(highlightedSquare == null) {
						highlightedSquare = findDropLocation(e);
						if(highlightedSquare != Coord.OFF_BOARD) {
							squareHighlight = Rectangle {
								var i = highlightedSquare.getArrayIndex();
								x: bind board.xOffset + ((i mod 8) + 1) * board.squareSize
								y: bind board.yOffset + ((i / 8) + 1) * board.squareSize
								width: bind board.squareSize
								height: bind board.squareSize
								stroke: Color.BLACK
								strokeWidth: 3
								// make the fill color be completely transparent
								fill: Color.color(0, 0, 0, 0)
							};
							insert squareHighlight into board.content;
							// always show the piece over the square highlight
							removePieceFromBoard();
							addPieceToBoard();
						}
					} else {
						var location = findDropLocation(e);
						if(highlightedSquare != location) {
							if(highlightedSquare != Coord.OFF_BOARD) {
								delete squareHighlight from board.content;
							}
							highlightedSquare = location;
							if(highlightedSquare != Coord.OFF_BOARD) {
								squareHighlight = Rectangle {
									var i = highlightedSquare.getArrayIndex();
									x: bind board.xOffset + ((i mod 8) + 1) * board.squareSize
									y: bind board.yOffset + ((i / 8) + 1) * board.squareSize
									width: bind board.squareSize
									height: bind board.squareSize
									stroke: Color.BLACK
									strokeWidth: 3
									// make the fill color be completely transparent
									fill: Color.color(0, 0, 0, 0)
								};
								insert squareHighlight into board.content;
								// always show the piece over the square highlight
								removePieceFromBoard();
								addPieceToBoard();
							}
						}
					}
				}
			}
			onMouseEntered: function(e: MouseEvent) {
				if(myMove and not e.primaryButtonDown) {
					delete pieceNode from group.content;
					insert activePieceNode into group.content;
					currentCursor = grabCursor;
					board.cursor = currentCursor;
				}
			}
			onMouseExited: function(e: MouseEvent) {
				if(myMove and not e.primaryButtonDown) {
					delete activePieceNode from group.content;
					insert pieceNode into group.content;
					currentCursor = Cursor.DEFAULT;
					board.cursor = currentCursor;
				}
			}
		}
		group = kingGroup;

		addPieceToBoard();
	}

	public function addPieceToBoard() {
		insert group into board.content;
	}

	public function removePieceFromBoard() {
		delete group from board.content;
	}

	public function findDropLocation(e: MouseEvent): Coord {
		var xCoord = (e.sceneX - board.xOffset - board.squareSize) / board.squareSize;
		var yCoord = (e.sceneY - board.yOffset - board.squareSize) / board.squareSize;
		if(xCoord < 0) {
			Coord.OFF_BOARD
		} else if(xCoord < 1) {
			if(yCoord < 0) {
				Coord.OFF_BOARD
			} else if(yCoord < 1) {
				Coord.A8
			} else if(yCoord < 2) {
				Coord.A7
			} else if(yCoord < 3) {
				Coord.A6
			} else if(yCoord < 4) {
				Coord.A5
			} else if(yCoord < 5) {
				Coord.A4
			} else if(yCoord < 6) {
				Coord.A3
			} else if(yCoord < 7) {
				Coord.A2
			} else if(yCoord < 8) {
				Coord.A1
			} else {
				Coord.OFF_BOARD
			}
		} else if(xCoord < 2) {
			if(yCoord < 0) {
				Coord.OFF_BOARD
			} else if(yCoord < 1) {
				Coord.B8
			} else if(yCoord < 2) {
				Coord.B7
			} else if(yCoord < 3) {
				Coord.B6
			} else if(yCoord < 4) {
				Coord.B5
			} else if(yCoord < 5) {
				Coord.B4
			} else if(yCoord < 6) {
				Coord.B3
			} else if(yCoord < 7) {
				Coord.B2
			} else if(yCoord < 8) {
				Coord.B1
			} else {
				Coord.OFF_BOARD
			}
		} else if(xCoord < 3) {
			if(yCoord < 0) {
				Coord.OFF_BOARD
			} else if(yCoord < 1) {
				Coord.C8
			} else if(yCoord < 2) {
				Coord.C7
			} else if(yCoord < 3) {
				Coord.C6
			} else if(yCoord < 4) {
				Coord.C5
			} else if(yCoord < 5) {
				Coord.C4
			} else if(yCoord < 6) {
				Coord.C3
			} else if(yCoord < 7) {
				Coord.C2
			} else if(yCoord < 8) {
				Coord.C1
			} else {
				Coord.OFF_BOARD
			}
		} else if(xCoord < 4) {
			if(yCoord < 0) {
				Coord.OFF_BOARD
			} else if(yCoord < 1) {
				Coord.D8
			} else if(yCoord < 2) {
				Coord.D7
			} else if(yCoord < 3) {
				Coord.D6
			} else if(yCoord < 4) {
				Coord.D5
			} else if(yCoord < 5) {
				Coord.D4
			} else if(yCoord < 6) {
				Coord.D3
			} else if(yCoord < 7) {
				Coord.D2
			} else if(yCoord < 8) {
				Coord.D1
			} else {
				Coord.OFF_BOARD
			}
		} else if(xCoord < 5) {
			if(yCoord < 0) {
				Coord.OFF_BOARD
			} else if(yCoord < 1) {
				Coord.E8
			} else if(yCoord < 2) {
				Coord.E7
			} else if(yCoord < 3) {
				Coord.E6
			} else if(yCoord < 4) {
				Coord.E5
			} else if(yCoord < 5) {
				Coord.E4
			} else if(yCoord < 6) {
				Coord.E3
			} else if(yCoord < 7) {
				Coord.E2
			} else if(yCoord < 8) {
				Coord.E1
			} else {
				Coord.OFF_BOARD
			}
		} else if(xCoord < 6) {
			if(yCoord < 0) {
				Coord.OFF_BOARD
			} else if(yCoord < 1) {
				Coord.F8
			} else if(yCoord < 2) {
				Coord.F7
			} else if(yCoord < 3) {
				Coord.F6
			} else if(yCoord < 4) {
				Coord.F5
			} else if(yCoord < 5) {
				Coord.F4
			} else if(yCoord < 6) {
				Coord.F3
			} else if(yCoord < 7) {
				Coord.F2
			} else if(yCoord < 8) {
				Coord.F1
			} else {
				Coord.OFF_BOARD
			}
		} else if(xCoord < 7) {
			if(yCoord < 0) {
				Coord.OFF_BOARD
			} else if(yCoord < 1) {
				Coord.G8
			} else if(yCoord < 2) {
				Coord.G7
			} else if(yCoord < 3) {
				Coord.G6
			} else if(yCoord < 4) {
				Coord.G5
			} else if(yCoord < 5) {
				Coord.G4
			} else if(yCoord < 6) {
				Coord.G3
			} else if(yCoord < 7) {
				Coord.G2
			} else if(yCoord < 8) {
				Coord.G1
			} else {
				Coord.OFF_BOARD
			}
		} else if(xCoord < 8) {
			if(yCoord < 0) {
				Coord.OFF_BOARD
			} else if(yCoord < 1) {
				Coord.H8
			} else if(yCoord < 2) {
				Coord.H7
			} else if(yCoord < 3) {
				Coord.H6
			} else if(yCoord < 4) {
				Coord.H5
			} else if(yCoord < 5) {
				Coord.H4
			} else if(yCoord < 6) {
				Coord.H3
			} else if(yCoord < 7) {
				Coord.H2
			} else if(yCoord < 8) {
				Coord.H1
			} else {
				Coord.OFF_BOARD
			}
		} else {
			Coord.OFF_BOARD
		}
	}
}
