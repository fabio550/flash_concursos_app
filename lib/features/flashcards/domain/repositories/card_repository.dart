import '../entities/flashcard.dart';

abstract class CardRepository {
  Future<List<Flashcard>> getByDeckId(String deckId);

  /// Cards due at or before [now], respecting the study-day cutoff — see
  /// `study_day.dart`. [limit] mirrors the app's daily new/review caps.
  Future<List<Flashcard>> getDue({required DateTime now, int? limit});

  Future<void> save(Flashcard card);
}
