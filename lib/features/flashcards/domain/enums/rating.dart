/// Grade given by the user when reviewing a card — maps directly to the
/// Again/Hard/Good/Easy buttons on the Study screen mockup.
enum Rating {
  again(1),
  hard(2),
  good(3),
  easy(4);

  const Rating(this.value);

  /// Numeric value 1..4 used by the FSRS formulas (w[value - 1] etc).
  final int value;
}
