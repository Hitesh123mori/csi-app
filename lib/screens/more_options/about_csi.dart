import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart' ;


class AboutCSI extends StatefulWidget {
  const AboutCSI({super.key});

  @override
  State<AboutCSI> createState() => _AboutCSIState();
}

class _AboutCSIState extends State<AboutCSI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          elevation: 0.3,
          shadowColor: AppColors.theme['primaryColor'],
          backgroundColor: AppColors.theme['secondaryColor'],
          centerTitle: true,leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon : Icon(Icons.keyboard_arrow_left_sharp,size: 32,),

        ),

          title: Text("About Us",style: TextStyle(color:AppColors.theme['tertiaryColor'],fontWeight: FontWeight.bold,fontSize: 18),),
        ),
        body: Center(
           child: Text("About Csi"),
        ),
      ),
    );
  }
}
