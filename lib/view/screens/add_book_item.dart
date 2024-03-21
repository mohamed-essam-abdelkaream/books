import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../model/book.dart';
import '../widgets/add_book_item/custom_text_field.dart';

class AddBookPage extends StatelessWidget {
  final List<Book> booksList;
  final List<Book> foundBook;
  final TextEditingController bookController;
  final TextEditingController bookIdController;
  final Function(String) runFilter;
  final Function(List<Book>) saveBookListLocally;

  const AddBookPage({super.key,
    required this.booksList,
    required this.foundBook,
    required this.bookController,
    required this.bookIdController,
    required this.runFilter,
    required this.saveBookListLocally,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      appBar: AppBar(
        backgroundColor: darkColor,
        title: const Text('Add Book',style: TextStyle(fontWeight:FontWeight.bold, color: secondColor),),
        iconTheme: const IconThemeData(color: secondColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: bookIdController,
              keyboardType: TextInputType.number,
              labelText: 'Book id',
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: bookController,
              keyboardType: TextInputType.text,
              labelText: 'Book name',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addBookItem(context),
              style : ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(secondColor)),
              child: const Text('Add Book',style: TextStyle(color: primaryColor,fontSize: 16,fontWeight: FontWeight.bold),)
            ),
          ],
        ),
      ),
    );
  }

  void _addBookItem(BuildContext context) {
    if (bookController.text.isNotEmpty && bookIdController.text.isNotEmpty) {
      final newBook = Book(
        id: bookIdController.text,
        bookText: bookController.text,
      );
      booksList.insert(0, newBook);
      saveBookListLocally(booksList);
      bookController.clear();
      bookIdController.clear();
      runFilter(bookController.text);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }
}