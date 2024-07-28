enum AssetRef {
  exampleAudio('example_audio.mp3'),
  exampleJson('example_audio.json');

  final String path;

  const AssetRef(this.path);

  String get assetPath => 'assets/$path';
}
