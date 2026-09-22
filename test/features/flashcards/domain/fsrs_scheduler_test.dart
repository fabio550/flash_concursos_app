import 'package:flash_concursos_app/features/flashcards/domain/entities/flashcard.dart';
import 'package:flash_concursos_app/features/flashcards/domain/enums/card_state.dart';
import 'package:flash_concursos_app/features/flashcards/domain/enums/rating.dart';
import 'package:flash_concursos_app/features/flashcards/domain/services/fsrs_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final scheduler = FsrsScheduler();
  final now = DateTime(2026, 1, 1, 8);

  Flashcard newCard() => Flashcard(id: 'c1', noteId: 'n1', deckId: 'd1', due: now);

  group('new card', () {
    test('Again keeps it in learning at the first step', () {
      final result = scheduler.review(newCard(), Rating.again, now: now);
      expect(result.state, CardState.learning);
      expect(result.learningStep, 0);
      expect(result.due, now.add(const Duration(minutes: 10)));
    });

    test('Good advances to the second learning step (1 day)', () {
      final result = scheduler.review(newCard(), Rating.good, now: now);
      expect(result.state, CardState.learning);
      expect(result.learningStep, 1);
      expect(result.due, now.add(const Duration(days: 1)));
    });

    test('Easy graduates straight to review', () {
      final result = scheduler.review(newCard(), Rating.easy, now: now);
      expect(result.state, CardState.review);
      expect(result.due.isAfter(now), isTrue);
      expect(result.scheduledDays, greaterThan(0));
    });

    test('reps increments and lastReview is stamped', () {
      final result = scheduler.review(newCard(), Rating.good, now: now);
      expect(result.reps, 1);
      expect(result.lastReview, now);
    });
  });

  group('graduating the last learning step', () {
    test('Good on the last step graduates to review', () {
      final atSecondStep = newCard().copyWith(
        state: CardState.learning,
        learningStep: 1,
        stability: 3,
        difficulty: 5,
      );
      final result = scheduler.review(atSecondStep, Rating.good, now: now);
      expect(result.state, CardState.review);
      expect(result.due.isAfter(now), isTrue);
    });
  });

  group('card in review', () {
    Flashcard graduatedCard() => Flashcard(
          id: 'c1',
          noteId: 'n1',
          deckId: 'd1',
          state: CardState.review,
          due: now,
          stability: 10,
          difficulty: 5,
          reps: 3,
          lastReview: now.subtract(const Duration(days: 10)),
        );

    test('Good keeps it in review and pushes the due date forward', () {
      final result = scheduler.review(graduatedCard(), Rating.good, now: now);
      expect(result.state, CardState.review);
      expect(result.due.isAfter(now), isTrue);
      expect(result.stability, greaterThan(0));
    });

    test('Again drops it to relearning and counts a lapse', () {
      final card = graduatedCard();
      final result = scheduler.review(card, Rating.again, now: now);
      expect(result.state, CardState.relearning);
      expect(result.lapses, card.lapses + 1);
      expect(result.due, now.add(const Duration(minutes: 10)));
    });

    test('Easy schedules a longer interval than Good, all else equal', () {
      final good = scheduler.review(graduatedCard(), Rating.good, now: now);
      final easy = scheduler.review(graduatedCard(), Rating.easy, now: now);
      expect(easy.scheduledDays, greaterThanOrEqualTo(good.scheduledDays));
    });
  });

  group('relearning', () {
    test('Good on the relearning step returns the card to review', () {
      final relearning = Flashcard(
        id: 'c1',
        noteId: 'n1',
        deckId: 'd1',
        state: CardState.relearning,
        due: now,
        stability: 2,
        difficulty: 6,
        learningStep: 0,
      );
      final result = scheduler.review(relearning, Rating.good, now: now);
      expect(result.state, CardState.review);
    });
  });
}
