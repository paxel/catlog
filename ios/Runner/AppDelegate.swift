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
    excludeCatalogsFromBackup()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // The catalogs live in Application Support, which iCloud would back
  // up by default; the privacy text promises no server, so they stay
  // on the device (the keeper's own backups are the safety net).
  private func excludeCatalogsFromBackup() {
    guard var dir = FileManager.default.urls(
      for: .applicationSupportDirectory, in: .userDomainMask).first else { return }
    try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
    var values = URLResourceValues()
    values.isExcludedFromBackup = true
    try? dir.setResourceValues(values)
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
    // Unique per open: a second file must not overwrite one the app is
    // still about to read; the app deletes it after the import.
    let target = FileManager.default.temporaryDirectory
      .appendingPathComponent("incoming-\(Int(Date().timeIntervalSince1970 * 1000)).catsync")
    guard (try? FileManager.default.copyItem(at: url, to: target)) != nil else {
      return false
    }
    pendingOpen = target.path
    openChannel?.invokeMethod("open", arguments: target.path)
    return true
  }
}
