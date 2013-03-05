package aren.java.swt.demo;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.widgets.*;

public class CalculatorGui {
	static final int mc_width = 55;
	static final int mc_height = 25; 
	static final int mc_margin = 10;
	static final int mc_int = 5;

	static String m_input = "";
	static String m_error = "";

	static Text m_text;
	static Text m_label;

	static public void main(String[] args) {
		Display display = new Display();
		Shell shell = new Shell(display, SWT.SHELL_TRIM & (~SWT.RESIZE));
		shell.setSize(mc_width * 6 + mc_int * 5 + mc_margin * 2, mc_height * 6
				+ mc_int * 7 + 30);
		shell.setText("ATS Calculator");

		// ------------------------------------------
		Button[][] bs = new Button[4][];
		int posX = mc_margin;
		int posY = 3 * mc_int + 2 * mc_height;

		for (int i = 0; i < 3; ++i) {
			bs[i] = new Button[6];
			for (int j = 0; j < 6; ++j) {
				bs[i][j] = new Button(shell, SWT.NONE);
				bs[i][j].setBounds(posX, posY, mc_width, mc_height);

				posX += mc_int + mc_width;
			}
			posX = mc_margin;
			posY += mc_int + mc_height;
		}

		// line 1
		final Button num7 = bs[0][0];
		num7.setText("7");
		num7.addSelectionListener(new ButtonSelectionAdapter("7"));
		final Button num8 = bs[0][1];
		num8.setText("8");
		num8.addSelectionListener(new ButtonSelectionAdapter("8"));
		final Button num9 = bs[0][2];
		num9.setText("9");
		num9.addSelectionListener(new ButtonSelectionAdapter("9"));
		final Button numdiv = bs[0][3];
		numdiv.setText("/");
		numdiv.addSelectionListener(new ButtonSelectionAdapter("/"));
		final Button numback = bs[0][4];
		numback.setText("<-");
		numback.addSelectionListener(new ButtonSelectionAdapter("<-"));
		final Button numerase = bs[0][5];
		numerase.setText("X");
		numerase.addSelectionListener(new ButtonSelectionAdapter("X"));

		// line 2
		final Button num4 = bs[1][0];
		num4.setText("4");
		num4.addSelectionListener(new ButtonSelectionAdapter("4"));
		final Button num5 = bs[1][1];
		num5.setText("5");
		num5.addSelectionListener(new ButtonSelectionAdapter("5"));
		final Button num6 = bs[1][2];
		num6.setText("6");
		num6.addSelectionListener(new ButtonSelectionAdapter("6"));
		final Button nummul = bs[1][3];
		nummul.setText("*");
		nummul.addSelectionListener(new ButtonSelectionAdapter("*"));
		final Button numlp = bs[1][4];
		numlp.setText("(");
		numlp.addSelectionListener(new ButtonSelectionAdapter("("));
		final Button numrp = bs[1][5];
		numrp.setText(")");
		numrp.addSelectionListener(new ButtonSelectionAdapter(")"));

		// line 3
		final Button num1 = bs[2][0];
		num1.setText("1");
		num1.addSelectionListener(new ButtonSelectionAdapter("1"));
		final Button num2 = bs[2][1];
		num2.setText("2");
		num2.addSelectionListener(new ButtonSelectionAdapter("2"));
		final Button num3 = bs[2][2];
		num3.setText("3");
		num3.addSelectionListener(new ButtonSelectionAdapter("3"));
		final Button numminus = bs[2][3];
		numminus.setText("-");
		numminus.addSelectionListener(new ButtonSelectionAdapter("-"));
		final Button numna1 = bs[2][4];
		numna1.setText("N/A");
		numna1.addSelectionListener(new ButtonSelectionAdapter("N/A"));
		final Button numna2 = bs[2][5];
		numna2.setText("N/A");
		numna2.addSelectionListener(new ButtonSelectionAdapter("N/A"));

		// line 4
		bs[3] = new Button[6];
		for (int j = 0; j < 4; ++j) {
			bs[3][j] = new Button(shell, SWT.NONE);
			bs[3][j].setBounds(posX, posY, mc_width, mc_height);

			posX += mc_int + mc_width;
		}
		bs[3][4] = new Button(shell, SWT.NONE);
		bs[3][4].setBounds(posX, posY, 2 * mc_width + mc_int, mc_height);

		final Button num0 = bs[3][0];
		num0.setText("0");
		num0.addSelectionListener(new ButtonSelectionAdapter("0"));
		final Button numna3 = bs[3][1];
		numna3.setText("N/A");
		numna3.addSelectionListener(new ButtonSelectionAdapter("N/A"));
		final Button numna4 = bs[3][2];
		numna4.setText("N/A");
		numna4.addSelectionListener(new ButtonSelectionAdapter("N/A"));
		final Button numplus = bs[3][3];
		numplus.setText("+");
		numplus.addSelectionListener(new ButtonSelectionAdapter("+"));
		final Button numeq = bs[3][4];
		numeq.setText("=");
		numeq.addSelectionListener(new ButtonSelectionAdapter("="));

		m_text = new Text(shell, SWT.NONE | SWT.RIGHT);
		m_text.setBounds(mc_margin, mc_int, mc_width * 6 + mc_int * 5,
				mc_height * 1 + mc_int);

		m_label = new Text(shell, SWT.READ_ONLY | SWT.NONE | SWT.RIGHT);
		m_label.setBounds(mc_margin, mc_int * 2 + mc_height, mc_width * 6
				+ mc_int * 5, mc_height * 1);

		// ------------------------------------------

		shell.layout();
		shell.open();
		// Create and check the event loop
		while (!shell.isDisposed()) {
			if (!display.readAndDispatch())
				display.sleep();
		}
		display.dispose();
	}

	private static class ButtonSelectionAdapter extends SelectionAdapter {
		String m_str;

		public ButtonSelectionAdapter(String str) {
			m_str = str;
		}

		public void widgetSelected(SelectionEvent e) {
			if (m_str.equals("N/A")) {
				m_label.setText("Invalid button.");
			} else {
				m_label.setText("");

				if (m_str.equals("<-")) {
					if (m_input.length() > 0) {
						m_input = m_input.substring(0, m_input.length() - 1);
					}
				} else if (m_str.equals("X")) {
					m_input = "";
				} else if (m_str.equals("+")) {
					m_input += " + ";
				} else if (m_str.equals("-")) {
					m_input += " - ";
				} else if (m_str.equals("*")) {
					m_input += " * ";
				} else if (m_str.equals("/")) {
					m_input += " / ";
				} else if (m_str.equals("=")) {
					Calculator calc = new Calculator();
					double ret = calc.evaluate(m_text.getText());
					m_input = "" + ret;
				} 
				else {
					m_input += m_str;
				}
				m_text.setText(m_input);
			}

		}
	}
}
