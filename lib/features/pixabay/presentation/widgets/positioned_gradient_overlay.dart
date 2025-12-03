import 'package:flutter/material.dart';

class PositionedGradientOverlay extends StatelessWidget {
  const PositionedGradientOverlay({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withValues(alpha: 0.85), Colors.transparent],
            stops: const [0.0, 0.6],
          ),
        ),
      ),
    );
  }
}
