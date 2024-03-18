import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../apis/googleAIPs/drive/DriveApi.dart';
import '../colors.dart';
import '../helper_functions/function.dart';

class ProfilePhoto extends StatefulWidget {
  String? url;
  String? name;
  double? radius;
  bool isHomeScreen = false ;

  ProfilePhoto({super.key, required this.url, required this.name, this.radius,required this.isHomeScreen});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      radius: widget.radius ?? 40,
      backgroundColor: AppColors.theme['secondaryBgColor'],
      child: StreamBuilder<Uint8List>(
        stream: DriveAPI.fetchImage(widget.url).asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _showInitials();
          } else if (snapshot.hasData) {
            Uint8List? img = snapshot.data;
            if (img == null) {
              return _showInitials();
            } else {
              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.isHomeScreen ? 25 :75),
                child: Image.memory(
                  img,
                  fit: BoxFit.cover,
                  height: widget.isHomeScreen ? 50 : 150 ,
                  width: widget.isHomeScreen ?  50 : 150 ,
                ),
              );
            }
          }
          return _showInitials();
        },
      ),
    );
  }

  Text _showInitials(){
    return Text(widget.name![0], style: TextStyle(fontSize:widget.isHomeScreen ? 22 : 50),);
  }
}
