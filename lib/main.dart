import 'package:eventzone/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/resources/app_router.dart';
import 'package:eventzone/core/resources/app_strings.dart';
import 'package:eventzone/core/resources/app_theme.dart';
import 'package:eventzone/core/services/service_locator';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MediaAdapter());
  await Hive.openBox('items');
  ServiceLocator.init();

  runApp(
    BlocProvider(
      create: (context) => sl<WatchlistBloc>(),
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
