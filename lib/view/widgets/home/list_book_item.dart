import 'dart:io';
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../model/book.dart';

class BookItemUI extends StatelessWidget {
  final Book book;
  final Function(String) onDeleteItem;
  final Function() onImageClicked;

  const BookItemUI({
    Key? key,
    required this.book,
    required this.onDeleteItem,
    required this.onImageClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 120,
        child: ListTile(
          onTap: onImageClicked,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.only(bottom: 17,left: 10),
          tileColor: Colors.white,
          title: Center(
            child: Row(
              children: [
                book.imagePath != null
                    ? Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(File(book.imagePath!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Container(),
                const SizedBox(width: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Book position: ${book.id!}',
                          style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          book.bookText!,
                          style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.photo, color: secondColor,size: 30,),
                onPressed: onImageClicked,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: readColor,size: 30,),
                onPressed: () {
                  onDeleteItem(book.id!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
