import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../colors.dart';

class EventCardShimmerEffect extends StatelessWidget {
  const EventCardShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SizedBox(
      height: mq.height,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: Container(
              height: 155,
              decoration: BoxDecoration(
                color: AppColors.theme['secondaryColor'],
                borderRadius: BorderRadius.circular(4),
              ),
              width: mq.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5).copyWith(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                        color: AppColors.theme['secondaryColor'],
                      ),
                    ),
                  ),

                  Padding(
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
                      trailing: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade200,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: 35,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.theme['backgroundColor'],
                              ),
                            ),
                          ),),
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
                              height: 17,
                              width: mq.width*0.5,
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
                              width: mq.width*0.25,
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
                              width: mq.width*0.25,
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
