import 'package:csi_app/screens/home_screens/home_screen.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart' ;

import '../../../main.dart';
import '../../../side_transition_effects/TopToBottom.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  TextEditingController _descriptionController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;


  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          _descriptionController.text.isNotEmpty && _descriptionController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _descriptionController.removeListener(updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Form(
      key:_formKey,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.theme['backgroundColor'],
          appBar: AppBar(
            title: Text("Create Post",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            backgroundColor: AppColors.theme['secondaryColor'],
            leading: IconButton(
              onPressed: (){
                Navigator.push(context, TopToBottom(HomeScreen()));
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined,size: 32,),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 40,
                  width: 100,
                  child: Center(child: Text("Post")),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],

          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Start writing your description here',
                    ),
                  ),
                ),
              ),
              Container(
                height:60,
                color: Colors.red,
                width: mq.width*1,
              )
            ],
          ),

        ),
      ),
    );
  }
}
