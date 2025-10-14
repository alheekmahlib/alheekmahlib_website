part of '../../books.dart';

extension BooksStorageGetters on BooksController {
  /// -------- [Getters] --------
  void saveLastRead(
      int pageNumber, String bookName, int bookNumber, int totalPages) {
    state.lastReadPage[bookNumber] = pageNumber;
    state.bookTotalPages[bookNumber] = totalPages;
    state.box.write('lastRead_$bookNumber', {
      'pageNumber': pageNumber,
      'bookName': bookName,
      'totalPages': totalPages,
    });
  }

  // حذف الكتاب من آخر قراءة - Remove book from last read
  void removeFromLastRead(int bookNumber) {
    state.lastReadPage.remove(bookNumber);
    state.bookTotalPages.remove(bookNumber);
    state.box.remove('lastRead_$bookNumber');
    log('Book $bookNumber removed from last read', name: 'BooksStorageGetters');
  }

  void loadLastRead() {
    if (state.booksList.isNotEmpty) {
      for (var book in state.booksList) {
        var lastRead = state.box.read('lastRead_${book.bookNumber}');
        if (lastRead != null) {
          state.lastReadPage[book.bookNumber] = lastRead['pageNumber'];
          log('state.lastReadPage[book.bookNumber]: ${state.lastReadPage[book.bookNumber]}');
          state.bookTotalPages[book.bookNumber] = lastRead['totalPages'];
          log('state.bookTotalPages[book.bookNumber]: ${state.bookTotalPages[book.bookNumber]}');
        }
      }
    } else {
      log('state.booksList is empty.');
    }
  }

  void loadFromGetStorage() {
    state.isTashkil.value = state.box.read(IS_TASHKIL) ?? true;
  }

  void saveDownloadedBooks() {
    List<String> downloadedBooks = state.downloaded.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key.toString())
        .toList();
    log('Saving downloaded books: $downloadedBooks');
    state.box.write(DOWNLOADED_BOOKS, downloadedBooks);
  }

  Future<void> loadDownloadedBooks() async {
    try {
      final List<dynamic>? downloadedBooks = state.box.read(DOWNLOADED_BOOKS);
      log('Loaded downloaded books: $downloadedBooks');
      if (downloadedBooks == null) return; // nothing stored yet
      for (var bookNumber in downloadedBooks) {
        if (bookNumber is String) {
          state.downloaded[int.parse(bookNumber)] = true;
        } else {
          log('Invalid book number format: $bookNumber');
        }
      }
    } catch (e) {
      log('Error loading downloaded books: $e');
    }
  }
}
