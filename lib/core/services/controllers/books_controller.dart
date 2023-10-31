import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../features/books_screen/models/book_view_model.dart';
import '../../../features/books_screen/models/type_model.dart';

class BooksController extends GetxController {
  RxList<dynamic> showBook = <dynamic>[].obs;
  RxList<BookType> types = <BookType>[].obs;
  ScrollController? scrollController;
  // var booksView = <BookView>[].obs;
  var booksView = (null as BookView?).obs;
  int typesNumber = 1;
  int bookNumber = 1;
  String bookId = '001';

  @override
  void onInit() {
    super.onInit();
    loadBooksName();
  }

  Future<List<BookType>> loadBooksName() async {
    final response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/alheekmahlib/thegarlanded/master/bookName.json"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      types.value = (data['type'] as List)
          .map((data) => BookType.fromJson(data))
          .toList();
      return types;
    } else {
      throw Exception('Failed to load books from the URL');
    }
  }

  Future<void> loadBooksView(String id) async {
    final response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/alheekmahlib/thegarlanded/master/books/$id.json"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> bookData = json.decode(response.body);
      booksView.value = BookView.fromJson(bookData);
    } else {
      throw Exception('Failed to load book from the URL');
    }
  }
}
