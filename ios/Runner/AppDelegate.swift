import UIKit
import Flutter

private class NativeSideApiImpl:NativeSideApi {
  func callNativeSide() -> String {
    return "native side called successfully";
  }
}

private class PigeonFlutterApi {
  var nativeResponse: FlutterSideApi

  init(binaryMessenger: FlutterBinaryMessenger) {
      nativeResponse = FlutterSideApi(binaryMessenger: binaryMessenger)
  }

  func callFlutterMethod(aString aStringArg: String?, completion: @escaping (Result<Void,Error>) -> Void) {
      nativeResponse.callFlutterApp(error: aStringArg) {
          completion(.success(()))
        }
  }
}


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller = window?.rootViewController as! FlutterViewController
    
    let nativeSideApi = NativeSideApiImpl()
    NativeSideApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: nativeSideApi)
      
    var responseApi = PigeonFlutterApi(binaryMessenger: controller.binaryMessenger)
//    self.responseApi.callFlutterMethod(aString: error){callState in
//          print("Calling callFlutterMethod: \(callState)");
//         }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


///////// exemple async thread ///////////

// func asyncThreadFunction(completion: @escaping (_ success: Bool, _ data: String?) -> Void) {
//           DispatchQueue.global(qos: .default).async {
//             do {
//               completion(true, nil)
//             } catch let error {
//                 let errorInfo = error.localizedDescription;
//                  completion(false, errorInfo);
//             }
//         }
//   }

// func callNativeSide() -> String {
//     var errorMessage: String? = nil
//     // execute print in a different thread than the Grafich one
//     self.printOverBluetoothWithGCD() { success, error in
//         self.responseApi.callFlutterMethod(aString: error){callState in
//          print("Calling callFlutterMethod: \(callState)");
//         }
//     }
//     return "thread started";
//   }