import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Questões', style: TextStyle(color: AppColors.textPrimary),)));
  }
}