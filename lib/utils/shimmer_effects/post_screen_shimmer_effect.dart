import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../colors.dart';

class PostShimmerEffect extends StatelessWidget {
  const PostShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: 1,
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
              child: SingleChildScrollView(
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
                          leading: SizedBox(
                            width: 40, // Adjust this width as needed
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade200,
                              child: CircleAvatar(
                                backgroundColor: AppColors.theme['secondaryColor'],
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.theme['backgroundColor'],
                                ),
                                height: 20,
                                width: mq.width*0.7,
                              )
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
                                  width: mq.width*0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.theme['backgroundColor'],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade200,
                                child: Container(
                                  height: 10,
                                  width: mq.width*0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.theme['backgroundColor'],
                                  ),
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
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.theme['secondaryColor'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
