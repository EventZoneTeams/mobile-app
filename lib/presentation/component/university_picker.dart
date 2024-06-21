import 'package:eventzone/data/remote_source/account_remote_data_source.dart';
import 'package:eventzone/presentation/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UniversityPicker extends StatefulWidget {
  final ValueChanged<UniversityModel?> onUniversitySelected;

  const UniversityPicker({super.key, required this.onUniversitySelected});

  @override
  UniversityPickerState createState() => UniversityPickerState();
}

class UniversityPickerState extends State<UniversityPicker> {
  UniversityModel? _selectedUniversity;
  List<UniversityModel> _filteredUniversities = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchUniversities();
  }

  Future<void> _fetchUniversities() async {
    final accountProvider = Provider.of<AccountProvider>(context, listen: false);
    await accountProvider.fetchUniversities();
    setState(() {
      _filteredUniversities = accountProvider.universities;
    });
  }

  void _filterUniversities(String query) {
    setState(() {
      _searchQuery = query;
      _filteredUniversities = Provider.of<AccountProvider>(context, listen: false)
          .universities
          .where((uni) => uni.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: _filterUniversities,
          decoration: const InputDecoration(
            labelText: 'Search University',
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<UniversityModel>(
          value: _selectedUniversity,
          decoration: const InputDecoration(
            labelText: 'University',
          ),
          items: _filteredUniversities.map((uni) {
            return DropdownMenuItem<UniversityModel>(
              value: uni,
              child: Text(uni.name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedUniversity = value;
            });
            widget.onUniversitySelected(value); // Notify parent widget
          },
          validator: (value) {
            if (value == null && _searchQuery.isNotEmpty) {
              return 'Please select a university from the list';
            }
            return null;
          },
        ),
      ],
    );
  }
}