import 'package:flutter/material.dart';

/// Paleta central do app. Nenhuma tela deve usar Color(0x...) diretamente —
/// se uma cor nova aparecer num mockup, ela entra aqui primeiro.
class AppColors {
  AppColors._();

  static const background = Color(0xFF14150F);
  static const surface = Color(0xFF1C1C1F);
  static const accent = Color(0xFFD7F24C);

  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFF8E8E93);
  static const navUnselected = Colors.white54;
}