import 'package:csi_app/apis/FirebaseDatabaseAPIs/PostAPI.dart';
import 'package:csi_app/models/post_model/post.dart';
import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/screens/home_screens/home_screen.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:csi_app/side_transition_effects/TopToBottom.dart';

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
        if (postProvider.post?.comment != null) postProvider.post?.comment?.sort((a, b) => b.compareTo(a));

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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.theme['tertiaryColor']),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: Column(
                      children: [
                        (postProvider.post?.comment?.isEmpty ?? true)
                            ? Center(
                                child: Text(
                                  'No comments yet',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Expanded(child: SingleChildScrollView(
                              child: Column(
                                                        children: List.generate(postProvider.post?.comment?.length ?? 0, (index) {
                              return CommentCard(postComment: postProvider.post!.comment![index], postCreatorId: postProvider.post?.createBy??"", postId: postProvider.post?.postId ?? "");
                                                        }
                                                        ).toList(),
                                                      ),
                            )),
                        buildChatInput(appUserProvider.user!, postProvider.post!),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }

  // custom input text filed

  Widget buildChatInput(AppUser user, Post post) {
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
                      constraints: BoxConstraints(maxHeight: _textFieldMaxHeight),
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: _textController,
                          focusNode: _messageFocusNode,
                          onChanged: (text) {
                            setState(() {
                              _isMessageTextFieldFocused = _messageFocusNode.hasFocus;
                            });
                          },
                          onTap: () {
                            setState(() {
                              _isMessageTextFieldFocused = _messageFocusNode.hasFocus;
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
            onPressed: () async {
              PostComment pc = PostComment(
                message: _textController.text,
                userId: user.userID,
                createdTime: DateTime.now().millisecondsSinceEpoch.toString(),
              );

              final res = await PostAPI.addComment(post.postId, pc);

              if (res.containsKey("success")) {
                if (post.comment == null) post.comment = [];
                post.comment?.add(pc);
              }
              setState(() {});

              _textController.text = "";
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
