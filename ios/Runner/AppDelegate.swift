import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var openChannel: FlutterMethodChannel?
  private var pendingOpen: String?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "CatlogOpenFile")
    openChannel = FlutterMethodChannel(
      name: "catlog/openfile",
      binaryMessenger: registrar!.messenger())
    openChannel?.setMethodCallHandler { [weak self] call, result in
      if call.method == "pending" {
        result(self?.pendingOpen)
        self?.pendingOpen = nil
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
  }

  // "Open in cat(a)log" from Files/Signal/Mail hands the bundle here.
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    guard url.isFileURL else { return false }
    let needsAccess = url.startAccessingSecurityScopedResource()
    defer { if needsAccess { url.stopAccessingSecurityScopedResource() } }
    let target = FileManager.default.temporaryDirectory
      .appendingPathComponent("incoming.catsync")
    try? FileManager.default.removeItem(at: target)
    guard (try? FileManager.default.copyItem(at: url, to: target)) != nil else {
      return false
    }
    pendingOpen = target.path
    openChannel?.invokeMethod("open", arguments: target.path)
    return true
  }
}
