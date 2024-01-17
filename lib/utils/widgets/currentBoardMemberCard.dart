import 'package:csi_app/models/board_member.dart';
import 'package:csi_app/utils/fontStyle.dart';
import 'package:flutter/material.dart';
import 'package:csi_app/main.dart';

import '../../constants/board_member_lists.dart';
import '../colors.dart';


class CurrentBoardMemberCard extends StatelessWidget {
  final BoardMember boardMember;
  const CurrentBoardMemberCard({super.key, required this.boardMember});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Container(
      height: mq.height*0.8,
      width: mq.width*0.8,
      decoration: BoxDecoration(
          color: AppColors.theme['secondaryColor'],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.theme["borderColor"])),
      margin: EdgeInsets.all(3),

      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 5.0, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(mq.width*0.1),
                      border: Border.all(color: AppColors.theme["borderColor"])

                    ),
                    child: CircleAvatar(
                      radius: mq.width*0.1,
                      child: Icon(
                        Icons.person,
                        color: AppColors.theme['tertiaryColor'],
                        size: mq.width*0.075,
                      ),

                      backgroundColor: AppColors.theme['secondaryColor'],
                    ),
                  ),
                  SizedBox(
                    width: mq.width*0.05,
                  ),

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: mq.height*0.025,),
                        Text(
                          boardMember.name,
                          textAlign: TextAlign.start,
                          style: AppFontStyles.fs18b0,

                        ),
                        Text(
                          boardMember.position,
                          textAlign: TextAlign.start,
                          style: AppFontStyles.fs12b0,
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),

            Expanded(
              child:Container(
                width: mq.width*0.8,
                // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Skill Stack: ", style: AppFontStyles.fs14b0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(SkillStack.length,
                                  (index) => Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(SkillStack[index], style: AppFontStyles.fs14b0),)),
                        ),
                      ],
                    ),
                  ),
              )
            ),

            Padding(
              padding: const EdgeInsets.all(8.0 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/instagram.png",
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: mq.width*0.03,),
                  Image.asset(
                    "assets/icons/gmail.png",
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: mq.width*0.03,),
                  Image.asset(
                    "assets/icons/github.png",
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: mq.width*0.03,),
                  Image.asset(
                    "assets/icons/linkedin.png",
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
