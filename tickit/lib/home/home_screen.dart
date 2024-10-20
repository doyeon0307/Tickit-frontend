import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tickit/common/const/app_colors.dart';
import 'package:tickit/common/layout/default_layout.dart';
import 'package:tickit/home/model/ticket_preview.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: VerticalCardPager(
          titles: titles,
          images: images
              .map(
                (e) => Hero(
                  tag: e.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      e.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

List<TicketPreview> images = [
  const TicketPreview(id: 1, image: "assets/image/eli.jpg"),
  const TicketPreview(id: 2, image: "assets/image/franken.jpg"),
  const TicketPreview(id: 3, image: "assets/image/hades.jpg")
];
List<String> titles = List<String>.filled(images.length, "");
