import 'package:csi_app/constants/board_member_lists.dart';
import 'package:csi_app/side_transition_effects/right_left.dart';
import 'package:csi_app/utils/widgets/board_member_card.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/board_member.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/current_board_member.dart';

class BoardMemberCSI extends StatefulWidget {
  const BoardMemberCSI({Key? key}) : super(key: key);

  @override
  State<BoardMemberCSI> createState() => _BoardMemberCSIState();
}

class _BoardMemberCSIState extends State<BoardMemberCSI> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          elevation: 0,
          backgroundColor: AppColors.theme['secondaryColor'],
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon : Icon(Icons.keyboard_arrow_left_sharp,size: 32,),

          ),
          title: Text(
            "Board Members",
            style: TextStyle(
                color: AppColors.theme['tertiaryColor'],
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        backgroundColor: AppColors.theme['secondaryColor'],
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.width * 0.002, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Board',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, RightToLeft(PastBM()));
                          },
                          child: Text("See Past Board",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.theme['primaryColor']))
                      ),
                    ],
                  ),
                ),
                CurrentBoardMembersRow(bmList: bm2023.sublist(0, 3)),
                CurrentBoardMembersRow(bmList: bm2023.sublist(3, 6)),
                CurrentBoardMembersRow(bmList: bm2023.sublist(6, 9)),
                CurrentBoardMembersRow(bmList: bm2023.sublist(9, 12)),
                CurrentBoardMembersRow(bmList: bm2023.sublist(12, 15)),
                CurrentBoardMembersRow(bmList: bm2023.sublist(15, 18)),
                CurrentBoardMembersRow(bmList: bm2023.sublist(18, 20)),
              ],
            ),
          ),
        ),
      );
  }
}

class CurrentBoardMembersRow extends StatefulWidget {
  final List<BoardMember> bmList;

  const CurrentBoardMembersRow({Key? key, required this.bmList})
      : super(key: key);

  @override
  State<CurrentBoardMembersRow> createState() => _CurrentBoardMembersRowState();
}

class _CurrentBoardMembersRowState extends State<CurrentBoardMembersRow> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.bmList.map((bm) => CurrentBoardMemberCard(bm: bm)).toList(),
      ),
    );
  }
}
class PastBM extends StatefulWidget {
  const PastBM({super.key});

  @override
  State<PastBM> createState() => _PastBMState();
}

class _PastBMState extends State<PastBM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.theme['secondaryColor'] ,
      appBar: AppBar(
        surfaceTintColor:  AppColors.theme['secondaryColor'],
        backgroundColor: AppColors.theme['secondaryColor'],
        title: Text("Past Board Members",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context) ;
          },
          icon: Icon(Icons.keyboard_arrow_left_outlined,size: 32,),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              BoardMemberCard(bm: bm2023, heading: "Board Members (2022)"),
              BoardMemberCard(bm: bm2023, heading: "Board Members (2021)"),
              BoardMemberCard(bm: bm2023, heading: "Board Members (2020)"),
            ],
        ),
      ),
    );
  }
}


