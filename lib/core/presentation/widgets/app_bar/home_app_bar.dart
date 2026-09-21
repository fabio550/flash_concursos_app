import 'package:flash_concursos_app/core/presentation/widgets/app_bar/greeting_header.dart';
import 'package:flash_concursos_app/core/presentation/widgets/app_bar/header_action_bar.dart';
import 'package:flash_concursos_app/core/presentation/widgets/app_bar/user_avatar_badge.dart';
import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class HomeAppBar {
  static PreferredSizeWidget build({
    VoidCallback? onProfileTap,
    VoidCallback? onNotificationTap,
  }) {
    return AppBar(
      backgroundColor: AppColors.background,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              UserAvatarBadge(),
              SizedBox(width: 20),
              GreetingHeader(),
            ],
          ),
          HeaderActionBar(
            onProfileTap: onProfileTap,
            onNotificationTap: onNotificationTap,
          ),
        ],
      ),
    );
  }
}