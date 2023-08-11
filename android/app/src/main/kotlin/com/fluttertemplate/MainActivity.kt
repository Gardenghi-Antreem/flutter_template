package com.gellify.flutter_template

import io.flutter.embedding.android.FlutterActivity
import com.fluttertemplate.pigeon.*
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger

private class NativeSideApiImpl() : NativeSideApi {
  override fun callNativeSide(): String {
    return "native side called successfully";
  }
}

private class PigeonFlutterApi() {
  var nativeResponse: FlutterSideApi? = null

  constructor(binaryMessenger: BinaryMessenger) : this() {
    nativeResponse = FlutterSideApi(binaryMessenger)
  }

  fun callFlutterMethod(aString: String?, callback: (Result<Unit>) -> Unit) {
    nativeResponse!!.callFlutterApp(aString) {
    callback(Result.success(Unit))
    }
  }
}


class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    val softwareKeyboardUtils = NativeSideApiImpl()
    NativeSideApi.setUp(flutterEngine.dartExecutor.binaryMessenger, softwareKeyboardUtils)

    val pigeonFlutterApi = PigeonFlutterApi(flutterEngine.dartExecutor.binaryMessenger)
    //exemple how to use
    // pigeonFlutterApi.callFlutterMethod(null){
    //   callState ->
    //   println("Calling onPrintEnd: $callState")
    // }
}
}
