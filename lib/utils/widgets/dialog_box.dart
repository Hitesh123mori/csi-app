import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? actionButton1Name;
  final String? actionButton2Name;
  final Function()? onAction1Pressed;
  final Function()? onAction2Pressed;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    this.onAction1Pressed,
    this.onAction2Pressed,
    this.actionButton1Name,
    this.actionButton2Name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: onAction1Pressed,
          child: Text(actionButton1Name ?? ""),
        ),
        TextButton(
          onPressed: onAction2Pressed,
          child: Text(actionButton2Name ?? ""),
        ),
      ],
    );
  }
}
