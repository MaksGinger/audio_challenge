import 'dart:developer' as dev;

import 'package:audio_challenge/src/app.dart';
import 'package:audio_challenge/src/common/http_client/fake_http_client.dart';
import 'package:audio_challenge/src/feature/audio_player/data/datasource/audio_player_datasource.dart';
import 'package:audio_challenge/src/feature/audio_player/data/repository/audio_player_repository.dart';
import 'package:audio_challenge/src/feature/init/model/app_dependencies.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

final class Initializer {
  const Initializer();

  Future<void> initializeAndRunApp() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    binding.deferFirstFrame();

    FlutterError.onError = (details) {
      dev.log(
        'Flutter Error',
        error: details.exceptionAsString(),
        stackTrace: details.stack,
      );
    };

    WidgetsBinding.instance.platformDispatcher.onError = (error, stackTrace) {
      dev.log(
        'Platform Error',
        error: error.toString(),
        stackTrace: stackTrace,
      );
      return true;
    };

    final fakeHttpClient = FakeHttpClient();
    final audioPlayerDatasource =
        AudioPlayerDatasourceImpl(fakeHttpClient: fakeHttpClient);
    final audioPlayer = AudioPlayer();
    final audioPlayerRepository = AudioPlayerRepositoryImpl(
      audioPlayer: audioPlayer,
      audioPlayerDatasource: audioPlayerDatasource,
    );

    final appDependencies = AppDependencies(
      audioPlayerRepository: audioPlayerRepository,
    );

    runApp(App(dependencies: appDependencies));

    binding.allowFirstFrame();
  }
}
