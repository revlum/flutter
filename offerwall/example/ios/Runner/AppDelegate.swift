import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    var navigationController: UINavigationController?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        
        navigationController = UINavigationController(rootViewController: flutterViewController)
        navigationController?.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
