import 'package:audio_challenge/src/feature/audio_player/data/repository/audio_player_repository.dart';
import 'package:audio_challenge/src/feature/audio_player/model/transcript.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

final class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc({required AudioPlayerRepository audioPlayerRepository})
      : _audioPlayerRepository = audioPlayerRepository,
        super(const AudioPlayerState.initial()) {
    on<AudioPlayerEvent>(
      (event, emit) => switch (event) {
        final _LoadAudio e => _onLoadAudio(e, emit),
        final _PlayAudio e => _onPlayAudio(e, emit),
        final _PauseAudio e => _onPauseAudio(e, emit),
        final _RewindAudio e => _onRewindAudio(e, emit),
        final _ForwardAudio e => _onForwardAudio(e, emit),
        final _UpdateCurrentPhrase e => _onUpdateCurrentPhrase(e, emit),
      },
    );

    _audioPlayerRepository.positionStream.listen((position) {
      add(_UpdateCurrentPhrase(position: position));
    });
  }

  final AudioPlayerRepository _audioPlayerRepository;

  Future<void> _onLoadAudio(
    _LoadAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    emit(const AudioPlayerLoading());
    try {
      await _audioPlayerRepository.loadAudio(
        audioUrl: event.audioUrl,
        audioTranscriptUrl: event.audioTranscriptionUrl,
      );
      if (_audioPlayerRepository.transcript == null) {
        throw Exception('Error while loading transcript');
      }
      emit(
        AudioPlayerReady(
          transcript: _audioPlayerRepository.transcript!,
          currentPhraseIndex: _audioPlayerRepository.currentPhraseIndex,
          isPlaying: false,
        ),
      );
    } catch (e) {
      emit(AudioPlayerError(message: 'Error while loading audio: $e'));
    }
  }

  Future<void> _onPlayAudio(
    _PlayAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state is AudioPlayerReady) {
      await _audioPlayerRepository.playAudio();
      emit((state as AudioPlayerReady).copyWith(isPlaying: true));
    }
  }

  Future<void> _onPauseAudio(
    _PauseAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state is AudioPlayerReady) {
      await _audioPlayerRepository.pauseAudio();
      emit((state as AudioPlayerReady).copyWith(isPlaying: false));
    }
  }

  Future<void> _onRewindAudio(
    _RewindAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state is AudioPlayerReady) {
      await _audioPlayerRepository.seekToPreviousPhrase();
      emit(
        (state as AudioPlayerReady).copyWith(
          currentPhraseIndex: _audioPlayerRepository.currentPhraseIndex,
        ),
      );
    }
  }

  Future<void> _onForwardAudio(
    _ForwardAudio event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state is AudioPlayerReady) {
      await _audioPlayerRepository.seekToNextPhrase();
      emit(
        (state as AudioPlayerReady).copyWith(
          currentPhraseIndex: _audioPlayerRepository.currentPhraseIndex,
        ),
      );
    }
  }

  void _onUpdateCurrentPhrase(
    _UpdateCurrentPhrase event,
    Emitter<AudioPlayerState> emit,
  ) {
    if (state is AudioPlayerReady) {
      final currentState = state as AudioPlayerReady;
      final allPhrases = _audioPlayerRepository.interleavedPhrases;
      int totalDuration = 0;
      for (int i = 0; i < allPhrases.length; i++) {
        totalDuration += allPhrases[i].time + currentState.transcript.pause;
        if (event.position.inMilliseconds < totalDuration) {
          if (currentState.currentPhraseIndex != i) {
            emit(currentState.copyWith(currentPhraseIndex: i));
          }
          break;
        }
      }
    }
  }
}
