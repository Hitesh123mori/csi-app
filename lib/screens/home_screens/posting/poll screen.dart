import 'package:csi_app/models/post_model/post.dart';
import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/screens/home_screens/posting/add_post_screen.dart';
import 'package:csi_app/side_transition_effects/left_right.dart';
import 'package:csi_app/utils/widgets/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../side_transition_effects/TopToBottom.dart';
import '../../../utils/colors.dart';
import '../../../utils/widgets/posting/poll_text_field.dart';

class PollScreen extends StatefulWidget {
  const PollScreen({super.key});

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  //for poll
  List<TextEditingController> _optionControllers = [];
  TextEditingController _questionController = TextEditingController();

  bool ispollButtonEnabled = false;


  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  

  @override
  void initState() {
    super.initState();
    _questionController.addListener(updateButtonState);

    // Adding two default option controllers
    _optionControllers.add(TextEditingController());
    _optionControllers.add(TextEditingController());

    for (int i = 0; i < _optionControllers.length; i++) {
      _optionControllers[i].addListener(updateButtonState);
    }
  }


  void updateButtonState() {
    setState(() {
      ispollButtonEnabled =
          _questionController.text.isNotEmpty && _optionControllers.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _questionController.removeListener(updateButtonState);
    for (int i = 0; i < _optionControllers.length; i++) {
      _optionControllers[i].addListener(updateButtonState);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child){
        return Form(
          key: _formKey,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: AppColors.theme['backgroundColor'],
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(context, TopToBottom(AddPostScreen()));
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left_outlined,
                    size: 32,
                  ),
                ),
                title: Text(
                  "Create Poll",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.theme['secondaryColor'],
                surfaceTintColor: AppColors.theme['secondaryColor'],
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: ispollButtonEnabled ? () {
                        if(_formKey.currentState!.validate()){

                          //todo : here add poll logic

                          postProvider.post?.poll = Poll();
                          postProvider.post?.poll?.question = _questionController.text;
                          postProvider.post?.poll?.options = [];

                          print('Question: ${_questionController.text}');
                          for (int i = 0; i < _optionControllers.length; i++) {
                            postProvider.post?.poll?.options?.add(Options(title: _optionControllers[i].text));
                            print('Option ${i + 1}: ${_optionControllers[i].text}');
                          }

                          Navigator.pushReplacement(context, LeftToRight(AddPostScreen()));

                        }
                      } : (){},
                      child: Container(
                        height: 40,
                        width: 100,
                        child: Center(
                            child: Text(
                              "Create",
                              style: TextStyle(
                                color: ispollButtonEnabled
                                    ? AppColors.theme['secondaryColor']
                                    : AppColors.theme['tertiaryColor'].withOpacity(0.5),
                              ),
                            )),
                        decoration: BoxDecoration(
                          color: ispollButtonEnabled
                              ? AppColors.theme['primaryColor']
                              : AppColors.theme['disableButtonColor'],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Question",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme['tertiaryColor']),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomPollTextField(
                      controller: _questionController,
                      hintText: 'Enter question here',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Options",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme['tertiaryColor']),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    for (int i = 0; i < _optionControllers.length; i++)
                      Row(
                        children: [
                          Expanded(
                            child: CustomPollTextField(
                              controller: _optionControllers[i],
                              hintText: 'Option ${i + 1}',
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                _optionControllers.removeAt(i);
                              });
                            },
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    PrimaryButton(
                      onpressed: () {
                        setState(() {
                          _optionControllers.add(TextEditingController());
                        });
                      },
                      name: 'Add Option',
                      bcolor: AppColors.theme['primaryColor'],
                      tcolor:AppColors.theme['secondaryColor'],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
