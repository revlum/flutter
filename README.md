# Revlum Offerwall Plugin

[![pub package](https://img.shields.io/pub/v/revlum_offerwall.svg)](https://pub.dev/packages/revlum_offerwall)

The Revlum Offerwall Plugin is a Flutter plugin that wraps the native Revlum Offerwall SDK implementations for both Android and iOS. For more details on the native implementations, you can refer to the official documentation for [iOS](https://developer.revlum.com/docs/ios) and [Android](https://developer.revlum.com/docs/revlum-android-sdk).

|             | Android | iOS   |
|-------------|---------|-------|
| **Support** | minSdk 24 | iOS 16.0+ |

## Setup

### Android

1. **Minimum SDK Requirement:**
   Ensure that your Android `minSdkVersion` is set to 24 or higher.

2. **Add Revlum Maven Repository:**
   In your Android project, navigate to your `android/build.gradle` file and ensure that the Revlum Maven repository is added under the `allprojects` section. It should look like this:

```gradle
allprojects {
    repositories {
        maven {
            url = uri("https://sdk-revlum-android.s3.amazonaws.com/")
            content {
                includeGroup("com.revlum")
            }
        }
        google()
        mavenCentral()
    }
}
```

### iOS

1. **Modify AppDelegate.swift:**
   In your `AppDelegate.swift`, update the file to set up a navigation controller. Modify your code to look like this:

```swift
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
```

## Usage

For a more elaborate usage example, see the [example project](https://pub.dev/packages/revlum_offerwall/example).
