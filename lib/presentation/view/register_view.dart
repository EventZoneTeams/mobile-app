import 'dart:io';

import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/data/model/account_model.dart';
import 'package:eventzone/data/remote_source/account_remote_data_source.dart';
import 'package:eventzone/presentation/provider/account_provider.dart';
import 'package:eventzone/presentation/component/university_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _imageController = TextEditingController();
  final _universityController = TextEditingController();
  DateTime? _selectedDate; // To store the selected date
  UniversityModel? _selectedUniversity; // To store the selected university
  File? _selectedImage; // To store the selected image
  String? _selectedGender; // To store the selected gender

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }


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
        _dobController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    });
  }

  Future<void> _registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final account = RegisterAccountModel(
        email: _emailController.text,
        password: _passwordController.text,
        fullName: _fullNameController.text,
        dob: _dobController.text,
        gender: _selectedGender ?? 'NotMale', // Provide a default value if no gender is selected
        university: _selectedUniversity?.name ?? 'NotFPTU',
        image: _imageController.text,
      );
      // Trigger registration and store the result
      final registrationResult = await Provider.of<AccountProvider>(context, listen: false).register(account);

      // Check registration status and provide feedback AFTER the async operation
      if (mounted) { // Check if the widget is still mounted
        final accountProvider = Provider.of<AccountProvider>(context, listen: false);
        if (accountProvider.errorMessage.isEmpty) {
          // Registration successful
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful!')),
          );
          // Navigate to account screen (replace with your actual route)
          context.goNamed(AppRoutes.account);
        } else {
          // Registration failed
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Registration Error'),
              content: Text(
                  accountProvider.errorMessage,
                  style: const TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _dobController,
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  readOnly: true,
                  onTap: _presentDatePicker, // Call the date picker function
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: const InputDecoration(labelText: 'Gender'),
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Choose Image'),
                ),
                if (_selectedImage != null)
                  Image.file(_selectedImage!),
                const SizedBox(height: 20),
                UniversityPicker(
                  onUniversitySelected: (university) {
                    setState(() {
                      _selectedUniversity = university;
                    });
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _registerUser(context),
                  child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    context.pushNamed(AppRoutes.login); // Use named route
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
