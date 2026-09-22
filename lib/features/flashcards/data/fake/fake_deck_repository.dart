import '../../domain/entities/deck.dart';
import '../../domain/entities/note.dart';
import '../../domain/enums/note_type.dart';
import '../../domain/repositories/deck_repository.dart';

/// In-memory seed matching the Home page mockup (Lei 8.112/90, TJSP —
/// Analista de Sistemas) so the UI has realistic data to render before the
/// Drift-backed repository exists.
class FakeDeckRepository implements DeckRepository {
  final List<Deck> _decks = const [
    Deck(
      id: 'deck-1',
      title: 'Lei 8.112/90',
      examBoard: 'VUNESP',
      subject: 'Direito Administrativo',
      price: 19.9,
      version: '1.0.0',
      author: 'FlashConcurso',
      description: 'Regime Jurídico Único dos servidores públicos federais.',
    ),
    Deck(
      id: 'deck-2',
      title: 'Lei 9.784/99',
      examBoard: 'VUNESP',
      subject: 'Direito Administrativo',
      price: 14.9,
      version: '1.0.0',
      author: 'FlashConcurso',
      description: 'Processo administrativo federal.',
    ),
    Deck(
      id: 'deck-3',
      title: 'Constituição Federal — Art. 5º',
      examBoard: 'VUNESP',
      subject: 'Direito Constitucional',
      price: 24.9,
      version: '1.0.0',
      author: 'FlashConcurso',
      description: 'Direitos e garantias fundamentais.',
    ),
  ];

  final Map<String, List<Note>> _notesByDeck = {
    'deck-1': const [
      Note(
        id: 'deck-1-note-1',
        deckId: 'deck-1',
        type: NoteType.cloze,
        fields: {
          'text':
              'O servidor nomeado para cargo de provimento efetivo fica sujeito a '
                  'estágio probatório por {{c1::24 (vinte e quatro) meses}}, período em que '
                  'sua {{c2::aptidão e capacidade}} serão objeto de avaliação.',
        },
      ),
      Note(
        id: 'deck-1-note-2',
        deckId: 'deck-1',
        type: NoteType.basic,
        fields: {
          'front': 'Qual o prazo de validade do concurso público, segundo a Lei 8.112/90?',
          'back': 'Até 2 anos, prorrogável uma vez por igual período.',
        },
      ),
    ],
  };

  @override
  Future<List<Deck>> getAll() async => _decks;

  @override
  Future<Deck?> getById(String id) async {
    for (final deck in _decks) {
      if (deck.id == id) return deck;
    }
    return null;
  }

  @override
  Future<List<Note>> getNotes(String deckId) async => _notesByDeck[deckId] ?? const [];
}
