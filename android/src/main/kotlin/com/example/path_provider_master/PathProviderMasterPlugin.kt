package com.example.path_provider_master

import android.content.Context
import android.os.Build
import android.os.Environment
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

class PathProviderMasterPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "path_provider_master")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getTemporaryDirectory" -> {
        result.success(context.cacheDir.absolutePath)
      }
      "getApplicationSupportDirectory" -> {
        result.success(context.filesDir.absolutePath)
      }
      "getLibraryDirectory" -> {
        // اندروید Library directory ندارد
        result.success(null)
      }
      "getApplicationDocumentsDirectory" -> {
        val dir = context.getDir("documents", Context.MODE_PRIVATE)
        result.success(dir.absolutePath)
      }
      "getExternalStorageDirectory" -> {
        val dir = context.getExternalFilesDir(null)
        result.success(dir?.absolutePath)
      }
      "getExternalCacheDirectories" -> {
        val dirs = context.externalCacheDirs
        val paths = dirs?.mapNotNull { it?.absolutePath }
        result.success(paths)
      }
      "getExternalStorageDirectories" -> {
        val dirs = context.getExternalFilesDirs(null)
        val paths = dirs?.mapNotNull { it?.absolutePath }
        result.success(paths)
      }
      "getDownloadsDirectory" -> {
        val dir = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)
        result.success(dir?.absolutePath)
      }
      "getPublicPicturesDirectory" -> {
        val dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)
        result.success(dir?.absolutePath)
      }
      "getPublicVideosDirectory" -> {
        val dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_MOVIES)
        result.success(dir?.absolutePath)
      }
      "getPublicMusicDirectory" -> {
        val dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_MUSIC)
        result.success(dir?.absolutePath)
      }
      "getPublicDownloadsDirectory" -> {
        val dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
        result.success(dir?.absolutePath)
      }
      "getPublicDocumentsDirectory" -> {
        val dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOCUMENTS)
        result.success(dir?.absolutePath)
      }
      "getPublicDCIMDirectory" -> {
        val dir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM)
        result.success(dir?.absolutePath)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
