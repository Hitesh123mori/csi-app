import 'package:csi_app/providers/CurrentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../apis/CompetitiveProgrammingPlatformAPIs/CodeForcesAPIs/GeneralAPIs.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/helper_functions/function.dart';
import '../../utils/shimmer_effects/profile_screen_shimmer_effect.dart';

class CodeforcesView extends StatefulWidget {

  const CodeforcesView({
    super.key,
  });

  @override
  State<CodeforcesView> createState() => _CodeforcesViewState();
}

class _CodeforcesViewState extends State<CodeforcesView> {
  final Map<String, Color> rankColors = {
    'newbie': Color(0xFF808080),
    'pupil': Color(0xFF03A89E),
    'specialist': Color(0xFF3182CE),
    'expert': Color(0xFF7C3AED),
    'candidate master': Color(0xFFE47272),
    'master': Color(0xFFE47272),
    'international master': Color(0xFFE47272),
    'grandmaster': Color(0xFFFF8C00),
    'international grandmaster': Color(0xFFFF8C00),
    'legendary grandmaster': Color(0xFFFF8C00),
  };

  late GlobalKey<SfCircularChartState> _circularChartKey;

  @override
  void initState() {
    super.initState();
    _circularChartKey = GlobalKey<SfCircularChartState>();
  }

  Map<int, int> ratingCount = {};
  int totalCount = 0;


  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<AppUserProvider>(
      builder: (context, appUserProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: AppColors.theme['secondaryColor'],
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  StreamBuilder(
                    stream: CFGeneralAPIs.fetchCodeforcesUserProfile(appUserProvider.user?.cfId ?? ""),
                    builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Center(
                                child: CircularProgressIndicator(
                              color: AppColors.theme['primaryColor'],
                            )),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Container();
                      } else {
                        final userProfile = snapshot.data!;

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.theme['secondaryBgColor'],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        userProfile['handle'],
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: rankColors[userProfile['rank']] ?? AppColors.theme['tertiaryColor'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: mq.width * 1,
                                    decoration: BoxDecoration(
                                      color: AppColors.theme['secondaryColor'],
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            title: Text(
                                              "Rank",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.theme['tertiaryColor'],
                                              ),
                                            ),
                                            leading: Icon(
                                              Icons.trending_up,
                                            ),
                                            subtitle: Text(
                                              '${userProfile['rank']}',
                                              style: TextStyle(
                                                color: AppColors.theme['tertiaryColor'],
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Rating",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.theme['tertiaryColor'],
                                              ),
                                            ),
                                            leading: Icon(
                                              Icons.stars,
                                            ),
                                            subtitle: Text(
                                              '${userProfile['rating']}',
                                              style: TextStyle(
                                                color: AppColors.theme['tertiaryColor'],
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Max Rating',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.theme['tertiaryColor'],
                                              ),
                                            ),
                                            leading: Icon(
                                              Icons.emoji_events,
                                            ),
                                            subtitle: Text(
                                              '${userProfile['maxRating']}',
                                              style: TextStyle(
                                                color: AppColors.theme['tertiaryColor'],
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Max Rank',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.theme['tertiaryColor'],
                                              ),
                                            ),
                                            leading: Icon(Icons.star),
                                            subtitle: Text(
                                              '${userProfile['maxRank']}',
                                              style: TextStyle(
                                                color: AppColors.theme['tertiaryColor'],
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
                          ),
                        );
                      }
                    },
                  ),


                  StreamBuilder(
                      stream: CFGeneralAPIs.getCFSubmissions(appUserProvider.user?.cfId ?? "").asStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.theme['primaryColor'],
                              )),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Container();
                        } else {
                          Map<String, dynamic> cfSubmissions = snapshot.data;

                          totalCount = cfSubmissions["totalCount"] ?? 0;
                          ratingCount = Map<int, int>.from(cfSubmissions["ratingCount"] ?? {});

                          return ratingCount.isNotEmpty && totalCount != 0
                              ? _buildCircularChart()
                              :SizedBox();

                        }
                      }),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileInfo(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(width: 10),
        Text(
          '$label:',
          style: TextStyle(fontSize: 18, color: color),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            softWrap: true,
            style: TextStyle(fontSize: 18, color: color),
          ),
        ),
      ],
    );
  }

  Padding _buildCircularChart() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 700,
        child: SfCircularChart(
          backgroundColor: AppColors.theme['secondaryColor'],
          key: _circularChartKey,
          legend: const Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap,
            iconBorderWidth: 1,
            iconBorderColor: Colors.black,
          ),
          title: ChartTitle(text: 'Rating Distribution'),
          series: <CircularSeries>[
            DoughnutSeries<MapEntry<int, int>, int>(
              dataSource: ratingCount.entries.toList(),
              xValueMapper: (entry, _) => entry.key,
              yValueMapper: (entry, _) => entry.value,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}
