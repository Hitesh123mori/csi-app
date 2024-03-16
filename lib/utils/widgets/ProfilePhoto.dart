import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../apis/googleAIPs/drive/DriveApi.dart';
import '../colors.dart';
import '../helper_functions/function.dart';

class ProfilePhoto extends StatefulWidget {
  String? url;
  String? name;
  double? radius;

  ProfilePhoto({super.key, required this.url, required this.name, this.radius});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(75),
      child: CircleAvatar(
        radius: widget.radius ?? 50,
        backgroundColor: AppColors.theme['secondaryBgColor'],
        child: StreamBuilder<Uint8List>(
          stream: DriveAPI.fetchImage(widget.url).asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // HelperFunctions.showToast(snapshot.error.toString());
              return _showInitials();
            } else if (snapshot.hasData) {
              Uint8List? img = snapshot.data;
              if (img == null) {
                return _showInitials();
              } else {
                return Row(
                  children: [
                    Expanded(
                        child: Image.memory(
                      img,
                      fit: BoxFit.cover,
                    )),
                  ],
                );
              }
            }
            return _showInitials();
          },
        ),
      ),
    );
  }

  Text _showInitials(){
    return Text(HelperFunctions.getInitials(widget.name ?? "A B"), style: TextStyle(fontSize: (widget.radius??50)/2),);
  }
}
