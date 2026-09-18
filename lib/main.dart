import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

import 'core/routing/app_router.dart';

void main() {
  runApp(const FlashConcursoApp());
}

class FlashConcursoApp extends StatelessWidget {
  const FlashConcursoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.white.withValues(alpha: 0.02),
        highlightColor: Colors.white.withValues(alpha: 0.01),
        scaffoldBackgroundColor: AppColors.background
      ),
      routerConfig: appRouter,
    );
  }
}
