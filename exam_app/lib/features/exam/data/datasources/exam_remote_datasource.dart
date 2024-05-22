import '../../../../core/network/api_client.dart';
import '../models/number_list_model.dart';

abstract class ExamRemoteDataSource {
  Future<NumberListModel> getRandomNumbers(int quantity);

  Future<bool> checkOrder(List<int> numbers);
}

class ExamRemoteDataSourceImpl implements ExamRemoteDataSource {
  final ApiClient apiClient;

  ExamRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<NumberListModel> getRandomNumbers(int quantity) async {
    final response = await apiClient.get('/random-numbers/$quantity');
    return NumberListModel.fromJson({'numbers': response});
  }

  @override
  Future<bool> checkOrder(List<int> numbers) async {
    final response = await apiClient.post('/check-order', body: numbers);
    return response['isInOrder'];
  }
}
