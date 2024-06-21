import 'package:eventzone/presentation/bottom_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eventzone/core/resources/app_router.dart';
import 'package:eventzone/core/resources/app_strings.dart';

import 'package:eventzone/core/resources/app_routes.dart';
import 'package:eventzone/core/resources/app_values.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          final String location = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
          if (!location.startsWith(eventsPath)) {
            Provider.of<BottomNavigationProvider>(context, listen: false).updateSelectedIndex(0);
          }
        },
        child: widget.child,
      ),
      bottomNavigationBar: Consumer<BottomNavigationProvider>(
        builder: (context, provider, _) {
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
            currentIndex: provider.selectedIndex,
            onTap: (index) {
              provider.updateSelectedIndex(index);
              // Handle navigation
              switch (index) {
                case 0:
                  context.goNamed(AppRoutes.events);
                  break;
                case 1:
                  context.goNamed(AppRoutes.orders);
                  break;
                case 2:
                // Correct the navigation for case 2 if needed
                // context.goNamed(correctRoute);
                  break;
                case 3:
                  context.goNamed(AppRoutes.account);
                  break;
              }
            },
          );
        },
      ),
    );
  }
}