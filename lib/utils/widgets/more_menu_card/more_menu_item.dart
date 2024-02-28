import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class Moremenuitems extends StatelessWidget {
  final String text ;
  final VoidCallback onTap;
  final Icon icon ;
  const Moremenuitems({super.key, required this.text, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: mq.width*0.04),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          surfaceTintColor: AppColors.theme['secondaryColor'],
          color: AppColors.theme['secondaryColor'],
          child: ListTile(
            leading: icon,
             trailing: Icon(Icons.keyboard_arrow_right,size: 25,color:AppColors.theme['primaryColor'] ,),
              title: Text(text,style: TextStyle(color : AppColors.theme['tertiaryColor'],),),
          ),
        ),
      ),
    );
  }
}
