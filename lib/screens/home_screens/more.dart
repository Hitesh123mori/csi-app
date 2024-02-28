import 'package:flutter/material.dart';
import '../../helper_functions/function.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/more_menu_card/more_menu_item.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: mq.width * 0.05, top: 20, bottom: 10),
            child: Text(
              "More",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: AppColors.theme['primaryColor']),
            ),
          ),
          Moremenuitems(
            text: 'Blogs',
            onTap: () {
              Functions.launchURL('https://csi-nirma.vercel.app');
            },
            icon: Icon(
              Icons.post_add_sharp,
              size: 25,
              color: AppColors.theme['primaryColor'],
            ),
          ),
          Moremenuitems(
            text: 'Board Members',
            onTap: () {
              Functions.launchURL('https://csi-nirma.vercel.app/board');
            },
            icon: Icon(
              Icons.group,
              size: 25,
              color: AppColors.theme['primaryColor'],
            ),
          ),
          Moremenuitems(
            text: 'Past Events and sessions',
            onTap: () {
              Functions.launchURL('https://csi-nirma.vercel.app/');
            },
            icon: Icon(
              Icons.event_note_sharp,
              size: 25,
              color: AppColors.theme['primaryColor'],
            ),
          ),
          Moremenuitems(
            text: 'Contributers',
            onTap: () {
              Functions.launchURL('https://csi-nirma.vercel.app/board');
            },
            icon: Icon(
              Icons.people_rounded,
              size: 25,
              color: AppColors.theme['primaryColor'],
            ),
          ),
        ],
      ),
    );
  }
}
