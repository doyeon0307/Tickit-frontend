import 'package:flutter/material.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text("설정"),
      ),
    );
  }
}
