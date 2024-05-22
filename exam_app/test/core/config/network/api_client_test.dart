import 'dart:convert';

import 'package:exam_app/core/network/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ApiClient apiClient;
  late MockHttpClient mockHttpClient;

  setUpAll(() async {
    await dotenv.load();
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiClient = ApiClient(client: mockHttpClient);
  });

  group('ApiClient', () {
    test('get should return data when the call to API is successful', () async {
      // Arrange
      const tUrl = '/test';
      final tResponse = jsonEncode([1, 2, 3, 4, 5]);
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response(tResponse, 200));

      // Act
      final result = await apiClient.get(tUrl);

      // Assert
      expect(result, jsonDecode(tResponse));
    });

    test('post should return data when the call to API is successful', () async {
      // Arrange
      const tUrl = '/test';
      final tBody = [1, 2, 3, 4, 5];
      final tResponse = jsonEncode({'isInOrder': true});
      when(() => mockHttpClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      )).thenAnswer((_) async => http.Response(tResponse, 200));

      // Act
      final result = await apiClient.post(tUrl, body: tBody);

      // Assert
      expect(result, jsonDecode(tResponse));
    });

    test('get should throw an exception when the call to API is unsuccessful',
        () async {
      // Arrange
      const tUrl = 'https://example.com';
      when(() => mockHttpClient.get(Uri.parse(tUrl)))
          .thenAnswer((_) async => http.Response('Error', 404));

      // Act
      final call = apiClient.get(tUrl);

      // Assert
      expect(() => call, throwsException);
    });

    test('post should throw an exception when the call to API is unsuccessful',
        () async {
      // Arrange
      const tUrl = 'https://example.com';
      final tBody = [1, 2, 3, 4, 5];
      when(() => mockHttpClient.post(
            Uri.parse(tUrl),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 404));

      // Act
      final call = apiClient.post(tUrl, body: tBody);

      // Assert
      expect(() => call, throwsException);
    });
  });
}
