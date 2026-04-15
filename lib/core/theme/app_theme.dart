import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import 'app_typography.dart';

/// App light and dark theme definitions.
abstract final class AppTheme {
  /// Light Material 3 theme.
  static ThemeData get lightTheme => FlexThemeData.light(
        scheme: FlexScheme.deepBlue,
        useMaterial3: true,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,
        appBarOpacity: 0.95,
        swapColors: false,
        subThemesData: const FlexSubThemesData(
          elevatedButtonRadius: AppSizes.radiusSmall,
          inputDecoratorRadius: AppSizes.radiusSmall,
          cardRadius: AppSizes.radiusMedium,
          dialogRadius: AppSizes.radiusMedium,
          bottomNavigationBarElevation: 8,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        textTheme: AppTypography.textTheme,
      ).copyWith(
        scaffoldBackgroundColor: Colors.white,
        cardTheme: const CardThemeData(
          elevation: 4,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSizes.radiusMedium)),
          ),
        ),
      );

  /// Dark Material 3 theme.
  static ThemeData get darkTheme => FlexThemeData.dark(
        scheme: FlexScheme.deepBlue,
        useMaterial3: true,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarOpacity: 0.95,
        subThemesData: const FlexSubThemesData(
          elevatedButtonRadius: AppSizes.radiusSmall,
          inputDecoratorRadius: AppSizes.radiusSmall,
          cardRadius: AppSizes.radiusMedium,
          dialogRadius: AppSizes.radiusMedium,
          bottomNavigationBarElevation: 8,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        textTheme: AppTypography.textTheme,
      );
}

