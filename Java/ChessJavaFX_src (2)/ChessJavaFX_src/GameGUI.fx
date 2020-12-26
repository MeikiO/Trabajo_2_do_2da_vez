import java.lang.*;
import javax.swing.*;

public class GameGUI {
	public-init var board: Board;
	public-read var whitePieces: Piece[];
	public-read var blackPieces: Piece[];
	public-read var gameController: GameController;

	postinit {
		gameController = GameController {
			gui: this;
		};
		newGame();
	}

	public function newGame(): Void {
		whitePieces = [];
		insert Pawn { gameGUI: this, board: board, isWhite: true, location: Coord.A2 } into whitePieces;
		insert Pawn { gameGUI: this, board: board, isWhite: true, location: Coord.B2 } into whitePieces;
		insert Pawn { gameGUI: this, board: board, isWhite: true, location: Coord.C2 } into whitePieces;
		insert Pawn { gameGUI: this, board: board, isWhite: true, location: Coord.D2 } into whitePieces;
		insert Pawn { gameGUI: this, board: board, isWhite: true, location: Coord.E2 } into whitePieces;
		insert Pawn { gameGUI: this, board: board, isWhite: true, location: Coord.F2 } into whitePieces;
		insert Pawn { gameGUI: this, board: board, isWhite: true, location: Coord.G2 } into whitePieces;
		insert Pawn { gameGUI: this, board: board, isWhite: true, location: Coord.H2 } into whitePieces;
		insert Rook { gameGUI: this, board: board, isWhite: true, location: Coord.A1 } into whitePieces;
		insert Knight { gameGUI: this, board: board, isWhite: true, location: Coord.B1 } into whitePieces;
		insert Bishop { gameGUI: this, board: board, isWhite: true, location: Coord.C1 } into whitePieces;
		insert Queen { gameGUI: this, board: board, isWhite: true, location: Coord.D1 } into whitePieces;
		insert King { gameGUI: this, board: board, isWhite: true, location: Coord.E1 } into whitePieces;
		insert Bishop { gameGUI: this, board: board, isWhite: true, location: Coord.F1 } into whitePieces;
		insert Knight { gameGUI: this, board: board, isWhite: true, location: Coord.G1 } into whitePieces;
		insert Rook { gameGUI: this, board: board, isWhite: true, location: Coord.H1 } into whitePieces;

		blackPieces = [];
		insert Rook { gameGUI: this, board: board, isWhite: false, location: Coord.A8 } into blackPieces;
		insert Knight { gameGUI: this, board: board, isWhite: false, location: Coord.B8 } into blackPieces;
		insert Bishop { gameGUI: this, board: board, isWhite: false, location: Coord.C8 } into blackPieces;
		insert Queen { gameGUI: this, board: board, isWhite: false, location: Coord.D8 } into blackPieces;
		insert King { gameGUI: this, board: board, isWhite: false, location: Coord.E8 } into blackPieces;
		insert Bishop { gameGUI: this, board: board, isWhite: false, location: Coord.F8 } into blackPieces;
		insert Knight { gameGUI: this, board: board, isWhite: false, location: Coord.G8 } into blackPieces;
		insert Rook { gameGUI: this, board: board, isWhite: false, location: Coord.H8 } into blackPieces;
		insert Pawn { gameGUI: this, board: board, isWhite: false, location: Coord.A7 } into blackPieces;
		insert Pawn { gameGUI: this, board: board, isWhite: false, location: Coord.B7 } into blackPieces;
		insert Pawn { gameGUI: this, board: board, isWhite: false, location: Coord.C7 } into blackPieces;
		insert Pawn { gameGUI: this, board: board, isWhite: false, location: Coord.D7 } into blackPieces;
		insert Pawn { gameGUI: this, board: board, isWhite: false, location: Coord.E7 } into blackPieces;
		insert Pawn { gameGUI: this, board: board, isWhite: false, location: Coord.F7 } into blackPieces;
		insert Pawn { gameGUI: this, board: board, isWhite: false, location: Coord.G7 } into blackPieces;
		insert Pawn { gameGUI: this, board: board, isWhite: false, location: Coord.H7 } into blackPieces;

		gameController.newGame();
	}

	public function restartGame(): Void {
		for(piece in whitePieces) {
			piece.removePieceFromBoard();
		}
		for(piece in blackPieces) {
			piece.removePieceFromBoard();
		}
		newGame();
	}

	public function tryMakeMove(movingPiece: Piece, source: Coord, destination: Coord): Void {
		def sourceIndex: Integer = source.getArrayIndex();
		def destinationIndex: Integer = destination.getArrayIndex();

		// check if the move is valid
		var move: Move = null;
		for(m in gameController.game.validMoves) {
			if(m.source == sourceIndex and m.destination == destinationIndex) {
				move = m;
				break;
			}
		}

		// if the move is valid make the move
		if(move != null) {
			if(gameController.game.isWhitesMove) {
				var blackPieceEaten: Boolean = false;
				// if a black piece was eaten remove it from the board
				for(piece in blackPieces) {
					if(piece.location == destination) {
						piece.removePieceFromBoard();
						delete blackPieces[indexof piece];
						blackPieceEaten = true;
						break;
					}
				}
				for(piece in whitePieces) {
					if(piece == movingPiece) {
						if(piece instanceof Pawn) {
							// check for en passant
							if(not blackPieceEaten) {
								if(move.destination == move.source - 7) {
									for(p in blackPieces) {
										if(p.location.getArrayIndex() == move.source + 1) {
											p.removePieceFromBoard();
											delete blackPieces[indexof p];
											break;
										}
									}
								} else if(move.destination == move.source - 9) {
									for(p in blackPieces) {
										if(p.location.getArrayIndex() == move.source - 1) {
											p.removePieceFromBoard();
											delete blackPieces[indexof p];
											break;
										}
									}
								}
							}
						} else if(piece instanceof King) {
							// if the move was a castle
							if(Math.abs(move.source - move.destination) == 2) {
								if(move.destination == Coord.G1.getArrayIndex()) {
									for(p in whitePieces) {
										if(p.location == Coord.H1) {
											// move the rook
											p.location = Coord.F1;
										}
									}
								} else {
									for(p in whitePieces) {
										if(p.location == Coord.A1) {
											// move the rook
											p.location == Coord.D1;
										}
									}
								}
							}
						}
						break;
					}
				}
			} else {  // if(gameController.game.isWhitesMove)
				var whitePieceEaten: Boolean = false;
				// if a white piece was eaten remove it from the board
				for(piece in whitePieces) {
					if(piece.location == destination) {
						piece.removePieceFromBoard();
						delete whitePieces[indexof piece];
						whitePieceEaten = true;
						break;
					}
				}
				for(piece in blackPieces) {
					if(piece == movingPiece) {
						if(piece instanceof Pawn) {
							// check for en passant
							if(not whitePieceEaten) {
								if(move.destination == move.source + 7) {
									for(p in whitePieces) {
										if(p.location.getArrayIndex() == move.source - 1) {
											p.removePieceFromBoard();
											delete whitePieces[indexof p];
											break;
										}
									}
								} else if(move.destination == move.source + 9) {
									for(p in whitePieces) {
										if(p.location.getArrayIndex() == move.source + 1) {
											p.removePieceFromBoard();
											delete whitePieces[indexof p];
											break;
										}
									}
								}
							}
						} else if(piece instanceof King) {
							// if the move was a castle
							if(Math.abs(move.source - move.destination) == 2) {
								if(move.destination == Coord.G8.getArrayIndex()) {
									for(p in blackPieces) {
										if(p.location == Coord.H8) {
											// move the rook
											p.location = Coord.F8;
										}
									}
								} else {
									for(p in blackPieces) {
										if(p.location == Coord.A8) {
											// move the rook
											p.location == Coord.D8;
										}
									}
								}
							}
						}
						break;
					}
				}
			}

			// move the piece
			movingPiece.location = destination;

			// not sure if this call is necessary
			gameController.findValidMoves();
			// make the move in the game controller
			def sourcePieceType = gameController.game.gameArray[sourceIndex];
			gameController.makeMove(move);
			def destinationPieceType = gameController.game.gameArray[destinationIndex];
			// check if a pawn was promoted
			if(sourcePieceType != destinationPieceType) {
				if(gameController.game.isWhitesMove) {
					// remove the old pawn
					for(piece in whitePieces) {
						if(piece == movingPiece) {
							piece.removePieceFromBoard();
							delete whitePieces[indexof piece];
							break;
						}
					}
					// add the new piece
					if(destinationPieceType == gameController.WQUEEN) {
						insert Queen { gameGUI: this, board: board, isWhite: true, location: destination } into whitePieces;
					} else if(destinationPieceType == gameController.WROOK) {
						insert Rook { gameGUI: this, board: board, isWhite: true, location: destination } into whitePieces;
					} else if(destinationPieceType == gameController.WBISHOP) {
						insert Bishop { gameGUI: this, board: board, isWhite: true, location: destination } into whitePieces;
					} else if(destinationPieceType == gameController.WKNIGHT) {
						insert Knight { gameGUI: this, board: board, isWhite: true, location: destination } into whitePieces;
					}
				} else {
					// remove the old pawn
					for(piece in blackPieces) {
						if(piece == movingPiece) {
							piece.removePieceFromBoard();
							delete blackPieces[indexof piece];
							break;
						}
					}
					// add the new piece
					if(destinationPieceType == gameController.BQUEEN) {
						insert Queen { gameGUI: this, board: board, isWhite: false, location: destination } into blackPieces;
					} else if(destinationPieceType == gameController.BROOK) {
						insert Rook { gameGUI: this, board: board, isWhite: false, location: destination } into blackPieces;
					} else if(destinationPieceType == gameController.BBISHOP) {
						insert Bishop { gameGUI: this, board: board, isWhite: false, location: destination } into blackPieces;
					} else if(destinationPieceType == gameController.BKNIGHT) {
						insert Knight { gameGUI: this, board: board, isWhite: false, location: destination } into blackPieces;
					}
				}
			}
			gameController.findValidMoves();
			if(gameController.isGameOver) {
				restartGame();
			}
		}
	}
}
