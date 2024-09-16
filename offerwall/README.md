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

### 1. Configure the Offerwall

Before launching the Offerwall or checking for rewards, configure the SDK by calling the `Offerwall.configure` method. You need to provide the API key and an optional user ID. If you do not provide a user ID, the SDK will automatically generate one, which will be used unless a new user ID is provided.

```dart
import 'package:offerwall/offerwall.dart';

Future<void> initOfferwall() async {
  try {
    await _offerwallPlugin.configure(
      apiKey: 'your_api_key', 
      userId: 'your_user_id'
    );
  } on PlatformException catch (e) {
    print('Error during Offerwall configuration: $e');
  }
}
```

### 2. Launch the Offerwall

After configuring the SDK, you can launch the Offerwall using the `Offerwall.launch` method. This method does not require additional parameters if the SDK has been correctly configured.

```dart
ElevatedButton(
  onPressed: () => _offerwallPlugin.launch(),
  child: const Text('Launch Offerwall'),
)
```

### 3. Check for rewards

To check if the user has earned any rewards, use the `checkReward` method. This method provides a list of offers and the total reward amount. If there are no rewards, the reward value will be 0.

```dart
Future<void> _checkRewards() async {
  try {
    final checkReward = await _offerwallPlugin.checkReward();
    if (checkReward.offers.isNotEmpty) {
      print('Reward available: ${checkReward.reward}');
    }
  } on PlatformException catch (e) {
    print('Error during reward check: $e');
  }
}
```

### Full Example

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:offerwall/offerwall.dart';

void main() {
   runApp(const MyApp());
}

class MyApp extends StatefulWidget {
   const MyApp({super.key});

   @override
   State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   final _offerwallPlugin = Offerwall();
   late final AppLifecycleListener _listener;

   @override
   void initState() {
      super.initState();
      initOfferwall();
      _listener = AppLifecycleListener(
         onResume: () => _checkRewards(),
      );
   }

   Future<void> _checkRewards() async {
      try {
         final checkReward = await _offerwallPlugin.checkReward();
         if (checkReward.offers.isNotEmpty) {
            if (kDebugMode) {
               print('Reward available: ${checkReward.reward}');
            }
         }
      } on PlatformException catch (e) {
         if (kDebugMode) {
            print('Reward check failed: $e');
         }
      }
   }

   Future<void> initOfferwall() async {
      try {
         await _offerwallPlugin.configure(
                 apiKey: 'wpvnaqodiv6lc9nsm6mw16ds8yo5x1', userId: 'Revlum');
      } on PlatformException catch (e) {
         if (kDebugMode) {
            print('Offerwall configuration failed: $e');
         }
      }
   }

   @override
   Widget build(BuildContext context) {
      return MaterialApp(
         home: Scaffold(
            appBar: AppBar(
               title: const Text('Offerwall Plugin Example'),
            ),
            body: Center(
               child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     const Text('Welcome to Revlum Offerwall'),
                     const SizedBox(height: 20),
                     ElevatedButton(
                        onPressed: () => _offerwallPlugin.launch(),
                        child: const Text('Launch Offerwall'),
                     ),
                  ],
               ),
            ),
         ),
      );
   }

   @override
   void dispose() {
      _listener.dispose();
      super.dispose();
   }
}
```

For a more elaborate usage example, see the [example project](https://pub.dev/packages/revlum_offerwall/example).
