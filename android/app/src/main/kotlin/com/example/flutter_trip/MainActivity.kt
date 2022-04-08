package com.example.flutter_trip

import android.os.Bundle;
//import com.example.plugin.asr.AsrPlugin


import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;


class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
//        SplashScreen.show(this, true)
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        registerSelfPlugin()
    }

    private fun registerSelfPlugin() {
//        AsrPlugin.registerWith(registrarFor("com.example.plugin.asr.AsrPlugin"))
    }
}
