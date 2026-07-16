import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salmawy_app/core/di/dependency_injection.dart';
import 'package:salmawy_app/core/routing/app_routes.dart';
import 'package:salmawy_app/core/widgets/main_shell_screen.dart';
import 'package:salmawy_app/features/login/logic/login_cubit.dart';
import 'package:salmawy_app/features/login/login_screen.dart';
import 'package:salmawy_app/features/notifications/notifications_screen.dart';
import 'package:salmawy_app/features/attendence/attendence_screen.dart';
import 'package:salmawy_app/features/exams/exams_screen.dart';
import 'package:salmawy_app/features/finance/finance_screen.dart';
import 'package:salmawy_app/features/profile/profile_screen.dart';
import 'package:salmawy_app/features/absences_requests/absence_request_screen.dart';
import 'package:salmawy_app/features/splash/splash_screen.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => LoginCubit(getIt(), getIt()),
                child: const LoginScreen(),
              ),
        );
     
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const MainShellScreen(),
        );
      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsScreen(),
        );
      case AppRoutes.attendence:
        return MaterialPageRoute(
          builder: (_) => const AttendenceScreen(),
        );
      case AppRoutes.exams:
        return MaterialPageRoute(
          builder: (_) => const ExamsScreen(),
        );
      case AppRoutes.finance:
        return MaterialPageRoute(
          builder: (_) => const FinanceScreen(),
        );
      case AppRoutes.profile:
        final generalAverage = settings.arguments is String ? settings.arguments as String : null;
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(generalAverage: generalAverage),
        );
      case AppRoutes.absenceRequests:
        return MaterialPageRoute(builder: (_) => const AbsenceRequestScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text("No Route found "))),
        );
    }
  }
}
