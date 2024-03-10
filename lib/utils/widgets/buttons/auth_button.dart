import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

class AuthButton extends StatelessWidget {
  final Future<void> Function()? onpressed;
  final String name;
  final Color bcolor;
  final Color tcolor;
  final bool isLoading;

  AuthButton({
    Key? key,
    required this.onpressed,
    required this.name,
    required this.bcolor,
    required this.tcolor,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return InkWell(
      onTap: onpressed,
      child: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut, // Animation curve
          height: 50,
          width: isLoading ? mq.width * 0.5 : mq.width * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: bcolor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                Container(
                  height: 25,
                  width: 25,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.theme['secondaryColor'],
                    ),
                  ),
                ),
              SizedBox(width: isLoading ? 10 : 0),
              Center(
                child: Text(
                  name,
                  style: TextStyle(
                    color: tcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
