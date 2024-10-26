import 'package:flutter/material.dart';
import 'package:tickit/ui/common/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tickit',
      theme: ThemeData(
        fontFamily: "Pretendard",
      ),
      home: const SplashScreen(),
    );
  }
}
