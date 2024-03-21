import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Book {
  String? id;
  String? bookText;
  bool isDone;
  String? imagePath;

  Book({
    required this.id,
    required this.bookText,
    this.imagePath,
    this.isDone = false,
  });

  static Future<List<Book>> fetchBookList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookListJson = prefs.getStringList('bookList');
    if (bookListJson != null) {
      List<Book> bookList =
      bookListJson.map((e) => Book.fromJson(json.decode(e))).toList();
      return bookList;
    } else {
      return [];
    }
  }

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Book> bookList = await fetchBookList();
    int index = bookList.indexWhere((element) => element.id == id);
    if (index != -1) {
      bookList[index] = this;
    }
    List<String> encodedList =
    bookList.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('bookList', encodedList);
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      bookText: json['bookText'],
      imagePath: json['imagePath'],
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookText': bookText,
      'imagePath': imagePath,
      'isDone': isDone,
    };
  }
}