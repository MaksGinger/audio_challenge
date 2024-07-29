import 'dart:convert' show json;

final class FakeHttpClient {
  FakeHttpClient();

  Future<Map<String, dynamic>> get(String jsonString) async {
    final jsonResponse = json.decode(jsonString) as Map<String, dynamic>;
    return jsonResponse;
  }
}
