import 'package:flash_concursos_app/core/presentation/widgets/app_bar/home_app_bar.dart';
import 'package:flash_concursos_app/core/presentation/widgets/deck_list_view.dart';
import 'package:flash_concursos_app/core/presentation/widgets/stat_card.dart';
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
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: StatCard(
                      centerText: '91%',
                      bottomText: 'retenção 7d',
                    ),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: StatCard(
                      centerText: '264',
                      bottomText: 'cards na semana',
                    ),
                  ),
                ],
              ),
            ),
            DeckListView(),
          ],
        ),
      ),
    );
  }
}