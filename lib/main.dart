import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay_image_feed/app.dart';
import 'package:pixabay_image_feed/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  runApp(ProviderScope(child: const MyApp()));
}
