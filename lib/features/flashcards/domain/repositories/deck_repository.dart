import '../entities/deck.dart';
import '../entities/note.dart';

abstract class DeckRepository {
  Future<List<Deck>> getAll();

  Future<Deck?> getById(String id);

  Future<List<Note>> getNotes(String deckId);
}
