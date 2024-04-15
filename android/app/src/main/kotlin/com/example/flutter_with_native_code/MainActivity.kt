package com.example.flutter_with_native_code

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle

class MainActivity : FlutterActivity() {

    private val CHANNEL = "your_channel_name"

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        MethodChannel(
            flutterEngine!!.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getRandom") {
                val random = NativeLibrary.getRandom()
                result.success(random)
            } else if (call.method == "displaySum") {
                val sum = NativeLibrary.displaySum()
                result.success(sum)
            } else {
                result.notImplemented()
            }
        }
    }

}