import 'package:pigeon/pigeon.dart';

//the implementation of this app is in the native side: AppDelegate.swift, MainActivity.kt
@HostApi()
abstract class NativeSideApi {
  String callNativeSide();
}

// the native side can call this method to get info from the flutter side or to send info about and async thread process to the flutter side
@FlutterApi()
abstract class FlutterSideApi {
  void callFlutterApp(String? error);
}

////////////////////// exemple how to use the flutter api ////////////////////////////
/// first we implement a response listener or a class that return some information to the native side 
/// if we want to return someting to the native side we need to retyrb it in the method

// class ResponseListener extends FlutterSideApi {
//   ResponseListener({this.action});
//   final void Function(String? error)? action;
//   @override
//   void callFlutterApp(String? error) {
//     action?.call(error);
//   }
// }

/// then we can use it like this, one it is set up every time the native side call the method callFlutterApp it will call the action
//  ZebraResponse.setup(PrinterResponseListener(action: onPrintEndAction));
