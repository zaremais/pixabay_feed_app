import 'package:flutter/material.dart';

class LoadingGridIndicator extends StatelessWidget {
  const LoadingGridIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}




