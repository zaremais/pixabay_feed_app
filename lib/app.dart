import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/navigation/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixabay Demo',
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}
