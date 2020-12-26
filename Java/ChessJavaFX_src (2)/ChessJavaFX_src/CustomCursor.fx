import java.awt.*;
import java.net.*;
import javax.swing.*;
import javafx.scene.Cursor;

public class CustomCursor extends Cursor {
	public-init var imageURL: String;
	public-init var cursorName: String;

	public override function impl_getAWTCursor(): java.awt.Cursor {
		var toolkit = Toolkit.getDefaultToolkit();
		var image: Image = toolkit.getImage(new URL(imageURL));
		var point: Point = new Point(16, 16);
		var cursor: java.awt.Cursor = toolkit.createCustomCursor(image, point, cursorName);
	}
}
