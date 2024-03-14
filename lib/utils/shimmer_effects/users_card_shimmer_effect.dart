import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:csi_app/utils/colors.dart';

class UsersCardShimmerEffect extends StatelessWidget {
  const UsersCardShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size; // Move this line inside the build method
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        body: SizedBox(
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              return ListTile(
                isThreeLine: true,
                leading: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                  child: CircleAvatar(
                    backgroundColor: AppColors.theme['secondaryColor'],
                    radius: 20, // Adjust the radius as needed
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                  child: Container(
                    height: 10,
                    width: mq.width * 0.9,
                    color: AppColors.theme['backgroundColor'],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          height: 10,
                          width: mq.width * 0.6,
                          color: AppColors.theme['backgroundColor'],
                        ),
                      ),
                      SizedBox(height: 3),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                        child: Container(
                          height: 10,
                          width: mq.width * 0.3,
                          color: AppColors.theme['backgroundColor'],
                        ),
                      ),
                    ],
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
