import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../models/event_model/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  const EventCard({super.key, required this.onTap, required this.event});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Card(
            color: AppColors.theme['secondaryColor'],
            surfaceTintColor: AppColors.theme['secondaryColor'],
            child: ListTile(
              isThreeLine: true,
              title: Text(
                event.name,
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.theme['tertiaryColor'],
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${event.date}\n${event.type}",
                  style: TextStyle(fontSize: 12)),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 32,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
