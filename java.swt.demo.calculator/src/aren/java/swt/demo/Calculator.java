package aren.java.swt.demo;

public class Calculator {

	public native double evaluate(String input) throws IllegalArgumentException;
	
	static {System.loadLibrary("CalculatorImpl"); }
}
