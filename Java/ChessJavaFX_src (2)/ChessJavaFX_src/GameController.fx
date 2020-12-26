import java.lang.*;
import javax.swing.*;

public class GameController {
	public-init var gui: GameGUI;
	public-read var game: Game;
	public-read var isGameOver: Boolean;
	public-read var humanIsWhite: Boolean;
	var computerAI: ComputerAI;

	public def EMPTY_SQUARE = 0;
	public def WPAWN = 1;
	public def WKNIGHT = 2;
	public def WBISHOP = 3;
	public def WROOK = 4;
	public def WQUEEN = 5;
	public def WKING = 6;
	public def BPAWN = -1;
	public def BKNIGHT = -2;
	public def BBISHOP = -3;
	public def BROOK = -4;
	public def BQUEEN = -5;
	public def BKING = -6;

	public def DRAW = 0;
	public def WHITE_WINS = 1;
	public def BLACK_WINS = -1;

	postinit {
		computerAI = ComputerAI {
			gui: this.gui;
			controller: this;
		}
	}

	public function newGame(): Void {
		def options: Object[] = [ "White", "Black" ];
		def choice: Integer = JOptionPane.showOptionDialog(null,
		                                                   "Do you want to play as White or Black?",
		                                                   "Select Your Color",
		                                                   JOptionPane.YES_NO_OPTION,
		                                                   JOptionPane.QUESTION_MESSAGE,
		                                                   null,
		                                                   options,
		                                                   options[0]);
		if(choice == 1) {
			humanIsWhite = false;
		} else {
			humanIsWhite = true;
		}
		game = Game {
			isWhitesMove: true;
			canWhiteCastleKingSide: true;
			canWhiteCastleQueenSide: true;
			canBlackCastleKingSide: true;
			canBlackCastleQueenSide: true;
		}

		game.gameArray[0] = BROOK;
		game.gameArray[1] = BKNIGHT;
		game.gameArray[2] = BBISHOP;
		game.gameArray[3] = BQUEEN;
		game.gameArray[4] = BKING;
		game.gameArray[5] = BBISHOP;
		game.gameArray[6] = BKNIGHT;
		game.gameArray[7] = BROOK;

		for(i in [0..7]) {
			game.gameArray[8+i] = BPAWN;
		}

		for(i in [0..31]) {
			game.gameArray[16+i] = EMPTY_SQUARE;
		}

		for(i in [0..7]) {
			game.gameArray[48+i] = WPAWN;
		}

		game.gameArray[56] = WROOK;
		game.gameArray[57] = WKNIGHT;
		game.gameArray[58] = WBISHOP;
		game.gameArray[59] = WQUEEN;
		game.gameArray[60] = WKING;
		game.gameArray[61] = WBISHOP;
		game.gameArray[62] = WKNIGHT;
		game.gameArray[63] = WROOK;

		for(i in [0..15]) {
			game.whitePieceLocations[i] = i + 48;
			game.blackPieceLocations[i] = i;
		}

		// always place the king in [0]
		game.blackPieceLocations[0] = 4;
		game.blackPieceLocations[4] = 0;
		game.whitePieceLocations[0] = 60;
		game.whitePieceLocations[12] = 48;
		game.numWhitePieces = 16;
		game.numBlackPieces = 16;

		game.moveList = [];
		isGameOver = false;
		if(not humanIsWhite) {
			computerAI.move();
		} else {
			findValidMoves();
		}
	}

	public function copyGame(originalGame: Game): Game {
		var cg = Game {
			isWhitesMove: originalGame.isWhitesMove
			canWhiteCastleKingSide: originalGame.canWhiteCastleKingSide
			canWhiteCastleQueenSide: originalGame.canWhiteCastleQueenSide
			canBlackCastleKingSide: originalGame.canBlackCastleKingSide
			canBlackCastleQueenSide: originalGame.canBlackCastleQueenSide
		}

		for(i in [0..63]) {
			cg.gameArray[i] = originalGame.gameArray[i];
		}

		cg.numWhitePieces = originalGame.numWhitePieces;
		for(i in [0..cg.numWhitePieces-1]) {
			cg.whitePieceLocations[i] = originalGame.whitePieceLocations[i];
		}

		cg.numBlackPieces = originalGame.numBlackPieces;
		for(i in [0..cg.numBlackPieces-1]) {
			cg.blackPieceLocations[i] = originalGame.blackPieceLocations[i];
		}

		cg.moveList = [];
		for(move in originalGame.moveList) {
			insert move into cg.moveList;
		}

		cg.validMoves = [];
		for(move in originalGame.validMoves) {
			insert move into cg.validMoves;
		}

		// return the new game
		cg;
	}

	/**
	 * Finds the valid moves for all of the pieces except for the king
	 */
	function findAllExceptKingsMoves(g: Game, recurse: Boolean): Void {
		if(g.isWhitesMove) {
			// start at 1 since the king is at index 0
			// and we don't need to check the kings moves
			for(i in [1..g.numWhitePieces-1]) {
				def pieceLocation = g.whitePieceLocations[i];
				if(g.gameArray[pieceLocation] == WPAWN) {
					findWPawnMoves(g, pieceLocation, recurse);
				} else if(g.gameArray[pieceLocation] == WKNIGHT) {
					findKnightMoves(g, pieceLocation, recurse);
				} else if(g.gameArray[pieceLocation] == WBISHOP) {
					findBishopMoves(g, pieceLocation, recurse);
				} else if(g.gameArray[pieceLocation] == WROOK) {
					findRookMoves(g, pieceLocation, recurse);
				} else {
					findRookMoves(g, pieceLocation, recurse);
					findBishopMoves(g, pieceLocation, recurse);
				}
			}
		} else {
			// start at 1 since the king is at index 0
			// and we don't need to check the kings moves
			for(i in [1..g.numBlackPieces-1]) {
				def pieceLocation = g.blackPieceLocations[i];
				if(g.gameArray[pieceLocation] == BPAWN) {
					findBPawnMoves(g, pieceLocation, recurse);
				} else if(g.gameArray[pieceLocation] == BKNIGHT) {
					findKnightMoves(g, pieceLocation, recurse);
				} else if(g.gameArray[pieceLocation] == BBISHOP) {
					findBishopMoves(g, pieceLocation, recurse);
				} else if(g.gameArray[pieceLocation] == BROOK) {
					findRookMoves(g, pieceLocation, recurse);
				} else {
					findRookMoves(g, pieceLocation, recurse);
					findBishopMoves(g, pieceLocation, recurse);
				}
			}
		}
	}

	/**
	 * Finds the opponents moves to check if the king is in check, except
	 * for the king since the king cannot place the king in check.
	 */
	function findOpponentMoves(g: Game): Void {
		// temporarily change whose move it is
		g.isWhitesMove = not g.isWhitesMove;

		g.validMoves = [];
		findAllExceptKingsMoves(g, false);

		// set back whose move it is
		g.isWhitesMove = not g.isWhitesMove;
	}

	public function findValidMoves(): Void {
		game.validMoves = [];
		if(game.isWhitesMove) {
			findWKingMoves(game, game.whitePieceLocations[0], true);
			findAllExceptKingsMoves(game, true);
			if(sizeof game.validMoves == 0) {
				findOpponentMoves(game);
				var kingIsInCheck: Boolean = false;
				for(move: Move in game.validMoves) {
					if(move.destination == game.whitePieceLocations[0]) {
						kingIsInCheck = true;
						break;
					}
				}
				if(kingIsInCheck) {
					setGameOver(BLACK_WINS);
				} else {
					setGameOver(DRAW);
				}
			}
		} else {
			findBKingMoves(game, game.blackPieceLocations[0], true);
			findAllExceptKingsMoves(game, true);
			if(sizeof game.validMoves == 0) {
				findOpponentMoves(game);
				var kingIsInCheck: Boolean = false;
				for(move: Move in game.validMoves) {
					if(move.destination == game.blackPieceLocations[0]) {
						kingIsInCheck = true;
						break;
					}
				}
				if(kingIsInCheck) {
					setGameOver(WHITE_WINS);
				} else {
					setGameOver(DRAW);
				}
			}
		}
	}

	public function makeMove(move: Move): Void {
		// make sure the move is valid
		var moveIsValid: Boolean = false;
		for(validMove in game.validMoves) {
			if(validMove.equals(move)) {
				moveIsValid = true;
				break;
			}
		}

		if(moveIsValid) {
			if(game.isWhitesMove) {
				var blackPieceEaten: Boolean = false;
				for(i in [1..game.numBlackPieces-1]) {
					if(game.blackPieceLocations[i] == move.destination) {
						game.blackPieceLocations[i] = game.blackPieceLocations[game.numBlackPieces-1];
						game.numBlackPieces -= 1;
						blackPieceEaten = true;
						break;
					}
				}

				for(i in [0..game.numWhitePieces]) {
					if(game.whitePieceLocations[i] == move.source) {
						game.gameArray[move.destination] = game.gameArray[move.source];
						game.gameArray[move.source] = EMPTY_SQUARE;
						game.whitePieceLocations[i] = move.destination;

						if(game.gameArray[move.destination] == WPAWN) {
							// check for pawn promotion
							if(move.destination < 8) {
								def options: Object[] = [ "Queen", "Rook", "Bishop", "Knight" ];
								def selection: String = JOptionPane.showInputDialog(null,
										"Select the piece type for your promoted pawn",
										"Pawn Promoted",
										JOptionPane.QUESTION_MESSAGE,
										null,
										options,
										options[0]) as String;
								if(selection.equals(options[0])) {
									game.gameArray[move.destination] = WQUEEN;
									break;
								} else if(selection.equals(options[1])) {
									game.gameArray[move.destination] = WROOK;
									break;
								} else if(selection.equals(options[2])) {
									game.gameArray[move.destination] = WBISHOP;
									break;
								} else if(selection.equals(options[3])) {
									game.gameArray[move.destination] = WKNIGHT;
									break;
								}
							} else {
								// check for en passant
								if(not blackPieceEaten) {
									if(move.destination == move.source - 7) {
										for(j in [1..game.numBlackPieces-1]) {
											if(game.blackPieceLocations[j] == move.source + 1) {
												game.blackPieceLocations[j] = game.blackPieceLocations[game.numBlackPieces-1];
												game.numBlackPieces -= 1;
												game.gameArray[move.source+1] = EMPTY_SQUARE;
												break;
											}
										}
									} else if(move.destination == move.source - 9) {
										for(j in [1..game.numBlackPieces-1]) {
											if(game.blackPieceLocations[j] == move.source - 1) {
												game.blackPieceLocations[j] = game.blackPieceLocations[game.numBlackPieces-1];
												game.numBlackPieces -= 1;
												game.gameArray[move.source-1] = EMPTY_SQUARE;
												break;
											}
										}
									}
								}
							}
						}

						if(game.gameArray[move.destination] == WROOK) {
							if(move.source == Coord.H8.getArrayIndex()) {
								game.canWhiteCastleKingSide = false;
							} else if(move.source == Coord.A8.getArrayIndex()) {
								game.canWhiteCastleQueenSide = false;
							}
						}

						if(game.gameArray[move.destination] == WKING) {
							game.canWhiteCastleKingSide = false;
							game.canWhiteCastleQueenSide = false;
							// if castle move the rook
							if(Math.abs(move.source - move.destination) == 2) {
								if(move.destination == Coord.G1.getArrayIndex()) {
									for(j in [1..game.numWhitePieces-1]) {
										if(game.whitePieceLocations[j] == Coord.H1.getArrayIndex()) {
											game.whitePieceLocations[j] = Coord.F1.getArrayIndex();
											game.gameArray[Coord.H1.getArrayIndex()] = EMPTY_SQUARE;
											game.gameArray[Coord.F1.getArrayIndex()] = WROOK;
										}
									}
								} else {
									for(j in [1..game.numWhitePieces-1]) {
										if(game.whitePieceLocations[j] == Coord.A1.getArrayIndex()) {
											game.whitePieceLocations[j] == Coord.D1.getArrayIndex();
											game.gameArray[Coord.A1.getArrayIndex()] = EMPTY_SQUARE;
											game.gameArray[Coord.D1.getArrayIndex()] = WROOK;
										}
									}
								}
							}
						}

						break;
					}
				}
			} else {
				var whitePieceEaten: Boolean = false;
				for(i in [1..game.numWhitePieces-1]) {
					if(game.whitePieceLocations[i] == move.destination) {
						game.whitePieceLocations[i] = game.whitePieceLocations[game.numWhitePieces-1];
						game.numWhitePieces -= 1;
						whitePieceEaten = true;
						break;
					}
				}

				for(i:Integer in [0..game.numBlackPieces]) {
					if(game.blackPieceLocations[i] == move.source) {
						game.gameArray[move.destination] = game.gameArray[move.source];
						game.gameArray[move.source] = EMPTY_SQUARE;
						game.blackPieceLocations[i] = move.destination;

						if(game.gameArray[move.destination] == BPAWN) {
							// check for pawn promotion
							if(move.destination >= 56) {
								def options: Object[] = [ "Queen", "Rook", "Bishop", "Knight" ];
								def selection: String = JOptionPane.showInputDialog(null,
										"Select the piece type for your promoted pawn",
										"Pawn Promoted",
										JOptionPane.QUESTION_MESSAGE,
										null,
										options,
										options[0]) as String;
								if(selection.equals(options[0])) {
									game.gameArray[move.destination] = BQUEEN;
									break;
								} else if(selection.equals(options[1])) {
									game.gameArray[move.destination] = BROOK;
									break;
								} else if(selection.equals(options[2])) {
									game.gameArray[move.destination] = BBISHOP;
									break;
								} else if(selection.equals(options[3])) {
									game.gameArray[move.destination] = BKNIGHT;
									break;
								}
							} else {
								// check for en passant
								if(not whitePieceEaten) {
									if(move.destination == move.source + 7) {
										for(j in [1..game.numWhitePieces-1]) {
											if(game.whitePieceLocations[j] == move.source - 1) {
												game.whitePieceLocations[j] = game.whitePieceLocations[game.numWhitePieces-1];
												game.numWhitePieces -= 1;
												game.gameArray[move.source-1] = EMPTY_SQUARE;
												break;
											}
										}
									} else if(move.destination == move.source + 9) {
										for(j in [1..game.numWhitePieces-1]) {
											if(game.whitePieceLocations[j] == move.source + 1) {
												game.whitePieceLocations[j] = game.whitePieceLocations[game.numWhitePieces-1];
												game.numWhitePieces -= 1;
												game.gameArray[move.source+1] = EMPTY_SQUARE;
												break;
											}
										}
									}
								}
							}
						}

						if(game.gameArray[move.destination] == BROOK) {
							if(move.source == Coord.H1.getArrayIndex()) {
								game.canBlackCastleKingSide = false;
							} else if(move.source == Coord.A1.getArrayIndex()) {
								game.canBlackCastleQueenSide = false;
							}
						}

						if(game.gameArray[move.destination] == BKING) {
							game.canBlackCastleKingSide = false;
							game.canBlackCastleQueenSide = false;
							// if castle move the rook
							if(Math.abs(move.source - move.destination) == 2) {
								if(move.destination == Coord.G8.getArrayIndex()) {
									for(j in [1..game.numBlackPieces-1]) {
										if(game.blackPieceLocations[j] == Coord.H8.getArrayIndex()) {
											game.blackPieceLocations[j] = Coord.F8.getArrayIndex();
											game.gameArray[Coord.H8.getArrayIndex()] = EMPTY_SQUARE;
											game.gameArray[Coord.F8.getArrayIndex()] = BROOK;
										}
									}
								} else {
									for(j in [1..game.numBlackPieces-1]) {
										if(game.blackPieceLocations[j] == Coord.A8.getArrayIndex()) {
											game.blackPieceLocations[j] == Coord.D8.getArrayIndex();
											game.gameArray[Coord.A8.getArrayIndex()] = EMPTY_SQUARE;
											game.gameArray[Coord.D8.getArrayIndex()] = BROOK;
										}
									}
								}
							}
						}

						break;
					}
				}
			}
			insert move into game.moveList;
			game.isWhitesMove = not game.isWhitesMove;
			if(humanIsWhite == game.isWhitesMove) {
				findValidMoves();
			} else {
				findValidMoves();
				if(isGameOver) {
					newGame();
					return;
				}
				computerAI.move();
			}
		}
	}

	public function makeFakeMove(g: Game, move: Move): Void {
		if(g.isWhitesMove) {
			var blackPieceEaten: Boolean = false;
			for(i in [1..g.numBlackPieces-1]) {
				if(g.blackPieceLocations[i] == move.destination) {
					g.blackPieceLocations[i] = g.blackPieceLocations[g.numBlackPieces-1];
					g.numBlackPieces -= 1;
					blackPieceEaten = true;
					break;
				}
			}

			for(i in [0..g.numWhitePieces]) {
				if(g.whitePieceLocations[i] == move.source) {
					g.gameArray[move.destination] = g.gameArray[move.source];
					g.gameArray[move.source] = EMPTY_SQUARE;
					g.whitePieceLocations[i] = move.destination;

					if(g.gameArray[move.destination] == WPAWN) {
						// check for pawn promotion
						if(move.destination < 8) {
							// TODO Finish this
						} else {
							// check for en passant
							if(not blackPieceEaten) {
								if(move.destination == move.source - 7) {
									for(j in [1..g.numBlackPieces-1]) {
										if(g.blackPieceLocations[j] == move.source + 1) {
											g.blackPieceLocations[j] = g.blackPieceLocations[g.numBlackPieces-1];
											g.numBlackPieces -= 1;
											g.gameArray[move.source+1] = EMPTY_SQUARE;
											break;
										}
									}
								} else if(move.destination == move.source - 9) {
									for(j in [1..g.numBlackPieces-1]) {
										if(g.blackPieceLocations[j] == move.source - 1) {
											g.blackPieceLocations[j] = g.blackPieceLocations[g.numBlackPieces-1];
											g.numBlackPieces -= 1;
											g.gameArray[move.source-1] = EMPTY_SQUARE;
											break;
										}
									}
								}
							}
						}
					}

					if(g.gameArray[move.destination] == WROOK) {
						if(move.source == Coord.H8.getArrayIndex()) {
							g.canWhiteCastleKingSide = false;
						} else if(move.source == Coord.A8.getArrayIndex()) {
							g.canWhiteCastleQueenSide = false;
						}
					}

					if(g.gameArray[move.destination] == WKING) {
						g.canWhiteCastleKingSide = false;
						g.canWhiteCastleQueenSide = false;
						// if castle move the rook
						if(Math.abs(move.source - move.destination) == 2) {
							if(move.destination == Coord.G1.getArrayIndex()) {
								for(j in [1..g.numWhitePieces-1]) {
									if(g.whitePieceLocations[j] == Coord.H1.getArrayIndex()) {
										g.whitePieceLocations[j] = Coord.F1.getArrayIndex();
										g.gameArray[Coord.H1.getArrayIndex()] = EMPTY_SQUARE;
										g.gameArray[Coord.F1.getArrayIndex()] = WROOK;
									}
								}
							} else {
								for(j in [1..g.numWhitePieces-1]) {
									if(g.whitePieceLocations[j] == Coord.A1.getArrayIndex()) {
										g.whitePieceLocations[j] == Coord.D1.getArrayIndex();
										g.gameArray[Coord.A1.getArrayIndex()] = EMPTY_SQUARE;
										g.gameArray[Coord.D1.getArrayIndex()] = WROOK;
									}
								}
							}
						}
					}

					break;
				}
			}
		} else {
			var whitePieceEaten: Boolean = false;
			for(i in [1..g.numWhitePieces-1]) {
				if(g.whitePieceLocations[i] == move.destination) {
					g.whitePieceLocations[i] = g.whitePieceLocations[g.numWhitePieces-1];
					g.numWhitePieces -= 1;
					whitePieceEaten = true;
					break;
				}
			}

			for(i:Integer in [0..g.numBlackPieces]) {
				if(g.blackPieceLocations[i] == move.source) {
					g.gameArray[move.destination] = g.gameArray[move.source];
					g.gameArray[move.source] = EMPTY_SQUARE;
					g.blackPieceLocations[i] = move.destination;

					if(g.gameArray[move.destination] == BPAWN) {
						// check for pawn promotion
						if(move.destination >= 56) {
							// TODO Finish this
						} else {
							// check for en passant
							if(not whitePieceEaten) {
								if(move.destination == move.source + 7) {
									for(j in [1..g.numWhitePieces-1]) {
										if(g.whitePieceLocations[j] == move.source - 1) {
											g.whitePieceLocations[j] = g.whitePieceLocations[g.numWhitePieces-1];
											g.numWhitePieces -= 1;
											g.gameArray[move.source-1] = EMPTY_SQUARE;
											break;
										}
									}
								} else if(move.destination == move.source + 9) {
									for(j in [1..g.numWhitePieces-1]) {
										if(g.whitePieceLocations[j] == move.source + 1) {
											g.whitePieceLocations[j] = g.whitePieceLocations[g.numWhitePieces-1];
											g.numWhitePieces -= 1;
											g.gameArray[move.source+1] = EMPTY_SQUARE;
											break;
										}
									}
								}
							}
						}
					}

					if(g.gameArray[move.destination] == BROOK) {
						if(move.source == Coord.H1.getArrayIndex()) {
							g.canBlackCastleKingSide = false;
						} else if(move.source == Coord.A1.getArrayIndex()) {
							g.canBlackCastleQueenSide = false;
						}
					}

					if(g.gameArray[move.destination] == BKING) {
						g.canBlackCastleKingSide = false;
						g.canBlackCastleQueenSide = false;
						// if castle move the rook
						if(Math.abs(move.source - move.destination) == 2) {
							if(move.destination == Coord.G8.getArrayIndex()) {
								for(j in [1..g.numBlackPieces-1]) {
									if(g.blackPieceLocations[j] == Coord.H8.getArrayIndex()) {
										g.blackPieceLocations[j] = Coord.F8.getArrayIndex();
										g.gameArray[Coord.H8.getArrayIndex()] = EMPTY_SQUARE;
										g.gameArray[Coord.F8.getArrayIndex()] = BROOK;
									}
								}
							} else {
								for(j in [1..g.numBlackPieces-1]) {
									if(g.blackPieceLocations[j] == Coord.A8.getArrayIndex()) {
										g.blackPieceLocations[j] == Coord.D8.getArrayIndex();
										g.gameArray[Coord.A8.getArrayIndex()] = EMPTY_SQUARE;
										g.gameArray[Coord.D8.getArrayIndex()] = BROOK;
									}
								}
							}
						}
					}

					break;
				}
			}
		}
		g.isWhitesMove = not g.isWhitesMove;
	}

	function setGameOver(i: Integer): Void {
		if(i == WHITE_WINS) {
			JOptionPane.showMessageDialog(null,
			                              "The Game is Over.\nIt's a Win for White!\n",
			                              "Game Over - White Wins",
			                              JOptionPane.INFORMATION_MESSAGE);
		} else if(i == BLACK_WINS) {
			JOptionPane.showMessageDialog(null,
			                              "The Game is Over.\nIt's a Win for Black!\n",
			                              "Game Over - Black Wins",
			                              JOptionPane.INFORMATION_MESSAGE);
		} else {
			JOptionPane.showMessageDialog(null,
			                              "The Game is Over.\nIt's a Draw!\n",
			                              "Game Over - Draw",
			                              JOptionPane.INFORMATION_MESSAGE);
		}
		isGameOver = true;
	}

	function findWPawnMoves(g: Game, pieceLocation: Integer, recurse: Boolean): Void {
		var possibleMoves: Move[] = [];
		def type: Integer = WPAWN;

		// check if pawn can move forward one square
		var dest = pieceLocation - 8;
		if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
			insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;

			// if pawn hasn't moved yet it can move forward two squares
			if(pieceLocation >= 48) {
				// check if pawn can move forward two squares
				dest = pieceLocation - 16;
				if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				}
			}
		}

		// check if pawn can capture a piece in the upper left square
		dest = pieceLocation - 9;
		if(g.gameArray[dest] < 0) {
			// make sure this piece isn't on the far left side of the board
			if(pieceLocation mod 8 != 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
		}

		// check if pawn can capture a piece in the upper right square
		dest = pieceLocation - 7;
		if(g.gameArray[dest] < 0) {
			// make sure this piece isn't on the far right side of the board
			if(pieceLocation mod 8 != 7) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
		}

		// check for en passant
		if(pieceLocation >= 24 and pieceLocation < 32) {
			if(sizeof g.moveList > 0) {
				def lastMove: Move = g.moveList[sizeof g.moveList - 1];
				if(lastMove.pieceType == PieceType.BPAWN) {
				if(lastMove.source == pieceLocation - 17 and lastMove.destination == pieceLocation - 1) {
						insert Move { pieceType: type, source: pieceLocation, destination: pieceLocation - 9 } into possibleMoves;
					} else if(lastMove.source == pieceLocation - 15 and lastMove.destination == pieceLocation + 1) {
						insert Move { pieceType: type, source: pieceLocation, destination: pieceLocation - 7 } into possibleMoves;
					}
				}
			}
		}

		validatePossibleMoves(g, possibleMoves, recurse);
	}

	function findBPawnMoves(g: Game, pieceLocation: Integer, recurse: Boolean): Void {
		var possibleMoves: Move[] = [];
		def type: Integer = BPAWN;

		// check if pawn can move forward one square
		var dest = pieceLocation + 8;
		if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
			insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;

			// if pawn hasn't moved yet it can move forward two squares
			if(pieceLocation <= 15) {
				// check if pawn can move forward two squares
				dest = pieceLocation + 16;
				if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				}
			}
		}

		// check if pawn can capture a piece in the lower left square
		dest = pieceLocation + 7;
		if(g.gameArray[dest] > 0) {
			// make sure this piece isn't on the far left side of the board
			if(pieceLocation mod 8 != 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
		}

		// check if pawn can capture a piece in the lower right square
		dest = pieceLocation + 9;
		if(g.gameArray[dest] > 0) {
			// make sure this piece isn't on the far right side of the board
			if(pieceLocation mod 8 != 7) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
		}

		// check for en passant
		if(pieceLocation >= 32 and pieceLocation < 40) {
			if(sizeof g.moveList > 0) {
				def lastMove: Move = g.moveList[sizeof g.moveList - 1];
				if(lastMove.pieceType == PieceType.WPAWN) {
					if(lastMove.source == pieceLocation + 17 and lastMove.destination == pieceLocation + 1) {
						insert Move { pieceType: type, source: pieceLocation, destination: pieceLocation + 9 } into possibleMoves;
					} else if(lastMove.source == pieceLocation + 15 and lastMove.destination == pieceLocation - 1) {
						insert Move { pieceType: type, source: pieceLocation, destination: pieceLocation + 7 } into possibleMoves;
					}
				}
			}
		}

		validatePossibleMoves(g, possibleMoves, recurse);
	}

	function findKnightMoves(g: Game, pieceLocation: Integer, recurse: Boolean): Void {
		var possibleMoves: Move[] = [];
		var type: Integer;
		if(g.isWhitesMove) {
			type = WKNIGHT;
		} else {
			type = BKNIGHT;
		}

		def modLocation: Integer = pieceLocation mod 8;
		var dest: Integer;
		// check for knight moves moving up
		if(pieceLocation >= 16) { // if knight is below the second row
			if(modLocation > 1) { // if knight is right of the second column
				dest = pieceLocation - 17;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation - 10;
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation - 10;
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			} else if(modLocation == 1) { // if knight is on the second column
				dest = pieceLocation - 17;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			}
			if(modLocation < 6) { // if knight is right of the second to last column
				dest = pieceLocation - 15;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation - 6;
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation - 6;
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			} else if(modLocation == 6) { // if knight is on the second to last column
				dest = pieceLocation - 15;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			}
		} else if(pieceLocation >= 8) { // if knight is on the second row
			if(modLocation > 1) { // if knight is right of the second column
				dest = pieceLocation - 10;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			}
			if(modLocation < 6) { // if knight is left of the second to last column
				dest = pieceLocation - 6;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			}
		}

		// check for knight moves moving down
		if(pieceLocation < 48) { // if knight is above the second to last row
			if(modLocation > 1) { // if knight is right of the second column
				dest = pieceLocation + 15;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation + 6;
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation + 6;
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			} else if(modLocation == 1) { // if knight is on the second column
				dest = pieceLocation + 15;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			}
			if(modLocation < 6) { // if knight is left of second to last column
				dest = pieceLocation + 17;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation + 10;
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation + 10;
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			} else if(modLocation == 6) { // if knight is on second to last column
				dest = pieceLocation + 17;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			}
		} else if(pieceLocation < 56) { // if knight is on second to last row
			if(modLocation > 1) { // if knight is right of second column
				dest = pieceLocation + 6;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			}
			if(modLocation < 6) { // if knight is left of second to last column
				dest = pieceLocation + 10;
				if(g.isWhitesMove) {
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			}
		}

		validatePossibleMoves(g, possibleMoves, recurse);
	}

	function findBishopMoves(g: Game, pieceLocation: Integer, recurse: Boolean): Void {
		var possibleMoves: Move[] = [];
		var type: Integer;
		if(g.isWhitesMove) {
			type = WBISHOP;
		} else {
			type = BBISHOP;
		}

		def modLocation: Integer = pieceLocation mod 8;

		// find moves going up and to the left
		var dest: Integer = pieceLocation;
		for(i in [modLocation-1..0 step -1]) {
			// find moves going up and to the left
			dest -= 9;
			if(dest >= 0) {
				if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				} else {
					if(g.isWhitesMove) {
						if(g.gameArray[dest] < 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					} else {
						if(g.gameArray[dest] > 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					}
					break;
				}
			}
		}

		// find moves going down and to the left
		dest = pieceLocation;
		for(i in [modLocation-1..0 step -1]) {
			dest += 7;
			if(dest < 64) {
				if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				} else {
					if(g.isWhitesMove) {
						if(g.gameArray[dest] < 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					} else {
						if(g.gameArray[dest] > 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					}
					break;
				}
			}
		}

		// find moves going up and to the right
		dest = pieceLocation;
		for(i in [modLocation+1..7]) {
			dest -= 7;
			if(dest >= 0) {
				if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				} else {
					if(g.isWhitesMove) {
						if(g.gameArray[dest] < 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					} else {
						if(g.gameArray[dest] > 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					}
					break;
				}
			}
		}

		// find moves going down and to the right
		dest = pieceLocation;
		for(i in [modLocation+1..7]) {
			dest += 9;
			if(dest < 64) {
				if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				} else {
					if(g.isWhitesMove) {
						if(g.gameArray[dest] < 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					} else {
						if(g.gameArray[dest] > 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					}
					break;
				}
			}
		}

		validatePossibleMoves(g, possibleMoves, recurse);
	}

	function findRookMoves(g: Game, pieceLocation: Integer, recurse: Boolean): Void {
		var possibleMoves: Move[] = [];
		var type: Integer;
		if(g.isWhitesMove) {
			type = WROOK;
		} else {
			type = BROOK;
		}

		// find moves going down
		var dest: Integer = pieceLocation - 8;
		while(dest >= 0) {
			if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				dest -= 8;
			} else {
				if(g.isWhitesMove) {
					if(g.gameArray[dest] < 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] > 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
				// no more moves going down
				break;
			}
		}

		// find moves going up
		dest = pieceLocation + 8;
		while(dest <= 63) {
			if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				dest += 8;
			} else {
				if(g.isWhitesMove) {
					if(g.gameArray[dest] < 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] > 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
				// no more moves going up
				break;
			}
		}

		// find moves going right
		dest = pieceLocation + 1;
		while(dest mod 8 != 0) {
			if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				dest += 1;
			} else {
				if(g.isWhitesMove) {
					if(g.gameArray[dest] < 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] > 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
				// no more moves going right
				break;
			}
		}

		// find moves going left
		dest = pieceLocation - 1;
		while(dest >= 0 and Math.abs(dest mod 8) != 7) {
			if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				dest -= 1;
			} else {
				if(g.isWhitesMove) {
					if(g.gameArray[dest] < 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				} else {
					if(g.gameArray[dest] > 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
				// no more moves going left
				break;
			}
		}

		validatePossibleMoves(g, possibleMoves, recurse);
	}

	function findWKingMoves(g: Game, pieceLocation: Integer, recurse: Boolean): Void {
		var possibleMoves: Move[] = [];
		def type: Integer = WKING;

		def modLocation: Integer = pieceLocation mod 8;
		var dest: Integer;

		if(g.canWhiteCastleKingSide or g.canWhiteCastleQueenSide) {
			dest = pieceLocation - 1;
			if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				dest = pieceLocation - 2;
				if(g.canWhiteCastleQueenSide and g.gameArray[dest] == PieceType.EMPTY_SQUARE and g.gameArray[dest-1] == PieceType.EMPTY_SQUARE) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				}
			} else if(g.gameArray[dest] < 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
			dest = pieceLocation - 9;
			if(g.gameArray[dest] <= 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
			dest = pieceLocation - 8;
			if(g.gameArray[dest] <= 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
			dest = pieceLocation - 7;
			if(g.gameArray[dest] <= 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
			dest = pieceLocation + 1;
			if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				dest = pieceLocation + 2;
				if(g.canWhiteCastleKingSide and g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				}
			} else if(g.gameArray[dest] < 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
		} else {
			if(pieceLocation < 56) {
				// can check moves down
				dest = pieceLocation + 8;
				if(g.gameArray[dest] <= 0) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				}
				if(pieceLocation >= 8) {
					// can check moves up
					dest = pieceLocation - 8;
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					if(modLocation != 7) {
						// can move right
						dest = pieceLocation - 7;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation + 1;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation + 9;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						if(modLocation != 0) {
							// can move left
							dest = pieceLocation - 9;
							if(g.gameArray[dest] <= 0) {
								insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
							}
							dest = pieceLocation - 1;
							if(g.gameArray[dest] <= 0) {
								insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
							}
							dest = pieceLocation + 7;
							if(g.gameArray[dest] <= 0) {
								insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
							}
						}
					} else {  // if(modLocation != 7)
						// can move left
						dest = pieceLocation - 9;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation - 1;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation + 7;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					}
				} else {  // if(pieceLocation >= 8)
					if(modLocation != 7) {
						// can move right
						dest = pieceLocation + 1;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation + 9;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						if(modLocation != 0) {
							// can move left
							dest = pieceLocation - 1;
							if(g.gameArray[dest] <= 0) {
								insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
							}
							dest = pieceLocation + 7;
							if(g.gameArray[dest] <= 0) {
								insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
							}
						}
					} else {  // if(modLocation != 7)
						// can move left
						dest = pieceLocation - 1;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation + 7;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					}
				}
			} else {  // if(pieceLocation < 56)
				// can check moves up
				dest = pieceLocation - 8;
				if(g.gameArray[dest] <= 0) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				}
				if(modLocation != 7) {
					// can move right
					dest = pieceLocation - 7;
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation + 1;
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					if(modLocation != 0) {
						// can move left
						dest = pieceLocation - 9;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation - 1;
						if(g.gameArray[dest] <= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					}
				} else {
					// can move left
					dest = pieceLocation - 9;
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation - 1;
					if(g.gameArray[dest] <= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			}
		}

		validatePossibleMoves(g, possibleMoves, recurse);
	}

	function findBKingMoves(g: Game, pieceLocation: Integer, recurse: Boolean): Void {
		var possibleMoves: Move[] = [];
		def type: Integer = BKING;

		def modLocation: Integer = pieceLocation mod 8;
		var dest: Integer;

		if(g.canBlackCastleKingSide or g.canBlackCastleQueenSide) {
			dest = pieceLocation - 1;
			if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				dest = pieceLocation - 2;
				if(g.canBlackCastleQueenSide and g.gameArray[dest] == PieceType.EMPTY_SQUARE and g.gameArray[dest-1] == PieceType.EMPTY_SQUARE) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				}
			} else if(g.gameArray[dest] > 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
			dest = pieceLocation + 9;
			if(g.gameArray[dest] >= 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
			dest = pieceLocation + 8;
			if(g.gameArray[dest] >= 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
			dest = pieceLocation + 7;
			if(g.gameArray[dest] >= 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
			dest = pieceLocation + 1;
			if(g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				dest = pieceLocation + 2;
				if(g.canBlackCastleKingSide and g.gameArray[dest] == PieceType.EMPTY_SQUARE) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				}
			} else if(g.gameArray[dest] > 0) {
				insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
			}
		} else {
			if(pieceLocation < 56) {
				// can check moves down
				dest = pieceLocation + 8;
				if(g.gameArray[dest] >= 0) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				}
				if(pieceLocation >= 8) {
					// can check moves up
					dest = pieceLocation - 8;
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					if(modLocation != 7) {
						// can move right
						dest = pieceLocation - 7;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation + 1;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation + 9;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						if(modLocation != 0) {
							// can move left
							dest = pieceLocation - 9;
							if(g.gameArray[dest] >= 0) {
								insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
							}
							dest = pieceLocation - 1;
							if(g.gameArray[dest] >= 0) {
								insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
							}
							dest = pieceLocation + 7;
							if(g.gameArray[dest] >= 0) {
								insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
							}
						}
					} else {  // if(modLocation != 7)
						// can move left
						dest = pieceLocation - 9;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation - 1;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation + 7;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					}
				} else {  // if(pieceLocation >= 8)
					if(modLocation != 7) {
						// can move right
						dest = pieceLocation + 1;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation + 9;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						if(modLocation != 0) {
							// can move left
							dest = pieceLocation - 1;
							if(g.gameArray[dest] >= 0) {
								insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
							}
							dest = pieceLocation + 7;
							if(g.gameArray[dest] >= 0) {
								insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
							}
						}
					} else {  // if(modLocation != 7)
						// can move left
						dest = pieceLocation - 1;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation + 7;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					}
				}
			} else {  // if(pieceLocation < 56)
				// can check moves up
				dest = pieceLocation - 8;
				if(g.gameArray[dest] >= 0) {
					insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
				}
				if(modLocation != 7) {
					// can move right
					dest = pieceLocation - 7;
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation + 1;
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					if(modLocation != 0) {
						// can move left
						dest = pieceLocation - 9;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
						dest = pieceLocation - 1;
						if(g.gameArray[dest] >= 0) {
							insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
						}
					}
				} else {
					// can move left
					dest = pieceLocation - 9;
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
					dest = pieceLocation - 1;
					if(g.gameArray[dest] >= 0) {
						insert Move { pieceType: type, source: pieceLocation, destination: dest } into possibleMoves;
					}
				}
			}
		}

		validatePossibleMoves(g, possibleMoves, recurse);
	}

	/**
	 * Checks whether or not each of the possible moves if made will place
	 * the king in check.  You are not allowed to make a move that will place
	 * the king in check.  Moves that do not place the king in check are
	 * added to the valid moves list.
	 */
	function validatePossibleMoves(g: Game, possibleMoves: Move[], recurse: Boolean): Void {
		if(recurse == false) {
			for(possibleMove in possibleMoves) {
				insert possibleMove into g.validMoves;
			}
		} else {
			for(possibleMove in possibleMoves) {
				def cg: Game = copyGame(g);
				makeFakeMove(cg, possibleMove);
				cg.validMoves = [];
				if(cg.isWhitesMove) {
					findWKingMoves(cg, cg.whitePieceLocations[0], false);
				} else {
					findBKingMoves(cg, cg.whitePieceLocations[0], false);
				}
				findAllExceptKingsMoves(cg, false);

				var kingLocation;
				if(cg.isWhitesMove) {
					kingLocation = cg.blackPieceLocations[0];
				} else {
					kingLocation = cg.whitePieceLocations[0];
				}

				var moveIsValid: Boolean = true;
				for(move: Move in cg.validMoves) {
					if(move.destination == kingLocation) {
						moveIsValid = false;
						break;
					}
				}

				if(moveIsValid) {
					insert possibleMove into g.validMoves;
				}
			}
		}
	}
}
