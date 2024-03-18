import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csi_app/models/event_model/event_model.dart';
import 'package:csi_app/screens/home_screens/event_screens/add_event_screen.dart';
import 'package:csi_app/side_transition_effects/bottom_top.dart';
import 'package:csi_app/utils/shimmer_effects/event_card_shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../apis/FireStoreAPIs/event_store.dart';
import '../../../main.dart';
import '../../../providers/CurrentUser.dart';
import '../../../utils/colors.dart';
import '../../../utils/widgets/event/event_card.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  @override
  Widget build(BuildContext context) {
    mq  = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(builder: (context,appUserProvider,child){return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        floatingActionButton:
        (appUserProvider.user?.isAdmin ?? false) || (appUserProvider.user?.isSuperuser ?? false) ? FloatingActionButton(
          backgroundColor: AppColors.theme['primaryColor'],
          onPressed: () {
            Navigator.push(context, BottomToTop(AddEventScreen()));
          },
          child: Icon(
            Icons.add,
            size: 32,
            color: AppColors.theme['secondaryColor'],
          ),
        ) :null ,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: EventStore.getAllEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      if (documents.isEmpty) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/no_item.png",
                                height: 200,
                                width: 200,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: mq.width * 0.2),
                                child: Text(
                                  "No Items",
                                  style: TextStyle(
                                      color: AppColors.theme['tertiaryColor'].withOpacity(0.5),
                                      fontSize: 25),
                                ),
                              ),
                            ]);
                      } else {
                        List<CSIEvent> csiEvents = documents
                            .map((doc) => CSIEvent.fromJson(
                            doc.data() as Map<String, dynamic>))
                            .toList();
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: csiEvents.length,
                          itemBuilder: (context, index) {
                            return EventCard(
                              csiEvent: csiEvents[index],
                            );

                          },
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
    );} );
  }
}
