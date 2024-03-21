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
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: bookIdController,
              keyboardType: TextInputType.number,
              hintText: 'Add Book Position',
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: bookController,
              keyboardType: TextInputType.text,
              hintText: 'Add new Book',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addBookItem(context),
              style : ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(primaryColor)),
              child: const Text('Add Book',style: TextStyle(color: whiteColor,fontSize: 16),)
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
      // Insert the new book at the beginning of the list
      booksList.insert(0, newBook);
      saveBookListLocally(booksList);
      bookController.clear();
      bookIdController.clear();
      runFilter(bookController.text);
      Navigator.pop(context); // Close the Add Book page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }
}
