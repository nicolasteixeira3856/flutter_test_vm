import 'package:exam_app/core/network/api_client.dart';
import 'package:exam_app/features/exam/data/datasources/exam_remote_datasource.dart';
import 'package:exam_app/features/exam/data/models/number_list_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late ExamRemoteDataSource dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ExamRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('ExamRemoteDataSource', () {
    test('should return NumberListModel when the call to API is successful', () async {
      // Arrange
      const tQuantity = 5;
      final tNumbers = [1, 2, 3, 4, 5];
      final tResponse = tNumbers;
      when(() => mockApiClient.get(any())).thenAnswer((_) async => tResponse);

      // Act
      final result = await dataSource.getRandomNumbers(tQuantity);

      // Assert
      expect(result, equals(NumberListModel.fromJson({'numbers': tResponse})));
    });

    test('should return true when the numbers are in order', () async {
      // Arrange
      final tNumbers = [1, 2, 3, 4, 5];
      when(() => mockApiClient.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => {'isInOrder': true});

      // Act
      final result = await dataSource.checkOrder(tNumbers);

      // Assert
      expect(result, true);
    });

    test(
        'should throw an exception when the call to API is unsuccessful for getRandomNumbers',
        () async {
      // Arrange
      const tQuantity = 5;
      when(() => mockApiClient.get(any()))
          .thenThrow(Exception('Failed to load data'));

      // Act
      final call = dataSource.getRandomNumbers(tQuantity);

      // Assert
      expect(call, throwsException);
    });

    test(
        'should throw an exception when the call to API is unsuccessful for checkOrder',
        () async {
      // Arrange
      final tNumbers = [1, 2, 3, 4, 5];
      when(() => mockApiClient.post(any(), body: any(named: 'body')))
          .thenThrow(Exception('Failed to load data'));

      // Act
      final call = dataSource.checkOrder(tNumbers);

      // Assert
      expect(call, throwsException);
    });
  });
}
