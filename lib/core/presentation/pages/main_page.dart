import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eventzone/core/resources/app_router.dart';
import 'package:eventzone/core/resources/app_strings.dart';

import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/core/resources/app_values.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
          onPopInvoked : (didPop) async  {
          final String location = GoRouterState.of(context).location;
          if (!location.startsWith(eventsPath)) {
            _onItemTapped(0, context);
          }
        },
        child: widget.child,
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
            label: AppStrings.event,
            icon: Icon(
              Icons.tv_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.event,
            icon: Icon(
              Icons.search_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.event,
            icon: Icon(
              Icons.bookmark_rounded,
              size: AppSize.s20,
            ),
          ),
        ],
        currentIndex: _getSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith(eventsPath)) {
      return 0;
    }
    if (location.startsWith(userPath)) {
      return 1;
    }
    if (location.startsWith(searchPath)) {
      return 2;
    }
    if (location.startsWith(watchlistPath)) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.event);
        break;
      case 1:
        context.goNamed(AppRoutes.user);
        break;
      case 2:
        context.goNamed(AppRoutes.watchlist);
        break;
      case 3:
        context.goNamed(AppRoutes.search);
        break;
    }
  }
}
