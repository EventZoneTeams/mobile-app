import 'package:eventzone/core/resources/app_router.dart';
import 'package:eventzone/core/resources/app_strings.dart';
import 'package:eventzone/core/resources/app_theme.dart';
import 'package:eventzone/data/remote_source/account_remote_data_source.dart';
import 'package:eventzone/data/remote_source/order_remote_data_source.dart';
import 'package:eventzone/data/repo/account_repository.dart';
import 'package:eventzone/data/repo/order_repository.dart';
import 'package:eventzone/presentation/provider/account_provider.dart';
import 'package:eventzone/presentation/provider/event_provider.dart';
import 'package:eventzone/presentation/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:eventzone/data/remote_source/event_remote_data_source.dart';
import 'package:eventzone/data/repo/event_repository.dart';

import 'presentation/provider/bottom_navigation_provider.dart';
import 'presentation/provider/cart_provider.dart';

void main() async {
  // ... other initialization
  runZonedGuarded(() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EventsProvider(EventsRepository(EventsRemoteDataSource()))),
        ChangeNotifierProvider(create: (context) => OrderProvider(OrderRepository(OrderRemoteDataSource()))),
        ChangeNotifierProvider(create: (context) => AccountProvider(AccountRepository(AccountRemoteDataSource()))),
        ChangeNotifierProvider(create: (context) => CartProvider()), //
        ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
        // Add OrderProvider here
        // ... other providers if needed
      ],
      child: const MyApp(),
    ),
  );
  }, (error, stackTrace) {
    Future.delayed(Duration.zero, () { // Delay to next event loop
      showErrorDialog(MyApp.navigatorKey.currentContext, error);
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>(); // Add a navigator key

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: getApplicationTheme(),
      routerConfig: AppRouter().router,
    );
  }
}
void showErrorDialog(BuildContext? context, Object error) {
  if (context != null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
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
  } else {
    // Handle the case where context is null, e.g., log the error
    print('Error: $error'); // Or use a logging library
  }
}