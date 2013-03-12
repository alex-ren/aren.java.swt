export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${ATSHOME}/ccomp/lib64

java -classpath ../org.eclipse.swt/swt.jar:./bin/ -Djava.library.path=./src/atscode aren.java.swt.demo.CalculatorGui

