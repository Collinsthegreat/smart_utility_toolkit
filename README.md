# Smart Utility Toolkit

A Flutter utility toolkit built with clean architecture, Hive persistence, GoRouter navigation, and BLoC state management.

## Features

- Home dashboard with quick access to utilities
- Notes with local storage and search
- Unit converter with conversion history
- Calculator with expression evaluation and calculation history
- BMI calculator with health feedback and history
- Bill splitter for tip and share calculations
- Theme mode and currency preference settings
- Onboarding flow and persistent user preferences

## Getting Started

1. Install dependencies:

```bash
flutter pub get
```

2. Run the app:

```bash
flutter run
```

3. Run tests:

```bash
flutter test
```

4. Run static analysis:

```bash
flutter analyze
```

## Notes

- Hive boxes are initialized in `lib/main.dart`.
- Shared preferences are used for onboarding and theme/currency settings.
- The app uses `GoRouter` for shell-based bottom navigation.
