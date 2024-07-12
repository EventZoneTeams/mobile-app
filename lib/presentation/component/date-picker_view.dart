import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateOfBirthInput extends StatefulWidget {
  final TextEditingController controller;

  const DateOfBirthInput({super.key, required this.controller});

  @override
  DateOfBirthInputState createState() => DateOfBirthInputState();
}

class DateOfBirthInputState extends State<DateOfBirthInput> {
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        widget.controller.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(labelText: 'Date of Birth'),
      readOnly: true,
      onTap: _presentDatePicker,
    );
  }
}