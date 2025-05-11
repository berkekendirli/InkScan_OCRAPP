import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkscan_ocr_app/screens/result.dart';

Future<void> pickImageFromGallery(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final Uint8List imageBytes = await pickedFile.readAsBytes();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Result(imageBytes: imageBytes)),
    );
  }
}

Future<void> pickImageFromCamera(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    final Uint8List imageBytes = await pickedFile.readAsBytes();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Result(imageBytes: imageBytes)),
    );
  }
}
