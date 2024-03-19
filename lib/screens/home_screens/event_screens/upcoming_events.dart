import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csi_app/models/event_model/event_model.dart';
import 'package:csi_app/screens/home_screens/event_screens/add_event_screen.dart';
import 'package:csi_app/side_transition_effects/bottom_top.dart';
import 'package:csi_app/utils/shimmer_effects/event_card_shimmer_effect.dart';
import 'package:flip_panel_plus/flip_panel_plus.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:provider/provider.dart';

import '../../../apis/FireStoreAPIs/EventAPIs.dart';
import '../../../utils/colors.dart';
import '../../../utils/widgets/event/event_card.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  bool _isFirst = false;
  Duration? duration;

  @override
  Widget build(BuildContext context) {
    if(_isFirst) _isFirst = false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.theme['primaryColor'],
          onPressed: () {
            Navigator.push(context, BottomToTop(AddEventScreen()));
          },
          child: Icon(
            Icons.add,
            size: 32,
            color: AppColors.theme['secondaryColor'],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Column(
              children: [
                duration != null ? FlipClockPlus.reverseCountdown(
                  duration: duration!,
                  digitColor: AppColors.theme["secondaryColor"],
                  backgroundColor: AppColors.theme["primaryColor"],
                  digitSize: 40.0,
                  centerGapSpace: 0.2,
                  width: MediaQuery.of(context).size.width * 0.08,
                  height: 50,
                  borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                  onDone: () {
                    print('onDone');
                  },
                ):Container(),
                StreamBuilder<QuerySnapshot>(
                  stream: EventAPIs.getAllEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents = snapshot.data!.docs;
                      if (documents.isEmpty) {
                        return Center(
                          child: Text("No events"),
                        );
                      } else {
                        List<CSIEvent> csiEvents = documents.map((doc) => CSIEvent.fromJson(doc.data() as Map<String, dynamic>)).toList();
                        csiEvents.sort((a, b) => b.compareTo(a));
                        duration = DateTime.fromMillisecondsSinceEpoch(int.parse(csiEvents.first.startDate ?? "0")).difference(DateTime.now());
                        print("# $duration");
                        if(_isFirst){
                          setState(() {
                          });
                        }
                        return Column(
                          children: [
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: csiEvents.length,
                              itemBuilder: (context, index) {
                                return EventCard(
                                  csiEvent: csiEvents[index],
                                  // parentContext: context,
                                );
                              },
                            ),
                          ],
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error.toString()}");
                    } else {
                      return EventCardShimmerEffect();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
