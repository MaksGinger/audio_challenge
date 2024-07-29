import 'package:audio_challenge/src/feature/audio_player/data/repository/audio_player_repository.dart';

final class AppDependencies {
  final AudioPlayerRepository audioPlayerRepository;

  const AppDependencies({required this.audioPlayerRepository});
}
