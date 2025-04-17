import 'package:flutter/material.dart';
import 'package:snake_game/screen/splash_screen.dart';
import '/screen/home.dart';

class SnakeApp extends StatelessWidget {
  const SnakeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SplashScreen(),
      routes: {
        Home.id: (context)=>Home()
      },
    );
  }
}
