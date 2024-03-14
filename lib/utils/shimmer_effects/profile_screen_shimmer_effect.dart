import 'package:flutter/material.dart' ;
import 'package:shimmer/shimmer.dart';

import '../../main.dart';
import '../colors.dart';


class ProfileScreenShimmerEffect extends StatefulWidget {
  const ProfileScreenShimmerEffect({super.key});

  @override
  State<ProfileScreenShimmerEffect> createState() => _ProfileScreenShimmerEffectState();
}

class _ProfileScreenShimmerEffectState extends State<ProfileScreenShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: mq.height,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.theme['backgroundColor'],
                  borderRadius: BorderRadius.circular(4),
                ),
                width: mq.width,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30,),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade200,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.theme['secondaryColor'],
                            ),
                          ),
                        ),
                        SizedBox(
                          height :5
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade200,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.theme['secondaryColor'],
                            ),
                          ),
                        ),
                        SizedBox(
                            height :5
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade200,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.theme['secondaryColor'],
                            ),
                          ),
                        ),
                        SizedBox(
                            height :5
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade200,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.theme['secondaryColor'],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
