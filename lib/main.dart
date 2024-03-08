import 'package:csi_app/providers/CurrentUser.dart';
import 'package:csi_app/providers/bottom_navigation_provider.dart';
import 'package:csi_app/providers/post_provider.dart';
import 'package:csi_app/screens/home_screens/home_screen.dart';
import 'package:csi_app/screens/on_boading_screens/splash_screen.dart';
import 'package:csi_app/utils/colors.dart';
import 'package:flutter/material.dart' ;
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late Size mq ;
bool isKeyboardOpen = false ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AppUserProvider()),
        ChangeNotifierProvider(create: (context)=>BottomNavigationProvider()),
        ChangeNotifierProvider(create: (context)=>PostProvider()) ,
      ],
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: AppColors.theme['primaryColor'],
              selectionColor: AppColors.theme['primaryColor'].withOpacity(0.2),
              selectionHandleColor: AppColors.theme['secondaryBgColor'].withOpacity(0.2),
            )
        ),
        // home: SplashScreen()
        home: HomeScreen(),
    );
  }
}
