part of 'audio_player_bloc.dart';

@immutable
sealed class AudioPlayerState {
  const AudioPlayerState();

  const factory AudioPlayerState.initial() = AudioPlayerInitial;

  const factory AudioPlayerState.loading() = AudioPlayerLoading;

  const factory AudioPlayerState.ready({
    required Transcript transcript,
    required int currentPhraseIndex,
    required bool isPlaying,
  }) = AudioPlayerReady;

  const factory AudioPlayerState.error({required String message}) =
      AudioPlayerError;
}

final class AudioPlayerInitial extends AudioPlayerState {
  const AudioPlayerInitial();
}

final class AudioPlayerLoading extends AudioPlayerState {
  const AudioPlayerLoading();
}

final class AudioPlayerReady extends AudioPlayerState {
  final Transcript transcript;
  final int currentPhraseIndex;
  final bool isPlaying;

  const AudioPlayerReady({
    required this.transcript,
    required this.currentPhraseIndex,
    required this.isPlaying,
  });

  @override
  bool operator ==(covariant AudioPlayerReady other) {
    if (identical(this, other)) return true;

    return other.transcript == transcript &&
        other.currentPhraseIndex == currentPhraseIndex &&
        other.isPlaying == isPlaying;
  }

  @override
  int get hashCode =>
      transcript.hashCode ^ currentPhraseIndex.hashCode ^ isPlaying.hashCode;

  AudioPlayerReady copyWith({
    Transcript? transcript,
    int? currentPhraseIndex,
    bool? isPlaying,
  }) {
    return AudioPlayerReady(
      transcript: transcript ?? this.transcript,
      currentPhraseIndex: currentPhraseIndex ?? this.currentPhraseIndex,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

final class AudioPlayerError extends AudioPlayerState {
  final String message;

  const AudioPlayerError({required this.message});

  @override
  bool operator ==(covariant AudioPlayerError other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  AudioPlayerError copyWith({
    String? message,
  }) {
    return AudioPlayerError(
      message: message ?? this.message,
    );
  }
}
