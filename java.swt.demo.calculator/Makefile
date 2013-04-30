
.PHONY: all gui jni atslib

atsdir := ./src/atscode
javadir := ./src/aren/java/swt/demo
javabindir := ./bin

javasrc := $(javadir)/CalculatorGui.java $(javadir)/Calculator.java
jniheader := $(atsdir)/aren_java_swt_demo_Calculator.h

jniclass := aren.java.swt.demo.Calculator
jniclassfile := $(jniclass).class


all: gui atslib

gui: $(javabindir)/aren/java/swt/demo/CalculatorGui.class

$(javabindir)/aren/java/swt/demo/CalculatorGui.class: $(javasrc)
	javac -classpath "src":"../org.eclipse.swt/swt.jar" $(javadir)/CalculatorGui.java -d ./bin

$(jniheader): $(javabindir)/aren/java/swt/demo/Calculator.class
	javah -force -classpath $(javabindir) -d $(atsdir) $(jniclass) 

$(javabindir)/aren/java/swt/demo/$(jniclassfile): $(javasrc)
	javac -classpath "src" $(javadir)/Calculator.java -d ./bin


clean:
	make -C ./src/atscode clean
	find ./bin -name "*.class" -exec rm -rf {} \;
	rm -rf ./src/atscode/aren_java_swt_demo_Calculator.h

.PHONY: check-atsenv
check-atsenv:
ifndef ATSHOME
$(error ATSHOME is undefined.)
endif
ifeq ($(wildcard $(ATSHOME)/bin/atscc), )
$(error ATSHOME is not correct.)
endif

atslib: $(jniheader) check-atsenv
	make -C ./src/atscode all


test: check-atsenv
	export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${ATSHOME}/ccomp/lib64; \
java -classpath ../org.eclipse.swt/swt.jar:./bin/ -Djava.library.path=./src/atscode aren.java.swt.demo.CalculatorGui


