import java.io.*;
import java.lang.*;
import java.util.*;
import javafx.fxd.*;
import javafx.scene.*;
import javafx.scene.image.*;
import javafx.scene.paint.*;
import javafx.stage.*;

def rootDir = "{__DIR__}".replaceAll("%20", " ");
def kingSize = FXDLoader.load("{rootDir}res{File.separator}BKing.fxz").boundsInLocal;

// find the settings file in the users home directory
def homeDir = System.getProperty("user.home");
def settingsFile = "{homeDir}{File.separator}chess_javafx.properties";

// load the settings into the Properties class
def props: Properties = new Properties();
try {
	def input: FileInputStream = new FileInputStream(settingsFile);
	props.load(input);
	input.close();
} catch(ignore: Exception) {
	// if the file doesn't exist, that's OK we will just use the default values (passed into the getProperty() method)
}

// read the saved settings
var savedX: Number;
try {
	savedX = Double.parseDouble(props.getProperty("xPos", "100"));
} catch(e: NumberFormatException) {
	savedX = 100;
}
var savedY: Number;
try {
	savedY = Double.parseDouble(props.getProperty("yPos", "100"));
} catch(e: NumberFormatException) {
	savedY = 100;
}
var savedWidth: Number;
try {
	savedWidth = Double.parseDouble(props.getProperty("width", "700"));
} catch(e: NumberFormatException) {
	savedWidth = 700;
}
var savedHeight: Number;
try {
	savedHeight = Double.parseDouble(props.getProperty("height", "700"));
} catch(e: NumberFormatException) {
	savedHeight = 700;
}

def chessBoard = Board {
	tallestPieceHeight: kingSize.height + (kingSize.height / 10);
	fill: Color.web("cadetblue")
	content: []
}

def stage:Stage = Stage {
	title: "Chess"
	x: savedX
	y: savedY
	width: savedWidth
	height: savedHeight
	resizable: true
	icons: [ Image { url: "{rootDir}res{File.separator}Icon32.png" } ]
	onClose: function() {
		saveSettings();
		System.exit(0);
	}
	scene: chessBoard
}

def game = GameGUI {
	board: chessBoard
}

function saveSettings(): Void {
	props.setProperty("xPos", "{stage.x}");
	props.setProperty("yPos", "{stage.y}");
	props.setProperty("width", "{stage.width}");
	props.setProperty("height", "{stage.height}");

	try {
		def output: FileOutputStream = new FileOutputStream(settingsFile);
		props.store(output, "Saved Chess Settings");
		output.close();
	} catch(ignore: Exception) {
		// if the settings can't be saved we will just have to use the defaults next time
	}
}
