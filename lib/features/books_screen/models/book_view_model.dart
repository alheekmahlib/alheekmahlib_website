class BookView {
  final String title;
  final String author;
  final List<Chapter> chapters;

  BookView({
    required this.title,
    required this.author,
    required this.chapters,
  });

  factory BookView.fromJson(Map<String, dynamic> json) {
    return BookView(
      title: json['title'],
      author: json['author'],
      chapters: (json['chapters'] as List)
          .map((data) => Chapter.fromJson(data))
          .toList(),
    );
  }
}

class Chapter {
  final String chapterNumber;
  final String? id;
  final String title;
  final String content;
  final String pageNum;

  Chapter({
    required this.chapterNumber,
    required this.id,
    required this.title,
    required this.content,
    required this.pageNum,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapterNumber: json['chapter_number'],
      id: json['id'] as String,
      title: json['title'],
      content: json['content'],
      pageNum: json['pageNum'],
    );
  }
}
