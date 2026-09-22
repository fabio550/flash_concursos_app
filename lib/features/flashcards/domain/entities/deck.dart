class Deck {
  final String id;
  final String title;
  final String examBoard;
  final String subject;
  final double price;
  final String version;
  final String author;
  final String? description;

  const Deck({
    required this.id,
    required this.title,
    required this.examBoard,
    required this.subject,
    required this.price,
    required this.version,
    required this.author,
    this.description,
  });
}
