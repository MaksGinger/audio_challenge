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
    required List<Phrase> interleavedPhrases,
  }) = AudioPlayerReady;

  const factory AudioPlayerState.error({required String message}) =
      AudioPlayerError;
}

final class AudioPlayerInitial extends AudioPlayerState {
  const AudioPlayerInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is AudioPlayerInitial;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

final class AudioPlayerLoading extends AudioPlayerState {
  const AudioPlayerLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is AudioPlayerLoading;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

final class AudioPlayerReady extends AudioPlayerState {
  final Transcript transcript;
  final int currentPhraseIndex;
  final bool isPlaying;
  final List<Phrase> interleavedPhrases;

  const AudioPlayerReady({
    required this.transcript,
    required this.currentPhraseIndex,
    required this.isPlaying,
    required this.interleavedPhrases,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AudioPlayerReady &&
        other.transcript == transcript &&
        other.currentPhraseIndex == currentPhraseIndex &&
        other.isPlaying == isPlaying &&
        other.interleavedPhrases == interleavedPhrases;
  }

  @override
  int get hashCode =>
      transcript.hashCode ^
      currentPhraseIndex.hashCode ^
      isPlaying.hashCode ^
      interleavedPhrases.hashCode;

  AudioPlayerReady copyWith({
    Transcript? transcript,
    int? currentPhraseIndex,
    bool? isPlaying,
    List<Phrase>? interleavedPhrases,
  }) {
    return AudioPlayerReady(
      transcript: transcript ?? this.transcript,
      currentPhraseIndex: currentPhraseIndex ?? this.currentPhraseIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      interleavedPhrases: interleavedPhrases ?? this.interleavedPhrases,
    );
  }

  @override
  String toString() {
    return 'AudioPlayerReady(transcript: $transcript, currentPhraseIndex: $currentPhraseIndex, isPlaying: $isPlaying, interleavedPhrases: $interleavedPhrases)';
  }
}

final class AudioPlayerError extends AudioPlayerState {
  final String message;

  const AudioPlayerError({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AudioPlayerError && other.message == message;
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
