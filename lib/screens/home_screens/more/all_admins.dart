import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/widgets/user_cards/admin_card.dart';


class AllAdmins extends StatefulWidget {
  const AllAdmins({super.key});

  @override
  State<AllAdmins> createState() => _AllAdminsState();
}

class _AllAdminsState extends State<AllAdmins> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        appBar: AppBar(
          surfaceTintColor: AppColors.theme['secondaryColor'],
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.theme['secondaryColor'],
          title: Text("Admins",
              style: TextStyle(
                  color: AppColors.theme['tertiaryColor'],
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.keyboard_arrow_left_outlined,
                size: 32,
              )),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.theme['secondaryColor'],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    cursorColor: AppColors.theme['tertiaryColor'],
                    autocorrect: true,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search admins",
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),AdminCard(),
                      AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),AdminCard(),
                      AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),AdminCard(),
                      AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),AdminCard(),
                      AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),AdminCard(),
                      AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),AdminCard(),
                      AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),     AdminCard(),AdminCard(),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
