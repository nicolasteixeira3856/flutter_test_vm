import 'package:exam_app/features/exam/data/models/number_list_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberListModel', () {
    test('should be a subclass of NumberList entity', () {
      // Arrange
      final numbers = [1, 2, 3, 4, 5];
      final numberListModel = NumberListModel(numbers: numbers);

      // Act & Assert
      expect(numberListModel, isA<NumberListModel>());
    });

    test('fromJson should return a valid model', () {
      // Arrange
      final jsonMap = {
        'numbers': [1, 2, 3, 4, 5]
      };

      // Act
      final result = NumberListModel.fromJson(jsonMap);

      // Assert
      expect(result, NumberListModel(numbers: [1, 2, 3, 4, 5]));
    });

    test('toJson should return a JSON map containing the proper data', () {
      // Arrange
      final numbers = [1, 2, 3, 4, 5];
      final numberListModel = NumberListModel(numbers: numbers);
      final expectedJsonMap = {
        'numbers': [1, 2, 3, 4, 5]
      };

      // Act
      final result = numberListModel.toJson();

      // Assert
      expect(result, expectedJsonMap);
    });

    test('should return true when comparing two identical models', () {
      // Arrange
      final numbers = [1, 2, 3, 4, 5];
      final model1 = NumberListModel(numbers: numbers);
      final model2 = NumberListModel(numbers: numbers);

      // Act & Assert
      expect(model1, model2);
    });

    test('should return false when comparing two different models', () {
      // Arrange
      final model1 = NumberListModel(numbers: [1, 2, 3, 4, 5]);
      final model2 = NumberListModel(numbers: [5, 4, 3, 2, 1]);

      // Act & Assert
      expect(model1 == model2, false);
    });
  });
}
