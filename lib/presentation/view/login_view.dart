import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/presentation/provider/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  BuildContext? _dialogContext;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                  return null; // Return null if validation passes
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
                  return null; // Return null if validation passes
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final accountProvider =
                        Provider.of<AccountProvider>(context, listen: false);

                    // Show loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context)  {
                      _dialogContext = context; // Store the dialog context
                       return const Center(child: CircularProgressIndicator());
                    }
                    );

                    try {
                      await accountProvider.login(
                          _emailController.text, _passwordController.text);

                      // Login successful
                      if (mounted) {
                        if (_dialogContext != null) {
                          Navigator.pop(_dialogContext!); // Dismiss the dialog
                        }
                        context.goNamed(AppRoutes
                            .account); // Navigate after loading state is updated
                      }
                    } catch (e) {
                      // Login failed, display error message
                      if (mounted) {
                        if (_dialogContext != null) {
                          Navigator.pop(_dialogContext!);
                        }// Dismiss the dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(e.toString())
                        ));
                      }
                    }
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.register);
                },
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
