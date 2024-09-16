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

### Configure Offerwall

Before launching the Offerwall or checking rewards, you need to configure it using the `configure` method. Provide the API key and user ID.

```dart
Future<void> initOfferwall() async {
  try {
    await _offerwallPlugin.configure(
      apiKey: 'your_api_key', 
      userId: 'your_user_id'
    );
  } on PlatformException catch (e) {
    print('configure error: $e');
  }
}
```

### Launch Offerwall

To display the Offerwall, call the `launch` method after configuration.

```dart
ElevatedButton(
  onPressed: () => _offerwallPlugin.launch(),
  child: const Text('Launch Offerwall'),
)
```

### Check for Rewards

You can check for any available rewards by calling the `checkReward` function. It returns a list of offers and the reward amount.

```dart
Future<void> _checkRewards() async {
  try {
    final checkReward = await _offerwallPlugin.checkReward();
    if (checkReward.offers.isNotEmpty) {
      print('checkReward: reward: ${checkReward.reward}');
    }
  } on PlatformException catch (e) {
    print('checkReward error: $e');
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
          print('checkReward: reward: ${checkReward.reward}');
        }
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('checkReward error: $e');
      }
    }
  }

  Future<void> initOfferwall() async {
    try {
      await _offerwallPlugin.configure(
          apiKey: 'wpvnaqodiv6lc9nsm6mw16ds8yo5x1', userId: 'Revlum');
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('configure error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Running on:'),
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
