
import 'package:cached_network_image/cached_network_image.dart'; // Import for CachedNetworkImage
import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/presentation/provider/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// ... (Your AccountModel class)

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  String? _transactionStatus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginAndFetchAccount();

      _transactionStatus = GoRouterState.of(context).extra as String?;
      if (_transactionStatus != null) {
        Future.delayed(Duration.zero, () {
          _showTransactionStatusDialog(_transactionStatus!);
        });
      }
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  String _getTransactionMessage(String status) {
    switch (status) {
      case "00":
        return "Your transaction was successful!";
      case "01":
      case "02":
        return "Your transaction failed. Please try again.";
      default:
        return "Your transaction is pending. Please check back later.";
    }
  }
  void _showTransactionStatusDialog(String status) {
    String userMessage = _getTransactionMessage(status);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Transaction Status'),
          content: Text(
            userMessage,
            style: const TextStyle(color: Colors.black), // Set text color to black
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showDepositDialog(BuildContext context, AccountProvider accountProvider) {
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deposit'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Enter amount'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Deposit'),
              onPressed: () async {
                final amount = int.tryParse(amountController.text) ?? 0;
                if (amount > 0) {
                  try {
                    // Generate VNPAY payment URL
                    final paymentUrl = await accountProvider.createTransaction(amount);
                    // Dismiss the dialog and redirect to payment page
                    Navigator.pop(context);
                    if(paymentUrl.isNotEmpty)
                    context.goNamed(AppRoutes.vnpay, extra: paymentUrl);
                    else{
                      throw Exception("API respone wrong");
                    }
                  } catch (e) {
                    // Handle errors generating the payment URL
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to initiate payment: ${e.toString()}')),
                    );
                  }
                } else {
                  // Handle invalid amount
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid amount')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkLoginAndFetchAccount() async {
    final accountProvider = Provider.of<AccountProvider>(context, listen: false);
    try {
      await accountProvider.checkLoginStatus(); // Check login and fetch account if logged in
    } catch (e) {
      // Handle token expiration or other errors
      accountProvider.logout(); // Log the user out
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session expired. Please log in again.')),
      );
    }
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
            final account = accountProvider.account!;
            return Center( // Center the entire content
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
                children: [
                  // Account Information
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (account.image.isNotEmpty)
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: CachedNetworkImageProvider(account.image),
                            foregroundImage: const AssetImage('assets/user_image.jpg'),
                          ),
                        const SizedBox(height: 20),
                        Text('Name: ${account.fullName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('Email: ${account.email}'),
                        Text('Date of Birth: ${account.dob.toString().split('T')[0]}'),
                        if (account.university != null)
                          Text('University: ${account.university}'),
                        Text('Balance: \$${account.balance.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),

                  // Logout and Deposit Buttons (Centered Row)
                  const SizedBox(height: 20), // Add spacing above buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center buttons horizontally
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showDepositDialog(context, accountProvider); // Call the dialog function
                          // Navigate to deposit screen (implement this functionality)
                          // context.pushNamed(AppRoutes.deposit);
                        },
                        child: const Text('Deposit'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          accountProvider.logout();
                        },
                        child: const Text('Logout'),
                      ),
                    ],
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
                      context.pushNamed('login');
                      // ...
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to registration screen
                      context.pushNamed('register');
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