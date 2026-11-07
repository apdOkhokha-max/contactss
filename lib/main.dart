import 'package:contact/App_screens/Home_screen.dart';
import 'package:contact/App_screens/Name_screens.dart';
import 'package:contact/App_screens/Splash_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: NameScreens.splash,
      routes: {
        NameScreens.splash: (context) => SplashScreen(),
        NameScreens.Home: (context) => HomeScreen(),

      },
    );
  }
}
