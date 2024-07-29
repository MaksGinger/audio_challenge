part of 'audio_player_bloc.dart';

@immutable
sealed class AudioPlayerEvent {
  const AudioPlayerEvent();

  const factory AudioPlayerEvent.loadAudio({
    required String audioUrl,
    required String audioTranscriptionUrl,
  }) = _LoadAudio;

  const factory AudioPlayerEvent.playAudio() = _PlayAudio;

  const factory AudioPlayerEvent.pauseAudio() = _PauseAudio;

  const factory AudioPlayerEvent.rewindAudio() = _RewindAudio;

  const factory AudioPlayerEvent.forwardAudio() = _ForwardAudio;
}

final class _LoadAudio extends AudioPlayerEvent {
  final String audioUrl;
  final String audioTranscriptionUrl;

  const _LoadAudio({
    required this.audioUrl,
    required this.audioTranscriptionUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _LoadAudio &&
        other.audioUrl == audioUrl &&
        other.audioTranscriptionUrl == audioTranscriptionUrl;
  }

  @override
  int get hashCode => audioUrl.hashCode ^ audioTranscriptionUrl.hashCode;
}

final class _PlayAudio extends AudioPlayerEvent {
  const _PlayAudio();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is _PlayAudio;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

final class _PauseAudio extends AudioPlayerEvent {
  const _PauseAudio();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is _PauseAudio;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

final class _RewindAudio extends AudioPlayerEvent {
  const _RewindAudio();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is _RewindAudio;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

final class _ForwardAudio extends AudioPlayerEvent {
  const _ForwardAudio();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is _ForwardAudio;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

final class _UpdateCurrentPhrase extends AudioPlayerEvent {
  final Duration position;

  const _UpdateCurrentPhrase({required this.position});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _UpdateCurrentPhrase && other.position == position;
  }

  @override
  int get hashCode => position.hashCode;
}
