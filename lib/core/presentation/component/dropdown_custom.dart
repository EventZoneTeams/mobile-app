
import 'package:flutter/material.dart';
import 'package:eventzone/core/resources/app_colors.dart';

// ... (Your existing getApplicationTheme and _getTextStyle functions)
class AppDropdownMenuItem<T> extends DropdownMenuItem<T> {
  const AppDropdownMenuItem(this.isSelectedChild, {
    super.key,
    required super.value,
    required super.child,
    required this.isSelected, // Add isSelected parameter
// Optional text to display when selected
  });

  final bool isSelected; // Add isSelected property
  final Widget isSelectedChild;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: AppColors.primaryBackground,
      ),
      child: Align( // Use Align widget for vertical centering
        alignment: Alignment.centerLeft,
        child: DefaultTextStyle(
          style: Theme.of(context).dropdownMenuTheme.textStyle!.copyWith(
            color: AppColors.secondaryText,
            backgroundColor: Colors.transparent,
            fontSize: 16,
          ),
          overflow: TextOverflow.visible, // Allow text to extend beyond bounds
          child: isSelected ? isSelectedChild : child,
        )
      ),
    );
  }
}