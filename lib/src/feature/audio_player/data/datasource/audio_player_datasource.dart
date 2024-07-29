import 'package:audio_challenge/src/common/http_client/fake_http_client.dart';
import 'package:audio_challenge/src/feature/audio_player/model/transcript.dart';

abstract interface class AudioPlayerDatasource {
  Future<Transcript> getTranscript(String transcriptUrl);
}

final class AudioPlayerDatasourceImpl implements AudioPlayerDatasource {
  AudioPlayerDatasourceImpl({required FakeHttpClient fakeHttpClient})
      : _fakeHttpClient = fakeHttpClient;

  final FakeHttpClient _fakeHttpClient;

  @override
  Future<Transcript> getTranscript(String transcriptUrl) async {
    final transcriptMap = await _fakeHttpClient.get(transcriptUrl);
    return Transcript.fromJson(transcriptMap);
  }
}
