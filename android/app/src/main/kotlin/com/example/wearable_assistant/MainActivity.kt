package com.example.wearable_assistant

import android.content.Intent
import android.media.AudioDeviceInfo
import android.media.AudioManager
import android.content.Context
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "audio_helper"
    private val BLUETOOTH_CHANNEL = "bluetooth_helper"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "audioOutputAvailable") {
                val type = call.argument<Int>("type") ?: -1
                val available = isAudioOutputAvailable(type)
                result.success(available)
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BLUETOOTH_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openBluetoothSettings") {
                openBluetoothSettings()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun isAudioOutputAvailable(type: Int): Boolean {
        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val devices = audioManager.getDevices(AudioManager.GET_DEVICES_OUTPUTS)
        return devices.any { it.type == type }
    }

    private fun openBluetoothSettings() {
        val intent = Intent(Settings.ACTION_BLUETOOTH_SETTINGS)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
    }
}
