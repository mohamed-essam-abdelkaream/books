import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class AddBookBar extends StatelessWidget {
  final TextEditingController bookController;
  final TextEditingController bookIdController;
  final Function() onPressed;

  const AddBookBar({
    required this.bookController,
    required this.bookIdController,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            minimumSize: const Size(60, 60),
            elevation: 10,
          ),
          child: const Text(
            '+',
            style: TextStyle(
              fontSize: 30,
              color: darkColor,
            ),
          ),
        ),
      ),
    );
  }
}
