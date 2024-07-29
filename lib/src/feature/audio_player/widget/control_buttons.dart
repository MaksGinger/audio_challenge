import 'package:audio_challenge/src/feature/audio_player/bloc/audio_player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlButtons extends StatelessWidget {
  final bool isPlaying;

  const ControlButtons({super.key, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: () => context
              .read<AudioPlayerBloc>()
              .add(const AudioPlayerEvent.rewindAudio()),
        ),
        IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          iconSize: 64.0,
          onPressed: () => context.read<AudioPlayerBloc>().add(
                isPlaying
                    ? const AudioPlayerEvent.pauseAudio()
                    : const AudioPlayerEvent.playAudio(),
              ),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: () => context
              .read<AudioPlayerBloc>()
              .add(const AudioPlayerEvent.forwardAudio()),
        ),
      ],
    );
  }
}
