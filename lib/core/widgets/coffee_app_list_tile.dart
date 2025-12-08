import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/core/utils/app_size.dart';
import 'package:pixabay_image_feed/core/utils/gen/assets.gen.dart';
import 'package:pixabay_image_feed/core/widgets/app_svg_viewer.dart';

class CoffeeAppListTile extends StatelessWidget {
  const CoffeeAppListTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.leadingIconPath,
    this.trailing,
    this.padding,
    required this.icon,
  });

  final GestureTapCallback onTap;
  final String title;
  final String leadingIconPath;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: Dimens.smallPadding),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          // color: Colors.black.withValues(alpha: 0.6),
        ),
      ),
      leading: Icon(icon),
      // AppSvgViewer(leadingIconPath, width: 19, color: Colors.white),
      trailing: trailing ?? AppSvgViewer(Assets.icons.arrowRight4, width: 16),
    );
  }
}
