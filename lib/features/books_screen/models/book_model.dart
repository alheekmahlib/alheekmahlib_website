class Book {
  String id;
  String title;
  String bookD;
  String type;
  String bookQuoted;
  String aboutBook;

  Book({
    required this.id,
    required this.title,
    required this.bookD,
    required this.type,
    required this.bookQuoted,
    required this.aboutBook,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      bookD: json['bookD'],
      type: json['type'],
      bookQuoted: json['bookQuoted'],
      aboutBook: json['aboutBook'],
    );
  }

  @override
  String toString() {
    return 'Book(id: $id, title: $title)';
  }
}
