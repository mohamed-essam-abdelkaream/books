import 'dart:io';

import 'package:books/constants/colors.dart';
import 'package:flutter/material.dart';

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      title: const Text('هل تريد الخروج من التطبيق؟'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffbc8f35)),
          ),
          child: const Text('لا',style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
        ),
        TextButton(
          onPressed: () {
            exit(0);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffa30000)),
          ),
          child: const Text('نعم',style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}

void showExitConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const ExitConfirmationDialog();
    },
  );
}
