import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomPollTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? initialText;

  const CustomPollTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.initialText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: TextFormField(
          cursorColor: AppColors.theme['primaryColor'],
          initialValue: initialText,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.theme['primaryColor']),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.theme['primaryColor']),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.theme['primaryColor']!),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: AppColors.theme['tertiaryColor']!.withOpacity(0.5)),
              prefixIconColor: AppColors.theme['tertiaryColor'],
              suffixIconColor:AppColors.theme['tertiaryColor']
          ),
        ),
      ),
    );
  }
}
