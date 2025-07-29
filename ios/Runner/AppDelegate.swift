import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     GeneratedPluginRegistrant.register(with: self)
    
    // Register custom haptics plugin (iOS 13.0+)
    if #available(iOS 13.0, *) {
      SwiftCustomHapticsPlugin.register(with: registrar(forPlugin: "SwiftCustomHapticsPlugin")!)
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
