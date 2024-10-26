import 'package:flutter/material.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text("캘린더"),
      ),
    );
  }
}
