import 'package:eventzone/data/model/category_model.dart';
import 'package:eventzone/data/remote_source/account_remote_data_source.dart';
import 'package:eventzone/presentation/component/event_list.dart';
import 'package:eventzone/presentation/component/search_filters.dart';
import 'package:eventzone/presentation/provider/account_provider.dart';
import 'package:eventzone/presentation/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  EventsScreenState createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  String? _selectedCategory;
  String? _selectedUniversity;
  bool _showFilters = false; // State to control filter visibility
  List<CategoryModel> _categories = []; // Store fetched categories
  List<UniversityModel> _universities = []; // Store fetched categories

  @override
  bool get wantKeepAlive => true;

  Future<void> _loadEvents() async {
    Provider.of<EventsProvider>(context, listen: false).loadInitialEvents(
      searchTerm: _searchTerm,
      category: _selectedCategory,
      university: _selectedUniversity,
    );
  }

  Future<void> _fetchMoreEvents() async {
    try {
      Provider.of<EventsProvider>(context, listen: false).fetchMoreEvents(
        searchTerm: _searchTerm,
        category: _selectedCategory,
        university: _selectedUniversity,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to load more events. Please try again.'),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () => _fetchMoreEvents(),
          ),
        ),
      );
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await Provider.of<EventsProvider>(context,
              listen: false)
          .fetchCategories(); // Assuming you add this method to EventsProvider
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      // Handle error fetching categories
      rethrow;
    }
  }

  Future<void> _fetchUniversities() async {
    setState(() {
    });
    try {
      final universities =
          await Provider.of<AccountProvider>(context, listen: false)
              .fetchUniversities();
      setState(() {
        _universities = universities;
      });
    } catch (e) {
      // Handle error fetching categories
      rethrow;
    } finally {
      setState(() {
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _fetchMoreEvents();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEvents();
      _fetchCategories();
      _fetchUniversities(); // Fetch categories when the screen initializes
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        // Close keyboard and hide search section
        FocusScope.of(context).unfocus();
        setState(() {
          _showFilters = false;
        });
      },
      child: Scaffold(
        appBar: PreferredSize(
          // Animate preferredSize directly
          preferredSize: Size.fromHeight(_showFilters ? 120.0 : kToolbarHeight),
          child: AppBar(
            centerTitle: false,
            title: AnimatedCrossFade(
              firstChild: const Text('Events'), // Title when search is hidden
              secondChild: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search events...',
                  hintStyle: TextStyle(color: Color(0x26ffffff)),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value;
                    _loadEvents();
                  });
                },
              ), // Search field when search is open
              crossFadeState: _showFilters
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
            actions: [
              IconButton(
                icon: Icon(_showFilters ? Icons.close : Icons.search),
                onPressed: () {
                  setState(() {
                    _showFilters = !_showFilters; // Toggle filter visibility
                  });
                },
              ),
            ],
            bottom: _showFilters
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(80.0),
                    child: EventSearchFilters(
                      selectedCategory: _selectedCategory,
                      selectedUniversity: _selectedUniversity,
                      categories: _categories,
                      universities: _universities,
                      onCategoryChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                          _loadEvents();
                        });
                      },
                      onUniversityChanged: (value) {
                        setState(() {
                          _selectedUniversity = value;
                          _loadEvents();
                        });
                      },
                    ),
                  )
                : null,
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.scrollDelta! > 0 && // Scrolling downwards
                _showFilters) {
              setState(() {
                _showFilters = false; // Hide filters
              });
            }
            return true;
          },
          child: EventListView(scrollController: _scrollController),
        ),
      ),
    );
  }
}
