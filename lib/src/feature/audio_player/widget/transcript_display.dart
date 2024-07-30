import 'package:audio_challenge/src/feature/audio_player/model/transcript.dart';
import 'package:flutter/material.dart';

class TranscriptDisplay extends StatelessWidget {
  final Transcript transcript;
  final int currentPhraseIndex;
  final List<Phrase> interleavedPhrases;

  const TranscriptDisplay({
    super.key,
    required this.transcript,
    required this.currentPhraseIndex,
    required this.interleavedPhrases,
  });

  @override
  Widget build(BuildContext context) {
    List<Phrase> allPhrases =
        transcript.speakers.expand((speaker) => speaker.phrases).toList();

    return Center(
      child: ListView.builder(
        itemCount: allPhrases.length,
        itemBuilder: (context, index) {
          final phrase = allPhrases[index];
          final isCurrentPhrase =
              phrase == interleavedPhrases[currentPhraseIndex];

          return ListTile(
            title: Center(
              child: Text(
                phrase.words,
                style: TextStyle(
                  fontWeight:
                      isCurrentPhrase ? FontWeight.bold : FontWeight.normal,
                  color: isCurrentPhrase ? Colors.green : Colors.black,
                ),
              ),
            ),
            subtitle: Center(
              child: Text(transcript.speakers
                  .firstWhere((s) => s.phrases.contains(phrase))
                  .name),
            ),
          );
        },
      ),
    );
  }
}
