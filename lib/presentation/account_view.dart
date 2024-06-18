import 'package:eventzone/presentation/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ... (Your AccountModel class)

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AccountProvider>(context, listen: false).checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Consumer<AccountProvider>(
        builder: (context, accountProvider, child) {
          if (accountProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (accountProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(accountProvider.errorMessage));
          } else if (accountProvider.account != null) {
            // User is logged in
            final account = accountProvider.account!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${account.fullName}!'),
                  Text('Email: ${account.email}'),
                  // Display other account details as needed
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      accountProvider.logout(); // Call logout method in provider
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          } else {
            // User is not logged in
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to login screen
                      // ...
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to registration screen
                      // ...
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}