import 'package:flutter/material.dart';
import 'package:tickit/ui/common/layout/default_layout.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text("티켓"),
      ),
    );
  }
}
