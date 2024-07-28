import 'dart:convert' show json;

final class FakeHttpClient {
  FakeHttpClient({required String jsonString}) : _jsonString = jsonString;

  final String _jsonString;

  Future<Map<String, dynamic>> get() async {
    final jsonResponse = json.decode(_jsonString) as Map<String, dynamic>;
    return jsonResponse;
  }
}
