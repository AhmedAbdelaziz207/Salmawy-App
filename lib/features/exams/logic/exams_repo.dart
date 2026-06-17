import 'package:salmawy_app/core/network/api_error_model.dart';
import 'package:salmawy_app/core/network/api_service.dart';
import 'package:salmawy_app/features/exams/model/exams_results_model.dart';

class ExamsRepo {
  final ApiService _apiService;

  ExamsRepo(this._apiService);

  Future<ExamsResultsModel> getExamsResults(String token) async {
    try {
      final response = await _apiService.getExamsResults(token);
      return response;
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }
}
