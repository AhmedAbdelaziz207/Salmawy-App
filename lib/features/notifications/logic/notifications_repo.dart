import 'package:salmawy_app/core/network/api_error_model.dart';
import 'package:salmawy_app/core/network/api_service.dart';
import 'package:salmawy_app/features/notifications/models/notifications_model.dart';

class NotificationsRepo {
  final ApiService _apiService;

  NotificationsRepo(this._apiService);

  Future<NotificationsModel> getNotifications(String token) async {
    try {
      final response = await _apiService.getNotifications(token);
      return response;
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }
}
