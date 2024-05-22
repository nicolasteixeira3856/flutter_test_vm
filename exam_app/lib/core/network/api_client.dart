import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<dynamic> get(String url) async {
    final response = await client.get(Uri.parse('${dotenv.env['API_URL']}$url'));
    return _handleResponse(response);
  }

  Future<dynamic> post(String url, {required dynamic body}) async {
    final response = await client.post(
      Uri.parse('${dotenv.env['API_URL']}$url'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}