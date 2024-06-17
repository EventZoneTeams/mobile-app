import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eventzone/core/resources/app_router.dart';
import 'package:eventzone/core/resources/app_strings.dart';

import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/core/resources/app_values.dart';

class MainPage extends StatefulWidget {
  final Widget child; // Add the child parameter

  const MainPage({Key? key, required this.child}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Track the currently selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          // Access location using GoRouter.of(context).routerDelegate.currentConfiguration.location
          final String location = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
          if (!location.startsWith(eventsPath)) {
            _onItemTapped(0); // No need to pass context here
          }
        },
        child: widget.child, // Use widget.child to access the passed child
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: AppStrings.event,
            icon: Icon(
              Icons.movie_creation_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.order,
            icon: Icon(
              Icons.tv_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.package,
            icon: Icon(
              Icons.search_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.account,
            icon: Icon(
              Icons.bookmark_rounded,
              size: AppSize.s20,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    // Navigate to the corresponding route using GoRouter
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.events);
        break;
      case 1:
        context.goNamed(AppRoutes.orders);
        break;
      case 2:
        context.goNamed(AppRoutes.orders);
        break;
      case 3:
        context.goNamed(AppRoutes.account);
        break;
    }
  }
}