import 'package:flutter/material.dart';

class BoardsScreen extends StatelessWidget {
  const BoardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Boards Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
