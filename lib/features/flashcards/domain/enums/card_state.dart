/// Spaced-repetition state of a [Flashcard], in the FSRS/Anki sense.
enum CardState {
  /// Never reviewed.
  newCard,

  /// Going through the fixed learning steps (10 min -> 1 day).
  learning,

  /// Graduated — scheduled via FSRS.
  review,

  /// Failed in review (a lapse) and redoing the relearning steps.
  relearning,
}
