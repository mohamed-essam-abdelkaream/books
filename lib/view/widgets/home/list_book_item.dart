import 'dart:io';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../model/book.dart';

class BookItemUI extends StatelessWidget {
  final Book todo;
  final Function(String) onDeleteItem;
  final Function() onImageClicked;

  const BookItemUI({
    Key? key,
    required this.todo,
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
                todo.imagePath != null
                    ? Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(File(todo.imagePath!)),
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
                          todo.id!,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          todo.bookText!,
                          style: const TextStyle(fontSize: 18),
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
                icon: const Icon(Icons.photo, color: primaryColor,size: 30,),
                onPressed: onImageClicked,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: readColor,size: 30,),
                onPressed: () {
                  onDeleteItem(todo.id!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
