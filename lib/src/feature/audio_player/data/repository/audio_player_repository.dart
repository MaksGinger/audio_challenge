import 'package:audio_challenge/src/feature/audio_player/data/datasource/audio_player_datasource.dart';
import 'package:audio_challenge/src/feature/audio_player/model/transcript.dart';
import 'package:just_audio/just_audio.dart';

abstract interface class AudioPlayerRepository {
  Stream<Duration> get positionStream;
  Transcript? get transcript;
  List<Phrase> get interleavedPhrases;
  Future<void> playAudio();
  Future<void> pauseAudio();
  Future<void> loadAudio({
    required String audioUrl,
    required String audioTranscriptUrl,
  });
  Future<int> seekToNextPhrase(int index);
  Future<int> seekToPreviousPhrase(int index);
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
  List<Phrase>? _interleavedPhrases;

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
    await _audioPlayer.setLoopMode(LoopMode.all);
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
  Future<int> seekToNextPhrase(int index) async {
    if (index < interleavedPhrases.length - 1) {
      index += 1;
      await _seekToPhrase(index);
    }
    return index;
  }

  @override
  Future<int> seekToPreviousPhrase(int index) async {
    if (index > 0) {
      index -= 1;

      await _seekToPhrase(index);
    }
    return index;
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
