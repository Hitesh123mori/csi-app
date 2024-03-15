import 'package:flutter/material.dart';

import '../../colors.dart';

class ThreeDotButton extends StatelessWidget {
  final List<String> options;
  final Function(String) onOptionSelected;

  ThreeDotButton({required this.options, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.theme["secondaryColor"],
      surfaceTintColor: AppColors.theme["secondaryColor"],
      itemBuilder: (BuildContext context) => options.map((option) {
        return PopupMenuItem<String>(
          value: option.toLowerCase(),
          child: Text(option),
        );
      }).toList(),
      onSelected: (String value) {
        // Handle option selection by calling the provided callback
        onOptionSelected(value);
        print("object");
      },
      icon: Icon(Icons.more_vert),
    );
  }
}