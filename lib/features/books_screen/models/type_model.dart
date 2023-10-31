import 'book_model.dart';

class BookType {
  String number;
  String name;
  List<Book> books;

  BookType({required this.number, required this.name, required this.books});

  factory BookType.fromJson(Map<String, dynamic> json) {
    return BookType(
      number: json['number'],
      name: json['name'],
      books: (json['books'] as List).map((i) => Book.fromJson(i)).toList(),
    );
  }

  @override
  String toString() {
    return 'BookType(number: $number, name: $name, books: $books)';
  }
}
