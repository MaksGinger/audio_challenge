import 'package:meta/meta.dart';

@immutable
final class Transcript {
  final int pause;
  final List<Speaker> speakers;

  const Transcript({required this.pause, required this.speakers});

  factory Transcript.fromJson(Map<String, dynamic> json) {
    return Transcript(
      pause: json['pause'],
      speakers: (json['speakers']).map((e) => Speaker.fromJson(e)).toList(),
    );
  }
}

@immutable
final class Speaker {
  final String name;
  final List<Phrase> phrases;

  const Speaker({required this.name, required this.phrases});

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      name: json['name'],
      phrases: (json['phrases']).map((e) => Phrase.fromJson(e)).toList(),
    );
  }
}

@immutable
final class Phrase {
  final String words;
  final int time;

  const Phrase({required this.words, required this.time});

  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(
      words: json['words'],
      time: json['time'],
    );
  }
}
