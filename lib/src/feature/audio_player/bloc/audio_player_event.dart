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
  bool operator ==(covariant _LoadAudio other) {
    if (identical(this, other)) return true;

    return other.audioUrl == audioUrl &&
        other.audioTranscriptionUrl == audioTranscriptionUrl;
  }

  @override
  int get hashCode => audioUrl.hashCode ^ audioTranscriptionUrl.hashCode;
}

final class _PlayAudio extends AudioPlayerEvent {
  const _PlayAudio();
}

final class _PauseAudio extends AudioPlayerEvent {
  const _PauseAudio();
}

final class _RewindAudio extends AudioPlayerEvent {
  const _RewindAudio();
}

final class _ForwardAudio extends AudioPlayerEvent {
  const _ForwardAudio();
}

final class _UpdateCurrentPhrase extends AudioPlayerEvent {
  final Duration position;

  const _UpdateCurrentPhrase({required this.position});
}
