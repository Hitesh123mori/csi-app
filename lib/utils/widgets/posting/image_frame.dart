import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../main.dart';
import '../../../models/post_model/image_model.dart';
import '../../colors.dart';
class ImageFrame extends StatefulWidget {
  ImageModel imageModel;
  dynamic provider;
  ImageFrame({super.key, required this.imageModel, required this.provider});

  @override
  State<ImageFrame> createState() => _ImageFrameState();
}

class _ImageFrameState extends State<ImageFrame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      color: AppColors.theme['secondaryColor'],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(widget.provider != null) IconButton(
              onPressed: () async {
                widget.imageModel.delete();
                setState(() {
                  Fluttertoast.showToast(
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 5,
                    msg: "Image Deleted",
                    webShowClose: true,
                    webBgColor: "#14181a",
                    backgroundColor: Colors.black,
                    gravity: ToastGravity.BOTTOM_RIGHT,
                  );
                });
                widget.provider.notify();
              },
              icon: Icon(Icons.close_rounded)
            )
            else Container(),
        
            Container(
              child: StreamBuilder<String>(
                stream: widget.imageModel.uri?.asStream(),
                builder: (context, snap) {
                  if (snap.hasData){
                    return Image.network(
                      snap.data.toString(),
                      fit: BoxFit.scaleDown,
                      loadingBuilder:
                          (context, child, loadingProcess) {
                        if (loadingProcess == null) {
                          return child;
                        } else {
                          return  Container(
                              child: Center(child: CircularProgressIndicator(color: AppColors.theme['highlightColor'],)));
                        }
                      },
                    );
                  }
        
                  else if(snap.hasError){
                    return const Text("Error", style: TextStyle(color: Colors.white));
                  }
        
                  else return const CircularProgressIndicator();
                }
              ),
            )
        
          ],
        ),
      ),
    );
  }
}
