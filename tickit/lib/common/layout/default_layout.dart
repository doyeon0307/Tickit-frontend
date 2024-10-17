import 'package:flutter/material.dart';
import 'package:tickit/common/const/app_colors.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;

  const DefaultLayout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: body,
        ),
      ),
    );
  }
}
