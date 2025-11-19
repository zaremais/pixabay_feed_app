import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pixabay_image_feed/core/enum/nav_item.dart';

final bottomNavProvider = StateProvider<NavItem>((ref) => NavItem.home);
final pageControllerProvider = Provider<PageController>((ref) {
  return PageController(initialPage: 0);
});
