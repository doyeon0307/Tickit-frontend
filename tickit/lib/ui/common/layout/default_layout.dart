import 'package:flutter/material.dart';
import 'package:tickit/ui/common/const/app_colors.dart';

class DefaultLayout extends StatelessWidget {
  final AppBar? appBar;
  final Widget child;

  const DefaultLayout({
    super.key,
    required this.child,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: child,
        ),
      ),
    );
  }
}
