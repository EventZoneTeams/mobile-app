import 'package:eventzone/core/presentation/component/dropdown_custom.dart';
import 'package:eventzone/core/resources/app_colors.dart';
import 'package:eventzone/data/model/category_model.dart';
import 'package:eventzone/data/remote_source/account_remote_data_source.dart';
import 'package:flutter/material.dart';

class EventSearchFilters extends StatefulWidget {
  final String? selectedCategory;
  final String? selectedUniversity;
  final List<CategoryModel> categories;
  final Function(String?) onCategoryChanged;
  final Function(String?) onUniversityChanged;
  final List<UniversityModel> universities;

  @override
  EventSearchFiltersState createState() => EventSearchFiltersState();

  const EventSearchFilters({
    super.key,
    required this.selectedCategory,
    required this.selectedUniversity,
    required this.categories,
    required this.universities,
    required this.onCategoryChanged,
    required this.onUniversityChanged,
  });
}

class EventSearchFiltersState extends State<EventSearchFilters> {
  String? _selectedUniversityCode;

  @override
  void initState() {
    super.initState();
    _selectedUniversityCode = widget.selectedUniversity;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // University Dropdown (65% width)
                Flexible(
                  flex: 35,
                  child: DropdownButtonFormField<String>(
                    value: _selectedUniversityCode,
                    decoration: const InputDecoration(
                      labelText: 'University',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    ),
                    dropdownColor: AppColors.primaryBackground,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    items: widget.universities.map((university) {
                      return AppDropdownMenuItem(
                        (Text(university.code)),
                        value: university.code,
                        isSelected: _selectedUniversityCode == university.code,
                        child: SizedBox(
                          width: 100, // Consider adjusting this width if needed
                          child: Text(university.name),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUniversityCode = value;
                      });
                      widget.onUniversityChanged(value);
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                // Category Dropdown (35% width)
                Flexible(
                  flex: 55,
                  child: DropdownButtonFormField<String>(
                    value: widget.selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    dropdownColor: AppColors.primaryBackground,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    items: widget.categories.map((category) {
                      return AppDropdownMenuItem(
                        (Text(
                          category.title,
                          style: const TextStyle(
                              backgroundColor: Colors.transparent),
                        )),
                        value: category.id.toString(),
                        isSelected: widget.selectedCategory ==
                            category.id.toString(), // Correct isSelected logic
                        child: Text(
                          category.title,
                          style: const TextStyle(
                              backgroundColor: Colors.transparent),
                        ),
                      );
                    }).toList(),
                    onChanged: widget.onCategoryChanged,
                  ),
                ),
                // Removed unnecessary SizedBox
              ],
            ),
            // ... (other widgets in the Column)
          ],
        ),
      ),
    );
  }
}
