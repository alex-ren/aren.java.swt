/*
 * calculator_lib.c
 *
 *  Created on: Mar 4, 2013
 *      Author: aren
 */

#include <stdio.h>
#include "aren_java_swt_demo_Calculator.h"

int atsadd(int x, int y);

double atscalc(const char *str);

JNIEXPORT jdouble JNICALL Java_aren_java_swt_demo_Calculator_evaluate(JNIEnv *env, jobject jobj, jstring input) {

	const jbyte *str;
	str = (*env)->GetStringUTFChars(env, input, NULL);
	double ret = atscalc(str);
	// double ret = atsadd(3, 4);

	(*env)->ReleaseStringUTFChars(env, input, str);
	return ret;
}

