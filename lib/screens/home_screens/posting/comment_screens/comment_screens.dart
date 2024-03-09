import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/screens/home_screens/home_screen.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:csi_app/utils/widgets/posting/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:csi_app/side_transition_effects/TopToBottom.dart';
import 'package:csi_app/screens/home_screens/posting/posts_screen.dart';

import '../../../../main.dart';
import '../../../../models/user_model/AppUser.dart';
import '../../../../utils/widgets/posting/comment_card.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  // input field
  double _textFieldMaxHeight = 130.0;
  FocusNode _messageFocusNode = FocusNode();
  bool _isMessageTextFieldFocused = false;
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer2<PostProvider, AppUserProvider>(
      builder: (context, postProvider, appUserProvider, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                backgroundColor: AppColors.theme['backgroundColor'],
                appBar: AppBar(
                  surfaceTintColor: AppColors.theme['secondaryColor'],
                  title: Text(
                    "Comments",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.theme['tertiaryColor']),
                  ),
                  backgroundColor: AppColors.theme['secondaryColor'],
                  leading: IconButton(
                    onPressed: () {
                      Navigator.push(context, TopToBottom(HomeScreen()));
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left_outlined,
                      size: 32,
                    ),
                  ),
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                              itemCount: postProvider.post?.comment!.length,
                              itemBuilder: (BuildContext context, int index) {
                            return CommentCard(cmnt: postProvider.post!.comment![index],);
                          }),
                        ),
                        buildChatInput(appUserProvider.user!),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }

  // custom input text feild

  Widget buildChatInput(AppUser user) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mq.width * 0.01,
        vertical: mq.height * 0.01,
      ),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: AppColors.theme['secondaryBgColor'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: mq.width * 0.03),
                  Expanded(
                    child: Container(
                      constraints:
                          BoxConstraints(maxHeight: _textFieldMaxHeight),
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: _textController,
                          focusNode: _messageFocusNode,
                          onChanged: (text) {
                            setState(() {
                              _isMessageTextFieldFocused =
                                  _messageFocusNode.hasFocus;
                            });
                          },
                          onTap: () {
                            setState(() {
                              _isMessageTextFieldFocused =
                                  _messageFocusNode.hasFocus;
                            });
                          },
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          cursorColor: AppColors.theme['primaryColor'],
                          style: TextStyle(
                            color: AppColors.theme['tertiaryColor'],
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type Comment...",
                            hintStyle: TextStyle(
                                // color: AppColors.theme['fontColor'],
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: mq.width * 0.03),
                ],
              ),
            ),
          ),
          MaterialButton(
            minWidth: 0,
            shape: CircleBorder(),
            onPressed: () {
              //todo: send button
            },
            color: AppColors.theme['primaryColor'],
            child: Center(
                child: Icon(
              Icons.send,
              color: AppColors.theme['secondaryColor'],
            )),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }
}
