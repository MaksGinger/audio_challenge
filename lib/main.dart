import 'dart:async';
import 'dart:developer' as dev;

import 'package:audio_challenge/src/feature/init/logic/initializer.dart';

void main() {
  runZonedGuarded(
    () => const Initializer()..initializeAndRunApp(),
    (error, stackTrace) {
      // capture errors e.g. to crashlytics or sentry
      dev.log('App Error', error: error, stackTrace: stackTrace);
    },
  );
}
