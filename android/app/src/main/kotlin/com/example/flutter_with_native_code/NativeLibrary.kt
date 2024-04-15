package com.example.flutter_with_native_code

class NativeLibrary {

    companion object {

        init {
            System.loadLibrary("platformTest")
        }

        external fun getRandom(): Int

        external fun displaySum(): Int
    }

}