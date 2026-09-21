import 'package:flash_concursos_app/core/presentation/widgets/app_bar/home_app_bar.dart';
import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.build(
        onProfileTap: () {},
        onNotificationTap: () {},
      ),
      body: Center(
        child: Text(
          'Inicio',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}