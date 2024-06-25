import 'package:eventzone/core/presentation/component/dropdown_custom.dart'; // Import your custom dropdown item
import 'package:eventzone/core/resources/app_colors.dart';
import 'package:eventzone/data/remote_source/account_remote_data_source.dart';
import 'package:eventzone/presentation/provider/account_provider.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUniversities();
    });
  }

  Future<void> _fetchUniversities() async {
    final accountProvider = Provider.of<AccountProvider>(context, listen: false);
    final universities = await accountProvider.fetchUniversities();
    setState(() {
      _filteredUniversities = universities; // Update the state with fetched universities
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField<UniversityModel>(
          value: _selectedUniversity,
          decoration: const InputDecoration(
            labelText: 'University',
          ),
          dropdownColor: AppColors.primaryBackground, // Set dropdown background color
          borderRadius: const BorderRadius.all(Radius.circular(20)), // Set border radius
          items: _filteredUniversities.map((uni) {
            return AppDropdownMenuItem<UniversityModel>( // Use your custom dropdown item
              (Text(uni.code)), // Shortened text when selected
              value: uni,
              isSelected: _selectedUniversity == uni,
              child:
              SizedBox(
                width: 350,
                child: Text(uni.name),
              ) ,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedUniversity = value;
            });
            widget.onUniversitySelected(value);
          },
        ),
      ],
    );
  }
}