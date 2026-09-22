import '../enums/card_state.dart';

/// Review unit generated from a [Note], carrying its own independent FSRS
/// state. Named `Flashcard` (not `Card`) to avoid colliding with
/// `material.dart`'s `Card` when both are imported in the presentation layer.
class Flashcard {
  final String id;
  final String noteId;
  final String deckId;

  /// Which sub-card of the note this is: cloze index (`{{c1::}}`,
  /// `{{c2::}}`, ...) for cloze notes, 0/1 for front/back in basicReversed,
  /// always 0 for basic. See `card_factory.dart`.
  final int variantIndex;

  final CardState state;
  final DateTime due;
  final double stability;
  final double difficulty;
  final int elapsedDays;
  final int scheduledDays;
  final int reps;
  final int lapses;
  final DateTime? lastReview;

  /// Index of the current step within `learningSteps`/`relearningSteps`
  /// (see `FsrsParameters`), relevant only when [state] is `learning` or
  /// `relearning`.
  final int learningStep;

  const Flashcard({
    required this.id,
    required this.noteId,
    required this.deckId,
    this.variantIndex = 0,
    this.state = CardState.newCard,
    required this.due,
    this.stability = 0,
    this.difficulty = 0,
    this.elapsedDays = 0,
    this.scheduledDays = 0,
    this.reps = 0,
    this.lapses = 0,
    this.lastReview,
    this.learningStep = 0,
  });

  Flashcard copyWith({
    CardState? state,
    DateTime? due,
    double? stability,
    double? difficulty,
    int? elapsedDays,
    int? scheduledDays,
    int? reps,
    int? lapses,
    DateTime? lastReview,
    int? learningStep,
  }) {
    return Flashcard(
      id: id,
      noteId: noteId,
      deckId: deckId,
      variantIndex: variantIndex,
      state: state ?? this.state,
      due: due ?? this.due,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      elapsedDays: elapsedDays ?? this.elapsedDays,
      scheduledDays: scheduledDays ?? this.scheduledDays,
      reps: reps ?? this.reps,
      lapses: lapses ?? this.lapses,
      lastReview: lastReview ?? this.lastReview,
      learningStep: learningStep ?? this.learningStep,
    );
  }
}
