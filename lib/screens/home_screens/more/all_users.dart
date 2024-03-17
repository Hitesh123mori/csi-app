import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csi_app/models/user_model/AppUser.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/utils/shimmer_effects/users_card_shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/keep/v1.dart';
import 'package:provider/provider.dart';

import '../../../apis/FireStoreAPIs/UserProfileAPI.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/widgets/user_cards/user_card.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
     mq = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(builder: (context,appUserProvider,child){return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        appBar: AppBar(
          surfaceTintColor: AppColors.theme['secondaryColor'],
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.theme['secondaryColor'],
          title: Text("Users",
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
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
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
                      hintText: "Search users",
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
              child: StreamBuilder<QuerySnapshot>(
                stream: UserProfile.getAllAppUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    if (documents.isEmpty) {
                      return Center(
                        child: Text("No Users"),
                      );
                    } else {
                      List<AppUser> users = documents
                          .map((doc) => AppUser.fromJson(doc.data() as Map<String, dynamic>))
                          .toList();
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          if(users[index].userID == appUserProvider.user?.userID ) return Container();
                          return UserCard(
                            appUser: users[index],
                            currentUser: appUserProvider.user!,
                          );
                        },
                      );
                    }
                  } else if (snapshot.hasError) {
                    log("#error-postScreen: ${snapshot.error.toString()}");
                    return Text("${snapshot.error.toString()}");
                  } else {
                    return UsersCardShimmerEffect();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );}) ;
  }
}

