import Flutter
import UIKit

public class MojoTestPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mojo_test", binaryMessenger: registrar.messenger())
    let instance = MojoTestPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
