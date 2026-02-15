import Cocoa
import FlutterMacOS

public class PathProviderMasterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "path_provider_master", binaryMessenger: registrar.messenger)
    let instance = PathProviderMasterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getTemporaryDirectory":
      result(NSTemporaryDirectory())
      
    case "getApplicationSupportDirectory":
      let paths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
      result(paths.first)
      
    case "getLibraryDirectory":
      let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
      result(paths.first)
      
    case "getApplicationDocumentsDirectory":
      let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
      result(paths.first)
      
    case "getExternalStorageDirectory":
      // macOS external storage ندارد
      result(nil)
      
    case "getExternalCacheDirectories":
      // macOS external cache directories ندارد
      result(nil)
      
    case "getExternalStorageDirectories":
      // macOS external storage directories ندارد
      result(nil)
      
    case "getDownloadsDirectory":
      let paths = NSSearchPathForDirectoriesInDomains(.downloadsDirectory, .userDomainMask, true)
      result(paths.first)
      
    case "getPublicPicturesDirectory":
      let paths = NSSearchPathForDirectoriesInDomains(.picturesDirectory, .userDomainMask, true)
      result(paths.first)
      
    case "getPublicVideosDirectory":
      let paths = NSSearchPathForDirectoriesInDomains(.moviesDirectory, .userDomainMask, true)
      result(paths.first)
      
    case "getPublicMusicDirectory":
      let paths = NSSearchPathForDirectoriesInDomains(.musicDirectory, .userDomainMask, true)
      result(paths.first)
      
    case "getPublicDownloadsDirectory":
      let paths = NSSearchPathForDirectoriesInDomains(.downloadsDirectory, .userDomainMask, true)
      result(paths.first)
      
    case "getPublicDocumentsDirectory":
      let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
      result(paths.first)
      
    case "getPublicDCIMDirectory":
      // macOS DCIM directory ندارد
      result(nil)
      
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
