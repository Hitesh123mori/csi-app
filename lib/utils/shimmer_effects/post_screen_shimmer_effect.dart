import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../main.dart';
import '../colors.dart';

class PostShimmerEffect extends StatelessWidget {
  const PostShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SizedBox(
      height: mq.height,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: AppColors.theme['backgroundColor'],
                borderRadius: BorderRadius.circular(4),
              ),
              width: mq.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    surfaceTintColor: Colors.transparent,
                    color: Colors.transparent,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 1),
                        leading: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade200,
                          child: CircleAvatar(
                            backgroundColor: AppColors.theme['secondaryColor'],
                          ),
                        ),
                        title: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade200,
                          child: Container(
                            height: 20,
                            width: double.infinity,
                            color: AppColors.theme['backgroundColor'],
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                height: 10,
                                width: double.infinity,
                                color: AppColors.theme['backgroundColor'],
                              ),
                            ),
                            SizedBox(height: 5),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                height: 10,
                                width: 150,
                                color: AppColors.theme['backgroundColor'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.theme['secondaryColor'],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

