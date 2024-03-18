import 'package:csi_app/models/event_model/event_model.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/providers/csi_event_provider.dart';
import 'package:csi_app/screens/home_screens/event_screens/add_event_screen.dart';
import 'package:csi_app/side_transition_effects/bottom_top.dart';
import 'package:csi_app/side_transition_effects/left_right.dart';
import 'package:csi_app/utils/helper_functions/date_format.dart';
import 'package:csi_app/utils/helper_functions/function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Consumer2<AppUserProvider, CSIEventProvider>(builder: (context, appUserProvider, csiEventProvider, child){
      return Container(
        height: 155,
        child: InkWell(
          onTap: (){
            if((appUserProvider.user?.isAdmin ?? false) || (appUserProvider.user?.isSuperuser ?? false)){
              csiEventProvider.event = widget.csiEvent;
              csiEventProvider.forEditing = true;
              Navigator.push(context, BottomToTop(AddEventScreen()));
            }
          },
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
        ),
      );
    });
  }
}
