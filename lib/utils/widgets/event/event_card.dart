import 'package:csi_app/models/event_model/event_model.dart';
import 'package:csi_app/utils/helper_functions/date_format.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';

class EventCard extends StatefulWidget {
  final CSIEvent csiEvent;
  const EventCard({
    super.key,
    required this.csiEvent,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      child: Card(
        elevation: 1,
        color: AppColors.theme["secondaryBgColor"],
        clipBehavior: Clip.hardEdge,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: Image.asset(
                      "assets/images/event_images.jpg",
                      fit: BoxFit.fitWidth,
                      // max-height: 80,
                      alignment: Alignment.topCenter,
                    ))),
                  ],
                ),
                Expanded(child: Container(color: AppColors.theme["secondaryBgColor"]))
              ],
            ),
            Container(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.theme["primaryColor"],
                  child: Icon(
                    Icons.calendar_month,
                    color: AppColors.theme["secondaryColor"],
                  ),
                ),
                title: Text(
                  widget.csiEvent.eventName ?? "Event",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                    "${MyDateUtil.formatMillisecondsToDateString(widget.csiEvent.startDate ?? "")} to ${MyDateUtil.formatMillisecondsToDateString(widget.csiEvent.endDate ?? "")}"),
                trailing: ElevatedButton(
                    child: Text(
                      "Resigter",
                      style: TextStyle(color: AppColors.theme["secondaryColor"]),
                    ),
                    onPressed: () {
                      HelperFunctions.launchURL(widget.csiEvent.registerUrl ?? "");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.theme["primaryColor"]),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
