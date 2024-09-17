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
      if (kDebugMode) {
        print('checkReward: reward: ${checkReward.reward}');
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
          apiKey: 'wpvnaqodiv6lc9nsm6mw16ds8yo5x1',
          userId: 'Revlum',
          subId: null);
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
          child: ElevatedButton(
            onPressed: () => _offerwallPlugin.launch(),
            child: const Text('Launch Offerwall'),
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
