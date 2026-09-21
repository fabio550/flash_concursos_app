import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class UserAvatarBadge extends StatelessWidget {
  const UserAvatarBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          'F',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.background,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}