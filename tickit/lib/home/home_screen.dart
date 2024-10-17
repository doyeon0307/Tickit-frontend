import 'package:flutter/material.dart';
import 'package:tickit/common/layout/default_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text(
          "홈",
          style: TextStyle(
            fontSize: 60.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
