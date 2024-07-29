import 'package:audio_challenge/src/feature/audio_player/bloc/audio_player_bloc.dart';
import 'package:audio_challenge/src/feature/audio_player/widget/audio_player_screen.dart';
import 'package:audio_challenge/src/feature/init/model/app_dependencies.dart';
import 'package:audio_challenge/src/feature/init/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final AppDependencies dependencies;

  const App({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: dependencies,
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            return BlocProvider(
              create: (context) => AudioPlayerBloc(
                audioPlayerRepository:
                    DependenciesScope.of(context).audioPlayerRepository,
              ),
              child: const AudioPlayerScreen(),
            );
          },
        ),
      ),
    );
  }
}
