#include<jni.h>
#include<iostream>

extern "C" {

JNIEXPORT jint
JNICALL
Java_com_example_flutter_1with_1native_1code_NativeLibrary_00024Companion_getRandom(JNIEnv *env,
                                                                                    jobject obj) {
    return rand() % 100 + 1;
}

JNIEXPORT jint
JNICALL
Java_com_example_flutter_1with_1native_1code_NativeLibrary_00024Companion_displaySum(JNIEnv *env,
                                                                                     jobject obj) {
    int first_number = 7;
    int second_number = 7;
    int total = first_number + second_number;

    return total;
}

}