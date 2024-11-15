import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;

  const CustomNetworkImage({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey[100],
        child: const Center(
          child: Column(
            children: [
              Icon(
                Icons.warning_rounded,
                color: Colors.black,
              ),
              Text("이미지를 불러올 수 없습니다."),
            ],
          ),
        ),
      ),
    );
  }
}
