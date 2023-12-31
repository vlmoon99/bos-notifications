import UIKit

import Flutter
import flutter_local_notifications
import Firebase



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure() 
    GeneratedPluginRegistrant.register(with: self)
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)
  }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


}
