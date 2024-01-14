import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/board_member.dart';
import '../colors.dart';

class BoardMemberCard extends StatelessWidget {
  final List<BoardMember> bm;
  final String heading;
  const BoardMemberCard({super.key, required this.bm, required this.heading});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mq.width * 0.03,
        vertical: mq.height * 0.01,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  heading,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.theme['secondaryColor'],
              ),
              height: 170,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: bm.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 130,
                    decoration: BoxDecoration(
                        color: AppColors.theme['secondaryColor'],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black12)),
                    margin: EdgeInsets.all(3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 1,
                              child: CircleAvatar(
                                radius: 25,
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.theme['tertiaryColor'],
                                ),
                                backgroundColor:
                                    AppColors.theme['secondaryColor'],
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              bm[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              bm[index].position,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor:
                                      AppColors.theme['secondaryColor'],
                                  useSafeArea: true,
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => _bottomSheet(bm[index]),
                                );
                              },
                              child: Text("View"),
                              style: ElevatedButton.styleFrom(
                                elevation: 0.7,
                                primary: AppColors.theme['secondaryColor'],
                                onPrimary: AppColors.theme['tertiaryColor'],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Set the desired border radius
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomSheet(BoardMember bm) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black12,
          )),
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 70,
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: AppColors.theme['primaryColor'],
                    ),
                    backgroundColor: AppColors.theme['secondaryColor'],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    bm.name,
                    style: TextStyle(
                        color: AppColors.theme['tertiaryColor'],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    bm.position,
                    style: TextStyle(
                        color: AppColors.theme['tertiaryColor'],
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

