import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jog_inventory/firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../globals/config.dart';


class _Firebase {
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if(config.isReleaseMode){
      /// Pass all uncaught "fatal" errors from the framework to Crashlytics
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

    }
  }
}

var FirebaseCreds = _Firebase();
