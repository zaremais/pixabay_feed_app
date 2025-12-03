import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String url;
  const Avatar({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}

class AddAvatar extends StatelessWidget {
  const AddAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 38,
      width: 38,
      decoration: const BoxDecoration(
        color: Colors.white12,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
