import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerInput extends StatefulWidget {
  final ValueChanged<File?> onImageSelected;

  const ImagePickerInput({super.key, required this.onImageSelected});

  @override
  ImagePickerInputState createState() => ImagePickerInputState();
}

class ImagePickerInputState extends State<ImagePickerInput> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(_selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Choose Image'),
        ),
        if (_selectedImage != null)
          Image.file(_selectedImage!),
      ],
    );
  }
}