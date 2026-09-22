import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/card_repository.dart';
import '../../domain/repositories/deck_repository.dart';
import '../../domain/services/card_factory.dart';
import '../../domain/services/study_day.dart';

/// In-memory [CardRepository] generating its cards from whatever
/// [DeckRepository] gives it, via [CardFactory] — keeps the fake decks and
/// fake cards in sync without duplicating seed data.
class FakeCardRepository implements CardRepository {
  FakeCardRepository(this._deckRepository);

  final DeckRepository _deckRepository;
  final Map<String, Flashcard> _cards = {};
  bool _seeded = false;

  Future<void> _ensureSeeded() async {
    if (_seeded) return;
    _seeded = true;
    final decks = await _deckRepository.getAll();
    for (final deck in decks) {
      final notes = await _deckRepository.getNotes(deck.id);
      for (final note in notes) {
        for (final card in CardFactory.generate(note)) {
          _cards[card.id] = card;
        }
      }
    }
  }

  @override
  Future<List<Flashcard>> getByDeckId(String deckId) async {
    await _ensureSeeded();
    return _cards.values.where((c) => c.deckId == deckId).toList();
  }

  @override
  Future<List<Flashcard>> getDue({required DateTime now, int? limit}) async {
    await _ensureSeeded();
    final due = _cards.values.where((c) => StudyDay.isDueToday(c.due, now)).toList()
      ..sort((a, b) => a.due.compareTo(b.due));
    if (limit != null && due.length > limit) {
      return due.sublist(0, limit);
    }
    return due;
  }

  @override
  Future<void> save(Flashcard card) async {
    await _ensureSeeded();
    _cards[card.id] = card;
  }
}
