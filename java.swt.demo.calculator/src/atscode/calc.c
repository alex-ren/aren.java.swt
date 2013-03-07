/*
 * calculator_lib.c
 *
 *  Created on: Mar 4, 2013
 *      Author: aren
 */

#include <stdio.h>
#include "aren_java_swt_demo_Calculator.h"

void ats_calc_init();

int ats_calc(const char *str, double *ret);

void ThrowExceptionByClassName(JNIEnv *env, const char *name, const char *message) {
  jclass class = (*env)->FindClass(env, name); //1
  if (class != NULL) {
      (*env)->ThrowNew(env, class, message); //2
  }
  (*env)->DeleteLocalRef(env, class); //3
}


JNIEXPORT jdouble JNICALL Java_aren_java_swt_demo_Calculator_evaluate(JNIEnv *env, jclass jcls, jstring input) {

	ats_calc_init();

	const jbyte *str;
	str = (*env)->GetStringUTFChars(env, input, NULL);
	double v = 0;
	int ret = ats_calc(str, &v);

	(*env)->ReleaseStringUTFChars(env, input, str);
	if (ret != 0)
	{
		ThrowExceptionByClassName(env,"java/lang/IllegalArgumentException","Parsing Error.");
		return 1.7;
	}
	else
	{
		return v;
	}
}

