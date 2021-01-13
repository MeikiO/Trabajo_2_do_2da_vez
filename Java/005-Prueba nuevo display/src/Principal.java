import javax.swing.JPanel;
import java.awt.BorderLayout;
import javax.swing.JSplitPane;
import javax.swing.JList;

public class Principal extends JPanel {

	/**
	 * Create the panel.
	 */
	public Principal() {
		setLayout(new BorderLayout(0, 0));
		
		JSplitPane splitPane = new JSplitPane();
		add(splitPane, BorderLayout.CENTER);
		
		JList list = new JList();
		list.action
		splitPane.setLeftComponent(list);

	}

}
