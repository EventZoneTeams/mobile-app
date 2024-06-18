import 'package:eventzone/data/model/event_detail_model.dart';
import 'package:eventzone/data/remote_source/event_remote_data_source.dart';
import 'package:eventzone/data/repo/event_repository.dart';
import 'package:eventzone/presentation/account_view.dart';
import 'package:eventzone/presentation/event_detail_view.dart';
import 'package:eventzone/presentation/event_view.dart';
import 'package:eventzone/presentation/order_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eventzone/core/presentation/main_page.dart';
import 'package:eventzone/core/resources/app_routes.dart';

const String eventsPath = '/events';
const String orderPath = '/orders';
const String packagesPath = '/packages';
const String accountPath = '/account';
const String eventDetailsPath = 'events/:eventId'; // Note the dynamic segment for eventId

class AppRouter {
  // final OrderRepository _orderRepository = OrderRepository(OrderRemoteDataSource());
  GoRouter get router => GoRouter(
    initialLocation: eventsPath,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            name: AppRoutes.events,
            path: eventsPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventsScreen(),
            ),
            //   )routes: [
            //   GoRoute(
            //     name: AppRoutes.eventDetails,
            //     path: eventDetailsPath,
            //     pageBuilder: (context, state) {
            //       final eventId = int.parse(state.pathParameters['eventId']!);
            //       return NoTransitionPage(
            //         child: EventDetailScreenWrapper(eventId: eventId),
            //       );
            //     },
            //   ),
            //   // ... (other routes)
            //
            // ],
          ),
          GoRoute(
            name: AppRoutes.orders,
            path: orderPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: OrdersScreen(),
            ),
          ),
          // GoRoute(
          //   name: AppRoutes.packages,
          //   path: packagesPath,
          //   pageBuilder: (context, state) => const NoTransitionPage(
          //     child: PackagesView(),
          //   ),
          // ),
          GoRoute(
            name: AppRoutes.account,
            path: accountPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountScreen(),
            ),
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