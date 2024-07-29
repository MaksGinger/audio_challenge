import 'package:audio_challenge/src/feature/audio_player/bloc/audio_player_bloc.dart';
import 'package:audio_challenge/src/feature/audio_player/widget/control_buttons.dart';
import 'package:audio_challenge/src/feature/audio_player/widget/transcript_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player Challenge'),
      ),
      body: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          return switch (state) {
            AudioPlayerInitial() || AudioPlayerLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            AudioPlayerReady(
              :final transcript,
              :final currentPhraseIndex,
            ) =>
              Column(
                children: [
                  Expanded(
                    child: TranscriptDisplay(
                      transcript: transcript,
                      currentPhraseIndex: currentPhraseIndex,
                    ),
                  ),
                  const ControlButtons(),
                ],
              ),
            AudioPlayerError(:final message) => Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          };
        },
      ),
    );
  }
}
