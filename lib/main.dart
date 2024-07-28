import 'package:audio_challenge/src/app.dart';
import 'package:audio_challenge/src/common/constant/asset_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final jsonString = await rootBundle.loadString(AssetRef.exampleJson.path);
  runApp(const App());
}
