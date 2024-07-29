part of 'audio_player_bloc.dart';

@immutable
sealed class AudioPlayerState {
  const AudioPlayerState();

  const factory AudioPlayerState.initial() = _AudioPlayerInitial;

  const factory AudioPlayerState.loading() = _AudioPlayerLoading;

  const factory AudioPlayerState.ready({
    required Transcript transcript,
    required int currentPhraseIndex,
    required bool isPlaying,
  }) = _AudioPlayerReady;

  const factory AudioPlayerState.error({required String message}) =
      _AudioPlayerError;
}

final class _AudioPlayerInitial extends AudioPlayerState {
  const _AudioPlayerInitial();
}

final class _AudioPlayerLoading extends AudioPlayerState {
  const _AudioPlayerLoading();
}

final class _AudioPlayerReady extends AudioPlayerState {
  final Transcript transcript;
  final int currentPhraseIndex;
  final bool isPlaying;

  const _AudioPlayerReady({
    required this.transcript,
    required this.currentPhraseIndex,
    required this.isPlaying,
  });

  @override
  bool operator ==(covariant _AudioPlayerReady other) {
    if (identical(this, other)) return true;

    return other.transcript == transcript &&
        other.currentPhraseIndex == currentPhraseIndex &&
        other.isPlaying == isPlaying;
  }

  @override
  int get hashCode =>
      transcript.hashCode ^ currentPhraseIndex.hashCode ^ isPlaying.hashCode;

  _AudioPlayerReady copyWith({
    Transcript? transcript,
    int? currentPhraseIndex,
    bool? isPlaying,
  }) {
    return _AudioPlayerReady(
      transcript: transcript ?? this.transcript,
      currentPhraseIndex: currentPhraseIndex ?? this.currentPhraseIndex,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

final class _AudioPlayerError extends AudioPlayerState {
  final String message;

  const _AudioPlayerError({required this.message});

  @override
  bool operator ==(covariant _AudioPlayerError other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  _AudioPlayerError copyWith({
    String? message,
  }) {
    return _AudioPlayerError(
      message: message ?? this.message,
    );
  }
}
