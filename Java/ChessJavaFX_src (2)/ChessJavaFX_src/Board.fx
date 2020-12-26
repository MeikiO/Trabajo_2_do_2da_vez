import javafx.scene.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;

public class Board extends Scene {
	public-init var tallestPieceHeight;
	def LIGHT_COLOR: Color = Color.web("lemonchiffon");
	def DARK_COLOR: Color = Color.web("brown");

	public-read var squareSize = bind {
		if (width > height) {
			height / 10;
		} else {
			width / 10;
		}
	}

	public-read var xOffset = bind {
		if (width > height) {
			(width - height) / 2;
		} else {
			0;
		}
	}

	public-read var yOffset = bind {
		if (width > height) {
			0;
		} else {
			(height - width) / 2;
		}
	}

	public-read var scale = bind squareSize / tallestPieceHeight;

	def board = [ Coord.A8, Coord.B8, Coord.C8, Coord.D8, Coord.E8, Coord.F8, Coord.G8, Coord.H8,
				  Coord.A7, Coord.B7, Coord.C7, Coord.D7, Coord.E7, Coord.F7, Coord.G7, Coord.H7,
				  Coord.A6, Coord.B6, Coord.C6, Coord.D6, Coord.E6, Coord.F6, Coord.G6, Coord.H6,
				  Coord.A5, Coord.B5, Coord.C5, Coord.D5, Coord.E5, Coord.F5, Coord.G5, Coord.H5,
				  Coord.A4, Coord.B4, Coord.C4, Coord.D4, Coord.E4, Coord.F4, Coord.G4, Coord.H4,
				  Coord.A3, Coord.B3, Coord.C3, Coord.D3, Coord.E3, Coord.F3, Coord.G3, Coord.H3,
				  Coord.A2, Coord.B2, Coord.C2, Coord.D2, Coord.E2, Coord.F2, Coord.G2, Coord.H2,
				  Coord.A1, Coord.B1, Coord.C1, Coord.D1, Coord.E1, Coord.F1, Coord.G1, Coord.H1 ];

	postinit {
		for (square in board) {
			def i: Integer = indexof square;
			insert Rectangle {
				fill: if (square.getIsWhite()) LIGHT_COLOR else DARK_COLOR
				x: bind xOffset + ((i mod 8) + 1) * squareSize
				y: bind yOffset + ((i / 8) + 1) * squareSize
				width: bind squareSize
				height: bind squareSize
			} into content;
		}
	}
}
