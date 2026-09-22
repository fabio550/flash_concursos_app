import 'package:flash_concursos_app/features/flashcards/domain/entities/deck.dart';

/// View-model for a row in [DeckListView] — a [Deck] plus the card counts
/// the Home page computed from `CardRepository`.
class DeckSummary {
  final Deck deck;
  final int totalCards;
  final int pendingCards;

  const DeckSummary({
    required this.deck,
    required this.totalCards,
    required this.pendingCards,
  });
}
