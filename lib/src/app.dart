import 'package:audio_challenge/src/common/constant/asset_ref.dart';
import 'package:audio_challenge/src/feature/audio_player/bloc/audio_player_bloc.dart';
import 'package:audio_challenge/src/feature/audio_player/widget/audio_player_screen.dart';
import 'package:audio_challenge/src/feature/init/model/app_dependencies.dart';
import 'package:audio_challenge/src/feature/init/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final AppDependencies dependencies;

  const App({super.key, required this.dependencies});

  Future<String> _loadTranscript(BuildContext context) async {
    return await DefaultAssetBundle.of(context)
        .loadString(AssetRef.exampleJson.path);
  }

  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: dependencies,
      child: MaterialApp(
        home: FutureBuilder(
          future: _loadTranscript(context),
          builder: (context, snapshot) {
            return switch ((snapshot.connectionState, snapshot.data)) {
              (ConnectionState.done, final transcriptionJson?) => BlocProvider(
                  create: (context) => AudioPlayerBloc(
                    audioPlayerRepository:
                        DependenciesScope.of(context).audioPlayerRepository,
                  )..add(
                      AudioPlayerEvent.loadAudio(
                        audioUrl: AssetRef.exampleAudio.path,
                        audioTranscriptionUrl: transcriptionJson,
                      ),
                    ),
                  child: const AudioPlayerScreen(),
                ),
              _ => const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
