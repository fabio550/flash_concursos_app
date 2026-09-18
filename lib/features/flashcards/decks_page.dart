import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class DecksPage extends StatelessWidget {
  const DecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Decks', style: TextStyle(color: AppColors.textPrimary),)));
  }
}