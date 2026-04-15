import 'dart:convert';
import 'package:http/http.dart' as http;

/// Simple API client wrapper for GET requests.
class ApiClient {
  /// Creates [ApiClient].
  ApiClient(this._client);

  final http.Client _client;

  /// Performs a GET request and returns decoded JSON map.
  Future<Map<String, dynamic>> getJson(Uri uri) async {
    final http.Response response = await _client.get(uri);
    return json.decode(response.body) as Map<String, dynamic>;
  }
}

