import '../enums/note_type.dart';

/// Content typed once. [fields] shape depends on [type]:
/// - `basic`/`basicReversed`: {'front': ..., 'back': ...}
/// - `cloze`: {'text': 'Law {{c1::8.112/90}} governs federal civil servants {{c2::employment regime}}.'}
class Note {
  final String id;
  final String deckId;
  final NoteType type;
  final Map<String, String> fields;

  const Note({
    required this.id,
    required this.deckId,
    required this.type,
    required this.fields,
  });
}
