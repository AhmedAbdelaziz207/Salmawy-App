import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salmawy_app/core/network/dio_factory.dart';
import 'package:salmawy_app/core/services/device_info_service.dart';
import 'package:salmawy_app/core/services/notification_service.dart';
import 'package:salmawy_app/core/utils/storage_service.dart';
import 'package:salmawy_app/features/login/logic/login_repo.dart';
import 'package:salmawy_app/features/login/logic/login_states.dart';
import 'package:salmawy_app/features/login/model/login_request_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginRepo _loginRepo;
  final DeviceInfoService _deviceInfoService;
  
  LoginCubit(this._loginRepo, this._deviceInfoService) : super(LoginInitial());

  Future<void> emitLogin({required String studentCode, required String password}) async {
    emit(LoginLoading());
    try {
      final deviceId = await _deviceInfoService.getDeviceId();
      final platform = await _deviceInfoService.getPlatformName();
      final deviceName = await _deviceInfoService.getDeviceName();
      final appVersion = await _deviceInfoService.getAppVersion();

      final request = LoginRequestModel(
        studentCode: studentCode,
        parentPassword: password,
        deviceId: deviceId,
        fcmToken: await NotificationService().getFCMToken(), // TODO: Get actual FCM token
        platform: platform,
        deviceName: deviceName,
        appVersion: appVersion,
        notificationsStatus: 'enabled',
        app: 'salmawy',
      );
      
      final response = await _loginRepo.login(request);
      
      if (response.status == 'success') {
        // Save token and set in Dio
        if (response.parentToken != null) {
          await StorageService().saveSecure(StorageService.keyUserToken, response.parentToken!);
          DioFactory.setTokenIntoHeaderAfterLogin(response.parentToken!);
        }
        if (response.refreshToken != null) {
          await StorageService().saveSecure(StorageService.keyRefreshToken, response.refreshToken!);
        }
        
        // Cache student data
        if (response.student != null) {
          await StorageService().save(StorageService.keyStudentName, response.student!.studentName ?? '');
          await StorageService().save(StorageService.keyStudentCode, response.student!.studentCode ?? '');
          await StorageService().save(StorageService.keyParentPhone, response.student!.parentPhone ?? '');
          await StorageService().save(StorageService.keyAcademicYear, response.student!.academicYear ?? '');
        }
        if (response.group != null) {
          await StorageService().save(StorageService.keyGroupName, response.group!.groupName ?? '');
        }

        // Add account to the saved accounts list
        await StorageService().saveCurrentAccountToList();

        emit(LoginSuccess(message: response.message ?? 'تم تسجيل الدخول بنجاح'));
      } else {
        emit(LoginFailure(message: response.message ?? 'فشل تسجيل الدخول'));
      }
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }
}