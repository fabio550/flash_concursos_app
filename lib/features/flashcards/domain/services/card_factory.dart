import '../entities/flashcard.dart';
import '../entities/note.dart';
import '../enums/note_type.dart';
import 'cloze_parser.dart';

/// Generates the fresh (never-reviewed) [Flashcard]s a [Note] produces.
/// A card's id is deterministic (`<noteId>::<variantIndex>`) so no id
/// generator/UUID dependency is needed at this layer.
class CardFactory {
  CardFactory._();

  static List<Flashcard> generate(Note note, {DateTime? now}) {
    final due = now ?? DateTime.now();
    switch (note.type) {
      case NoteType.basic:
        return [_card(note, 0, due)];
      case NoteType.basicReversed:
        return [_card(note, 0, due), _card(note, 1, due)];
      case NoteType.cloze:
        final text = note.fields['text'] ?? '';
        final indices = ClozeParser.extractIndices(text);
        return indices.map((i) => _card(note, i, due)).toList();
    }
  }

  static Flashcard _card(Note note, int variantIndex, DateTime due) {
    return Flashcard(
      id: '${note.id}::$variantIndex',
      noteId: note.id,
      deckId: note.deckId,
      variantIndex: variantIndex,
      due: due,
    );
  }
}
