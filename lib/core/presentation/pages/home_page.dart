import 'package:flash_concursos_app/core/presentation/widgets/app_bar/home_app_bar.dart';
import 'package:flash_concursos_app/core/presentation/widgets/deck_list_view.dart';
import 'package:flash_concursos_app/core/presentation/widgets/deck_summary.dart';
import 'package:flash_concursos_app/core/presentation/widgets/stat_card.dart';
import 'package:flash_concursos_app/core/presentation/widgets/today_review_hero.dart';
import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flash_concursos_app/features/flashcards/data/fake/fake_card_repository.dart';
import 'package:flash_concursos_app/features/flashcards/data/fake/fake_deck_repository.dart';
import 'package:flash_concursos_app/features/flashcards/domain/enums/card_state.dart';
import 'package:flash_concursos_app/features/flashcards/domain/repositories/card_repository.dart';
import 'package:flash_concursos_app/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:flash_concursos_app/features/flashcards/domain/services/study_day.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DeckRepository _deckRepository = FakeDeckRepository();
  late final CardRepository _cardRepository = FakeCardRepository(_deckRepository);
  late final Future<_HomeData> _future = _loadData();

  Future<_HomeData> _loadData() async {
    final now = DateTime.now();
    final decks = await _deckRepository.getAll();
    final summaries = <DeckSummary>[];
    for (final deck in decks) {
      final cards = await _cardRepository.getByDeckId(deck.id);
      final pending = cards.where((c) => StudyDay.isDueToday(c.due, now)).length;
      summaries.add(DeckSummary(
        deck: deck,
        totalCards: cards.length,
        pendingCards: pending,
      ));
    }

    final dueCards = await _cardRepository.getDue(now: now);
    final revisions = dueCards.where((c) => c.state != CardState.newCard).length;
    final newCards = dueCards.where((c) => c.state == CardState.newCard).length;

    return _HomeData(decks: summaries, revisions: revisions, newCards: newCards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.build(
        onProfileTap: () {},
        onNotificationTap: () {},
      ),
      body: FutureBuilder<_HomeData>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            );
          }
          final data = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                TodayReviewHero(
                  revisions: data.revisions,
                  newCards: data.newCards,
                  onPressed: () {},
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          centerText: '91%',
                          bottomText: 'retenção 7d',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          centerText: '264',
                          bottomText: 'cards na semana',
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                      child: Text(
                        'Continue estudando',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                DeckListView(summaries: data.decks),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HomeData {
  final List<DeckSummary> decks;
  final int revisions;
  final int newCards;

  const _HomeData({
    required this.decks,
    required this.revisions,
    required this.newCards,
  });
}
