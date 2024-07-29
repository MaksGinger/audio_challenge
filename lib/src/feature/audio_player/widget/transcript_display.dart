import 'package:audio_challenge/src/feature/audio_player/model/transcript.dart';
import 'package:flutter/material.dart';

class TranscriptDisplay extends StatelessWidget {
  final Transcript transcript;
  final int currentPhraseIndex;

  const TranscriptDisplay({
    super.key,
    required this.transcript,
    required this.currentPhraseIndex,
  });

  @override
  Widget build(BuildContext context) {
    List<Phrase> allPhrases =
        transcript.speakers.expand((speaker) => speaker.phrases).toList();

    return ListView.builder(
      itemCount: allPhrases.length,
      itemBuilder: (context, index) {
        final phrase = allPhrases[index];
        final isCurrentPhrase = index == currentPhraseIndex;

        return ListTile(
          title: Text(
            phrase.words,
            style: TextStyle(
              fontWeight: isCurrentPhrase ? FontWeight.bold : FontWeight.normal,
              color: isCurrentPhrase ? Colors.blue : Colors.black,
            ),
          ),
          subtitle: Text(transcript.speakers
              .firstWhere((s) => s.phrases.contains(phrase))
              .name),
        );
      },
    );
  }
}
