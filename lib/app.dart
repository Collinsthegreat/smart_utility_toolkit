import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive/hive.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'features/bill_splitter/presentation/pages/bill_splitter_page.dart';
import 'features/bmi_calculator/presentation/pages/bmi_page.dart';
import 'features/calculator/presentation/pages/calculator_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/notes/presentation/pages/notes_list_page.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/settings/presentation/bloc/settings_state.dart';
import 'features/settings/presentation/pages/settings_page.dart';
import 'features/tasks/presentation/pages/tasks_list_page.dart';
import 'features/tasks/presentation/pages/task_form_page.dart';
import 'features/unit_converter/presentation/pages/unit_converter_page.dart';

/// Main app widget and route host.
class SmartUtilityToolkitApp extends StatelessWidget {
  /// Creates [SmartUtilityToolkitApp].
  const SmartUtilityToolkitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (_) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: _mapThemeMode(state.themeMode),
            initialRoute: '/splash',
            routes: <String, WidgetBuilder>{
              '/splash': (_) => const _SplashPage(),
              '/onboarding': (_) => const OnboardingPage(),
              '/home': (_) => const AppShell(),
                '/unit-converter': (_) => const UnitConverterPage(),
              '/calculator': (_) => const CalculatorPage(),
              '/bmi': (_) => const BmiPage(),
              '/bill-splitter': (_) => const BillSplitterPage(),
              '/tasks': (_) => const TasksListPage(),
              '/tasks/form': (_) => const TaskFormPage(),
            },
          );
        },
      ),
    );
  }

  static ThemeMode _mapThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}

/// Splash screen with delayed navigation.
class _SplashPage extends StatefulWidget {
  /// Creates [_SplashPage].
  const _SplashPage();

  @override
  State<_SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<_SplashPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final bool seenOnboarding =
          Hive.box<dynamic>(AppConstants.settingsBox)
              .get(AppConstants.onboardingCompleteKey, defaultValue: false) as bool;
      Navigator.of(context).pushReplacementNamed(
        seenOnboarding ? '/home' : '/onboarding',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const FlutterLogo(size: 120)
                .animate()
                .fade(duration: 800.ms)
                .scale(duration: 800.ms, begin: const Offset(0.85, 0.85), end: const Offset(1.0, 1.0)),
            const SizedBox(height: 24),
            Text(
              AppStrings.splashMessage,
              style: Theme.of(context).textTheme.titleLarge,
            ).animate().fade(duration: 800.ms, delay: 200.ms),
          ],
        ),
      ),
    );
  }
}

/// Bottom tab shell.
class AppShell extends StatefulWidget {
  /// Creates [AppShell].
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    NotesListPage(),
    TasksListPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home_outlined), label: AppStrings.home),
          NavigationDestination(icon: Icon(Icons.note_outlined), label: AppStrings.notes),
          NavigationDestination(icon: Icon(Icons.checklist_outlined), label: AppStrings.tasks),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: AppStrings.settings),
        ],
      ),
    );
  }
}

