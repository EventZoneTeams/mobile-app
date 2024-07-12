import 'package:eventzone/data/model/event_detail_model.dart';
import 'package:eventzone/data/remote_source/event_remote_data_source.dart';
import 'package:eventzone/data/repo/event_repository.dart';
import 'package:eventzone/presentation/view/cart_screen.dart';
import 'package:eventzone/presentation/view/event_package_view.dart';
import 'package:eventzone/presentation/view/event_product_view.dart';
import 'package:eventzone/presentation/view/account_view.dart';
import 'package:eventzone/presentation/view/event_detail_view.dart';
import 'package:eventzone/presentation/view/event_view.dart';
import 'package:eventzone/presentation/view/login_view.dart';
import 'package:eventzone/presentation/view/order_view.dart';
import 'package:eventzone/presentation/view/register_view.dart';
import 'package:eventzone/presentation/view/vnpay_web-view-container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eventzone/core/presentation/main_page.dart';
import 'package:eventzone/core/resources/app_routes.dart';

const String eventsPath = '/events';
const String orderPath = '/orders';
const String accountPath = '/account';
const String vnpayPath = '/vnpay';
const String eventDetailsPath = ':eventId';
const String loginPath = 'login';
const String registerPath = 'register';
const String packagesPath = 'packages';
const String packageProductsPath = ':packageId';
const String cartPath = 'cart';

class AppRouter {
  GoRouter get router => GoRouter(
    initialLocation: eventsPath,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          // Events Section
          GoRoute(
            name: AppRoutes.events,
            path: eventsPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventsScreen(),
            ),
            routes: [
              // Event Details and Related Routes
              GoRoute(
                name: AppRoutes.eventDetails,
                path: eventDetailsPath,
                builder: (context, state) {
                  final eventId = int.parse(state.pathParameters['eventId']!);
                  return EventDetailScreenWrapper(eventId: eventId);
                },
                routes: [
                  // Event Packages
                  GoRoute(
                    name: AppRoutes.packages,
                    path: packagesPath,
                    builder: (context, state) {
                      final eventId = int.parse(state.pathParameters['eventId']!);
                      return EventPackagesScreen(eventId: eventId);
                    },
                    routes: [
                      // Improved Cart Route
                      GoRoute(
                        name: AppRoutes.cart,
                        path: cartPath,
                        builder: (context, state) {
                          final eventId = int.parse(state.pathParameters['eventId']!); // Use state.pathParameters
                          return CartScreen(eventId: eventId);
                        },
                      ),
                      // Package Products
                      GoRoute(
                        name: AppRoutes.packageProducts,
                        path: packageProductsPath,
                        builder: (context, state) {
                          final package = state.extra as EventPackageModel;
                          return EventPackageProductsScreen(package: package);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Orders Section
          GoRoute(
            name: AppRoutes.orders,
            path: orderPath,
            builder: (context, state) => const OrdersScreen(),
          ),

          // Account Section
          GoRoute(
            name: AppRoutes.account,
            path: accountPath,
            builder: (context, state) => const AccountScreen(),
            routes: [
              GoRoute(
                name: AppRoutes.login,
                path: loginPath,
                builder: (context, state) => const LoginScreen(),
              ),
              GoRoute(
                name: AppRoutes.register,
                path: registerPath,
                builder: (context, state) => const RegistrationScreen(),
              ),
            ],
          ),

          // VnPay Payment
          GoRoute(
            name: AppRoutes.vnpay,
            path: vnpayPath,
            pageBuilder: (context, state) {
              final url = state.extra as String;
              return NoTransitionPage(child: VnPayWebView(url: url));
            },
          ),
        ],
      ),
    ],
  );
}
// Wrapper widget to handle event ID and build EventDetailScreen
class EventDetailScreenWrapper extends StatefulWidget {
  final int eventId;

  const EventDetailScreenWrapper({super.key, required this.eventId});

  @override
  EventDetailScreenWrapperState createState() => EventDetailScreenWrapperState();
}

class EventDetailScreenWrapperState extends State<EventDetailScreenWrapper> {
  late Future<EventDetailModel> _eventFuture;

  @override
  void initState() {
    super.initState();
    _eventFuture = _fetchEventDetails();
  }

  Future<EventDetailModel> _fetchEventDetails() async {
    final eventRepository = EventsRepository(EventsRemoteDataSource());
    return eventRepository.getEventById(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventDetailModel>(
      future: _eventFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return EventDetailScreen(event: snapshot.data!);
        } else {
          return const Center(child: Text('No event found.'));
        }
      },
    );
  }
}