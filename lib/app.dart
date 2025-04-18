import 'package:flutter/material.dart';
import '/app_state/change_notifier.dart';
import '/app_state/inherited_data.dart';
import 'package:snake_game/screen/splash_screen.dart';
import '/screen/home.dart';

class SnakeApp extends StatelessWidget {
  const SnakeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return InheritedData(
      appController: AppController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: SplashScreen(),
        routes: {
          Home.id: (context)=>Home()
        },
      ),
    );
  }
}
