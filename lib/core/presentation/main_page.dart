import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eventzone/core/resources/app_router.dart';
import 'package:eventzone/core/resources/app_strings.dart';

import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/core/resources/app_values.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          final String location = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
          if (!location.startsWith(eventsPath)) {
            _onItemTapped(0);
          }
        },
        child: widget.child,
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, index, _) {
          return BottomNavigationBar(
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
            currentIndex: index,
            onTap: _onItemTapped,
          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    _selectedIndex.value = index;

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