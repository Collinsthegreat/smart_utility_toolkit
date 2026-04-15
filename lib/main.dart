import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/constants/app_constants.dart';
import 'injection.dart';

/// Custom [BlocObserver] used for logging transitions and errors.
class AppBlocObserver extends BlocObserver {
  /// Creates an [AppBlocObserver].
  AppBlocObserver();

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}

/// Entry point for Smart Utility Toolkit.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Hive.initFlutter();
  await Hive.openBox<dynamic>(AppConstants.notesBox);
  await Hive.openBox<dynamic>(AppConstants.converterHistoryBox);
  await Hive.openBox<dynamic>(AppConstants.calculatorHistoryBox);
  await Hive.openBox<dynamic>(AppConstants.bmiHistoryBox);
  await Hive.openBox<dynamic>(AppConstants.settingsBox);
  await configureDependencies();
  runApp(ScreenUtilInit(
    designSize: const Size(390, 844),
    minTextAdapt: true,
    builder: (_, __) => const SmartUtilityToolkitApp(),
  ));
}

