import 'package:audio_challenge/src/feature/audio_player/data/datasource/audio_player_datasource.dart';
import 'package:audio_challenge/src/feature/audio_player/model/transcript.dart';
import 'package:just_audio/just_audio.dart';

abstract interface class AudioPlayerRepository {
  Stream<Duration> get positionStream;
  Transcript? get transcript;
  int get currentPhraseIndex;
  List<Phrase> get interleavedPhrases;
  Future<void> playAudio();
  Future<void> pauseAudio();
  Future<void> loadAudio({
    required String audioUrl,
    required String audioTranscriptUrl,
  });
  Future<void> seekToNextPhrase();
  Future<void> seekToPreviousPhrase();
}

final class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  AudioPlayerRepositoryImpl({
    required AudioPlayerDatasource audioPlayerDatasource,
    required AudioPlayer audioPlayer,
  })  : _audioPlayerDatasource = audioPlayerDatasource,
        _audioPlayer = audioPlayer;

  final AudioPlayerDatasource _audioPlayerDatasource;
  final AudioPlayer _audioPlayer;

  Transcript? _transcript;
  int _currentPhraseIndex = 0;
  List<Phrase>? _interleavedPhrases;

  @override
  int get currentPhraseIndex => _currentPhraseIndex;

  @override
  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  @override
  Transcript? get transcript => _transcript;

  @override
  Future<void> loadAudio({
    required String audioUrl,
    required String audioTranscriptUrl,
  }) async {
    await _audioPlayer.setAsset(audioUrl);
    _transcript =
        await _audioPlayerDatasource.getTranscript(audioTranscriptUrl);
  }

  @override
  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> playAudio() async {
    await _audioPlayer.play();
  }

  @override
  Future<void> seekToNextPhrase() async {
    if (_currentPhraseIndex > 0) {
      _currentPhraseIndex -= 1;
      await _seekToPhrase(_currentPhraseIndex);
    }
  }

  @override
  Future<void> seekToPreviousPhrase() async {
    if (_currentPhraseIndex < interleavedPhrases.length - 1) {
      _currentPhraseIndex += 1;
      await _seekToPhrase(_currentPhraseIndex);
    }
  }

  @override
  List<Phrase> get interleavedPhrases {
    _interleavedPhrases ??= _computeInterleavedPhrases();

    return _interleavedPhrases!;
  }

  Future<void> _seekToPhrase(int index) async {
    if (_transcript != null) {
      int totalDuration = 0; // in milliseconds
      for (int i = 0; i < index; i++) {
        totalDuration += interleavedPhrases[i].time + _transcript!.pause;
      }
      await _audioPlayer.seek(Duration(milliseconds: totalDuration));
    }
  }

  List<Phrase> _computeInterleavedPhrases() {
    final speakers = _transcript?.speakers;

    if (speakers == null) return [];

    final List<Phrase> interleavedPhrases = [];

    int maxPhrasesCount = speakers
        .map((speaker) => speaker.phrases.length)
        .reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < maxPhrasesCount; i++) {
      for (var speaker in speakers) {
        if (i < speaker.phrases.length) {
          interleavedPhrases.add(speaker.phrases[i]);
        }
      }
    }

    return interleavedPhrases;
  }
}
