import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppButtonStyles {
  const AppButtonStyles();

  ButtonStyle get primary => ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 64),
    backgroundColor: AppColors.accent,
    foregroundColor: AppColors.background,
    disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.5),
    disabledForegroundColor: AppColors.background,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 0,
  );

  ButtonStyle get secondary => ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 64),
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.textPrimary,
    disabledBackgroundColor: AppColors.background.withValues(alpha: 0.5),
    disabledForegroundColor: Colors.white70,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 4,
  );
}

extension AppButtonStylesX on BuildContext {
  AppButtonStyles get buttons => const AppButtonStyles();
}
