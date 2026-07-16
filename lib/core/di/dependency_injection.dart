import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:salmawy_app/core/network/api_service.dart';
import 'package:salmawy_app/core/network/dio_factory.dart';
import 'package:salmawy_app/core/services/device_info_service.dart';
import 'package:salmawy_app/features/home/logic/home_cubit.dart';
import 'package:salmawy_app/features/home/logic/home_repo.dart';
import 'package:salmawy_app/features/login/logic/login_repo.dart';
import 'package:salmawy_app/features/notifications/logic/notifications_cubit.dart';
import 'package:salmawy_app/features/notifications/logic/notifications_repo.dart';
import 'package:salmawy_app/features/attendence/logic/attendence_cubit.dart';
import 'package:salmawy_app/features/attendence/logic/attendence_repo.dart';
import 'package:salmawy_app/features/exams/logic/exams_cubit.dart';
import 'package:salmawy_app/features/exams/logic/exams_repo.dart';
import 'package:salmawy_app/features/finance/logic/finance_cubit.dart';
import 'package:salmawy_app/features/finance/logic/finance_repo.dart';
import 'package:salmawy_app/features/absences_requests/logic/absence_request_cubit.dart';
import 'package:salmawy_app/features/absences_requests/logic/absence_request_repo.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // Device Info Service
  getIt.registerLazySingleton<DeviceInfoService>(() => DeviceInfoService());

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));

  // home
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt(), getIt()));

  // notifications
  getIt.registerLazySingleton<NotificationsRepo>(() => NotificationsRepo(getIt()));
  getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit(getIt()));

  // attendance
  getIt.registerLazySingleton<AttendenceRepo>(() => AttendenceRepo(getIt()));
  getIt.registerFactory<AttendenceCubit>(() => AttendenceCubit(getIt()));

  // exams
  getIt.registerLazySingleton<ExamsRepo>(() => ExamsRepo(getIt()));
  getIt.registerFactory<ExamsCubit>(() => ExamsCubit(getIt()));

  // finance
  getIt.registerLazySingleton<FinanceRepo>(() => FinanceRepo(getIt()));
  getIt.registerFactory<FinanceCubit>(() => FinanceCubit(getIt()));

  // absence requests
  getIt.registerLazySingleton<AbsenceRequestRepo>(() => AbsenceRequestRepo(getIt()));
  getIt.registerFactory<AbsenceRequestCubit>(() => AbsenceRequestCubit(getIt()));
}
