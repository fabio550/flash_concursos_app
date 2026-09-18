import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class MockExamPage extends StatelessWidget {
  const MockExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Simulado', style: TextStyle(color: AppColors.textPrimary),)));
  }
}