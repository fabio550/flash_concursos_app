import 'package:flash_concursos_app/core/presentation/widgets/app_bar/home_app_bar.dart';
import 'package:flash_concursos_app/core/presentation/widgets/today_review_hero.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            TodayReviewHero(
              revisions: 38,
              newCards: 12,
            ),
          ],
        ),
      )
    );
  }
}