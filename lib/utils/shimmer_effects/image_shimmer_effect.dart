import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../colors.dart';

class ImageShimmerEffect extends StatelessWidget {
  const ImageShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SizedBox(
      height: 500,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade200,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.theme['secondaryColor'],
          ),
        ),
      ),
    );
  }
}
