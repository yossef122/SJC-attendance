// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Feature/LanguageOption/Ui/language_options.dart';
import 'package:madarj/Feature/all_works/ui/all_works.dart';
import 'package:madarj/Feature/base/presentation/views/base_layer.dart';
import 'package:madarj/Feature/clock_in/ui/clock_in_screen.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/send_expenses.dart';
import 'package:madarj/Feature/home/ui/home.dart';
import 'package:madarj/Feature/leave/send_leave/ui/send_leave.dart';
import 'package:madarj/Feature/on_boarding/ui/on_boarding_screen.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_cubit.dart';
import 'package:madarj/Feature/registration/login/Ui/login.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    var arg = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginCubit>(
            create: (context) => getIt<LoginCubit>(),
            child: const Login(),
          ),
        );
      case Routes.baseLayer:
        return MaterialPageRoute(
          builder: (_) => const BaseLayer(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.clockInScreen:
        return MaterialPageRoute(
          builder: (_) => const ClockInScreen(),
        );
      case Routes.allMonthWorks:
        return MaterialPageRoute(
          builder: (_) => const AllMonthWorks(),
        );
      case Routes.language:
        return MaterialPageRoute(
          builder: (_) => const Languageoptions(),
        );
      case Routes.sendExpenses:
        return MaterialPageRoute(
          builder: (_) => const SendExpenses(),
        );
      case Routes.sendLeave:
        return MaterialPageRoute(
          builder: (_) => const SendLeave(),
        );
    }
    return null;
  }
}
