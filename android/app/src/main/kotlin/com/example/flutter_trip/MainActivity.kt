package com.example.flutter_trip

import android.os.Bundle;
//import com.example.plugin.asr.AsrPlugin


import io.flutter.app.FlutterActivity;
//import org.devio.flutter.splashscreen.flutter_splash_screen.SplashScreen
import io.flutter.plugins.GeneratedPluginRegistrant;


class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // 因为这个插件好像有点问题 启动屏无法关闭 所以暂时不显示启动屏
        // SplashScreen.show(this, true)
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        registerSelfPlugin()
    }

    private fun registerSelfPlugin() {
//        AsrPlugin.registerWith(registrarFor("com.example.plugin.asr.AsrPlugin"))
    }
}
