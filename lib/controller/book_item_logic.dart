import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../model/book.dart';

class BookItemLogic {
  static void getImage(Book todo, Function(File?) setImage) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setImage(File(pickedFile.path));
      todo.imagePath = pickedFile.path;
      todo.save();
    } else {
      print('No image selected.');
    }
  }
}
