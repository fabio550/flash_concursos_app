import 'dart:math';

import '../entities/flashcard.dart';
import '../enums/card_state.dart';
import '../enums/rating.dart';
import 'fsrs_parameters.dart';

/// Schedules the next review of a [Flashcard] from a [Rating],
/// implementing FSRS-4.5 for already-graduated cards and the fixed steps
/// (`FsrsParameters.learningSteps`/`relearningSteps`) for new cards and
/// lapses — same behavior as Anki with FSRS enabled.
class FsrsScheduler {
  final FsrsParameters params;

  FsrsScheduler([FsrsParameters? params])
      : params = params ?? FsrsParameters.defaults();

  Flashcard review(Flashcard card, Rating rating, {DateTime? now}) {
    final at = now ?? DateTime.now();
    switch (card.state) {
      case CardState.newCard:
        return _reviewNew(card, rating, at);
      case CardState.learning:
      case CardState.relearning:
        return _reviewLearningStep(card, rating, at);
      case CardState.review:
        return _reviewInSchedule(card, rating, at);
    }
  }

  Flashcard _reviewNew(Flashcard card, Rating rating, DateTime now) {
    final difficulty = _initDifficulty(rating);
    final stability = _initStability(rating);
    final updated = card.copyWith(
      difficulty: difficulty,
      stability: stability,
      reps: card.reps + 1,
      lastReview: now,
    );
    return _advanceLearningStep(
      updated,
      rating,
      now,
      steps: params.learningSteps,
      learningState: CardState.learning,
    );
  }

  Flashcard _reviewLearningStep(Flashcard card, Rating rating, DateTime now) {
    final steps = card.state == CardState.learning
        ? params.learningSteps
        : params.relearningSteps;
    return _advanceLearningStep(
      card.copyWith(reps: card.reps + 1, lastReview: now),
      rating,
      now,
      steps: steps,
      learningState: card.state,
    );
  }

  /// Shared by new cards and cards in (re)learning: Again resets the
  /// steps, Hard repeats the current step, Good advances one step (or
  /// graduates if it was the last one) and Easy graduates right away.
  Flashcard _advanceLearningStep(
    Flashcard card,
    Rating rating,
    DateTime now, {
    required List<Duration> steps,
    required CardState learningState,
  }) {
    switch (rating) {
      case Rating.again:
        return card.copyWith(
          state: learningState,
          learningStep: 0,
          due: now.add(steps.first),
        );
      case Rating.hard:
        return card.copyWith(
          state: learningState,
          learningStep: card.learningStep,
          due: now.add(steps[card.learningStep]),
        );
      case Rating.good:
        final nextStep = card.learningStep + 1;
        if (nextStep < steps.length) {
          return card.copyWith(
            state: learningState,
            learningStep: nextStep,
            due: now.add(steps[nextStep]),
          );
        }
        return _graduate(card, now);
      case Rating.easy:
        return _graduate(card, now);
    }
  }

  Flashcard _graduate(Flashcard card, DateTime now) {
    final intervalDays = _nextIntervalDays(card.stability);
    return card.copyWith(
      state: CardState.review,
      due: now.add(Duration(days: intervalDays)),
      scheduledDays: intervalDays,
      learningStep: 0,
    );
  }

  Flashcard _reviewInSchedule(Flashcard card, Rating rating, DateTime now) {
    final lastReview = card.lastReview ?? now;
    final elapsedDays = now.difference(lastReview).inDays;
    final r = _retrievability(elapsedDays, card.stability);
    final newDifficulty = _nextDifficulty(card.difficulty, rating);

    if (rating == Rating.again) {
      final newStability = _stabilityAfterFailure(card.difficulty, card.stability, r);
      return card.copyWith(
        difficulty: newDifficulty,
        stability: newStability,
        elapsedDays: elapsedDays,
        lapses: card.lapses + 1,
        state: CardState.relearning,
        learningStep: 0,
        due: now.add(params.relearningSteps.first),
      );
    }

    final newStability = _stabilityAfterSuccess(card.difficulty, card.stability, r, rating);
    final intervalDays = _nextIntervalDays(newStability);
    return card.copyWith(
      difficulty: newDifficulty,
      stability: newStability,
      elapsedDays: elapsedDays,
      scheduledDays: intervalDays,
      state: CardState.review,
      due: now.add(Duration(days: intervalDays)),
    );
  }

  // --- FSRS-4.5 formulas ------------------------------------------------

  double _initStability(Rating rating) => max(params.w[rating.value - 1], 0.1);

  double _initDifficulty(Rating rating) {
    final d = params.w[4] - exp(params.w[5] * (rating.value - 1)) + 1;
    return d.clamp(1, 10).toDouble();
  }

  double _nextDifficulty(double d, Rating rating) {
    final next = d - params.w[6] * (rating.value - 3);
    final meanReversionTarget = _initDifficulty(Rating.easy);
    final reverted = params.w[7] * meanReversionTarget + (1 - params.w[7]) * next;
    return reverted.clamp(1, 10).toDouble();
  }

  /// R(t, S) — estimated probability of recall after `elapsedDays` days
  /// with stability `stability`.
  double _retrievability(int elapsedDays, double stability) {
    if (stability <= 0) return 0;
    return pow(1 + FsrsParameters.factor * elapsedDays / stability, FsrsParameters.decay)
        .toDouble();
  }

  double _stabilityAfterSuccess(double d, double s, double r, Rating rating) {
    final hardPenalty = rating == Rating.hard ? params.w[15] : 1.0;
    final easyBonus = rating == Rating.easy ? params.w[16] : 1.0;
    return s *
        (1 +
            exp(params.w[8]) *
                (11 - d) *
                pow(s, -params.w[9]) *
                (exp((1 - r) * params.w[10]) - 1) *
                hardPenalty *
                easyBonus);
  }

  double _stabilityAfterFailure(double d, double s, double r) {
    return params.w[11] *
        pow(d, -params.w[12]) *
        (pow(s + 1, params.w[13]) - 1) *
        exp((1 - r) * params.w[14]);
  }

  int _nextIntervalDays(double stability) {
    final t = (stability / FsrsParameters.factor) *
        (pow(params.requestRetention, 1 / FsrsParameters.decay) - 1);
    return t.round().clamp(1, params.maximumIntervalDays).toInt();
  }
}
