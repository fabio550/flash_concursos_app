/// Extracts the cloze indices (`{{c1::...}}`, `{{c2::...}}`, ...) from a
/// cloze note's text. Blanks sharing the same number become a single card
/// — revealed together — hence the `Set`-like (deduplicated) result.
class ClozeParser {
  ClozeParser._();

  static final RegExp _pattern = RegExp(r'\{\{c(\d+)::');

  static List<int> extractIndices(String text) {
    final indices = _pattern
        .allMatches(text)
        .map((m) => int.parse(m.group(1)!))
        .toSet()
        .toList();
    indices.sort();
    return indices;
  }
}
