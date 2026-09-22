/// FSRS-4.5 parameters plus the app's fixed learning steps.
///
/// Default weights are the ones published by the FSRS project
/// (open-source, MIT) — not tuned to our data yet. Per-user optimization
/// (retraining weights from review history) is out of scope for v1.
class FsrsParameters {
  /// w[0..3] = initial stability per rating (again/hard/good/easy).
  /// w[4..5] = initial difficulty. w[6..7] = difficulty update.
  /// w[8..10] = stability after a successful review. w[11..14] = stability
  /// after a failure (lapse). w[15..16] = Hard penalty / Easy bonus.
  /// w[17..18] = same-day stability adjustment — unused here (no same-day
  /// reviews in v1).
  final List<double> w;

  /// Target retention: desired probability of recall on the next review
  /// date. 0.9 is the FSRS default.
  final double requestRetention;

  final int maximumIntervalDays;

  /// Fixed steps a new card goes through before graduating to spaced
  /// review.
  final List<Duration> learningSteps;

  /// Step(s) gone through after a lapse in review, before returning to
  /// spaced review.
  final List<Duration> relearningSteps;

  const FsrsParameters({
    required this.w,
    this.requestRetention = 0.9,
    this.maximumIntervalDays = 36500,
    this.learningSteps = const [Duration(minutes: 10), Duration(days: 1)],
    this.relearningSteps = const [Duration(minutes: 10)],
  });

  factory FsrsParameters.defaults() {
    return const FsrsParameters(
      w: [
        0.4072, 1.1829, 3.1262, 15.4722, 7.2102, 0.5316, 1.0651, 0.0234,
        1.616, 0.1544, 1.0824, 1.9813, 0.0953, 0.2975, 2.2042, 0.2407,
        2.9466, 0.5034, 0.6567,
      ],
    );
  }

  /// -0.5, the exponent in the forgetting curve R(t, S) = (1 + FACTOR*t/S)^DECAY.
  static const double decay = -0.5;

  /// 19/81 — derived from DECAY so that R(S, t=S) = 0.9.
  static const double factor = 19 / 81;
}
