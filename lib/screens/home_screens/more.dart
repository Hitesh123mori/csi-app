import 'package:csi_app/side_transition_effects/right_left.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/widgets/more_menu_item.dart';
import '../more_options/about_csi.dart';
import '../more_options/blogs_csi.dart';
import '../more_options/board_members_csi.dart';
import '../more_options/past_events.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: mq.width * 0.04, top: 20, bottom: 10),
          child: Text(
            "More",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Moremenuitems(
          text: 'Blogs',
          onTap: () {
            Navigator.push(context, RightToLeft(BlogsCSI()));
          },
          icon: Icon(
            Icons.post_add_sharp,
            size: 25,
          ),
        ),
        Moremenuitems(
          text: 'Board Members',
          onTap: () {
            Navigator.push(context, RightToLeft(BoardMemberCSI()));
          },
          icon: Icon(
            Icons.group,
            size: 25,
          ),
        ),
        Moremenuitems(
          text: 'Past Events and sessions',
          onTap: () {
            Navigator.push(context, RightToLeft(PastEvent()));
          },
          icon: Icon(
            Icons.event_note_sharp,
            size: 25,
          ),
        ),
        Moremenuitems(
          text: 'About Us',
          onTap: () {
            Navigator.push(context, RightToLeft(AboutCSI()));
          },
          icon: Icon(
            Icons.info_outline_rounded,
            size: 25,
          ),
        ),
      ],
    );
  }
}
