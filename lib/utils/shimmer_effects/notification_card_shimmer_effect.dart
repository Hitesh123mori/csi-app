import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:csi_app/utils/colors.dart';

class NotificationCardShimmerEffect extends StatelessWidget {
  const NotificationCardShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        body: SizedBox(
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  height: 100,
                  color: AppColors.theme['secondaryColor'],
                  child: ListTile(
                    title: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade200,
                      child: Container(
                        height: 20,
                        width: mq.width * 0.6,
                        decoration: BoxDecoration(
                          color: AppColors.theme['backgroundColor'],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    subtitle: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade200,
                      child: Padding(
                        padding:  EdgeInsets.only(right: mq.width * 0.7),
                        child: Container(
                          height: 15,
                          width: mq.width * 0.4,
                          decoration: BoxDecoration(
                            color: AppColors.theme['backgroundColor'],
                            borderRadius: BorderRadius.circular(20),
                          ),

                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
