import 'package:eventzone/core/resources/app_router.dart';
import 'package:eventzone/core/resources/app_strings.dart';
import 'package:eventzone/core/resources/app_theme.dart';
import 'package:eventzone/data/remote_source/account_remote_data_source.dart';
import 'package:eventzone/data/remote_source/order_remote_data%20source.dart';
import 'package:eventzone/data/repo/account_repository.dart';
import 'package:eventzone/data/repo/order_repository.dart';
import 'package:eventzone/presentation/account_provider.dart';
import 'package:eventzone/presentation/event_provider.dart';
import 'package:eventzone/presentation/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eventzone/data/remote_source/event_remote_data_source.dart';
import 'package:eventzone/data/repo/event_repository.dart';

import 'presentation/bottom_navigation_provider.dart';

// ... (Your EventsProvider class as defined above)

void main() async {
  // ... other initialization

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EventsProvider(EventsRepository(EventsRemoteDataSource()))),
        ChangeNotifierProvider(create: (context) => OrderProvider(OrderRepository(OrderRemoteDataSource()))),
        ChangeNotifierProvider(create: (context) => AccountProvider(AccountRepository(AccountRemoteDataSource()))),
        ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
        // Add OrderProvider here
        // ... other providers if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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