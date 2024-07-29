import 'dart:async';
import 'dart:developer' as dev;

import 'package:audio_challenge/src/app.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(
    () async {
      FlutterError.onError = (details) {
        dev.log(
          'Flutter Error',
          error: details.exceptionAsString(),
          stackTrace: details.stack,
        );
      };
      runApp(const App());
    },
    (error, stackTrace) {
      // capture errors e.g. to crashlytics or sentry
      dev.log('App Error', error: error, stackTrace: stackTrace);
    },
  );
}
