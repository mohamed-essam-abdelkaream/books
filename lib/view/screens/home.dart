import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/colors.dart';
import '../../model/book.dart';
import '../../controller/book_item_logic.dart';
import '../widgets/home/list_book_item.dart';
import 'add_book_item.dart';
import '../widgets/home/add_new_book.dart';
import '../widgets/home/build_appbar.dart';
import '../widgets/home/build_header.dart';
import '../widgets/home/search_box.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Book> booksList = [];
  List<Book> _foundBook = [];
  final _bookController = TextEditingController();
  final _bookIdController = TextEditingController();
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    if (_isInit) {
      _fetchBooksListLocally();
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const BuildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                SearchBox(
                  controller: _bookController,
                  onChanged: _runFilter,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      const BuildHeader(),
                      _buildBookList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AddBookBar(
            bookController: _bookController,
            bookIdController: _bookIdController,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(
                    booksList: booksList,
                    foundBook: _foundBook,
                    bookController: _bookController,
                    bookIdController: _bookIdController,
                    runFilter: _runFilter,
                    saveBookListLocally: _saveBookListLocally,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _foundBook.length,
      itemBuilder: (context, index) {
        return BookItemUI(
          key: UniqueKey(),
          todo: _foundBook[index],
          onDeleteItem: (id) => _deleteBookItem(id),
          onImageClicked: () => BookItemLogic.getImage(_foundBook[index], (file) {
            // Update UI logic to handle image changes
            setState(() {
              // Update image logic if needed
            });
          }),
        );
      },
    );
  }


  void _fetchBooksListLocally() async {
    List<Book> savedBookList = await Book.fetchBookList();
    setState(() {
      booksList.addAll(savedBookList);
      _foundBook.addAll(savedBookList);
    });
  }

  Future<void> _saveBookListLocally(List<Book> bookList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedList =
    bookList.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('bookList', encodedList);
  }

  void _deleteBookItem(String id) {
    setState(() {
      booksList.removeWhere((item) => item.id == id);
      _foundBook.removeWhere((item) => item.id == id);
      _saveBookListLocally(booksList);
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Book> results = [];
    if (enteredKeyword.isEmpty) {
      results = booksList;
    } else {
      results = booksList
          .where((item) =>
      item.bookText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()) ||
          item.id!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundBook = results;
    });
  }
}
