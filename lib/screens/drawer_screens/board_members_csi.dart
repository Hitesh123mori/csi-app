import 'package:csi_app/constants/board_member_lists.dart';
import 'package:csi_app/screens/providers/drawer_option_provider.dart';
import 'package:csi_app/utils/widgets/board_member_card.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../utils/colors.dart';

class BoardMemberCSI extends StatefulWidget {
  final DrawerOptionProvider drawerOp;
  const BoardMemberCSI({Key? key, required this.drawerOp}) : super(key: key);

  @override
  State<BoardMemberCSI> createState() => _BoardMemberCSIState();
}

class _BoardMemberCSIState extends State<BoardMemberCSI> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['secondaryColor'],
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              BoardMemberCard(bm: bm2023, heading: "Current Board Members"),
              BoardMemberCard(bm: bm2023, heading: "Board Members(2022)"),
              BoardMemberCard(bm: bm2023, heading: "Board Members(2021)"),
              BoardMemberCard(bm: bm2023, heading: "Board Members(2020)"),
            ],
          ),
        ),
      ),
    );
  }

}
