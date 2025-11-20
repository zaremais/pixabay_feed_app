import 'package:flutter/material.dart';
import 'package:pixabay_image_feed/core/config/themes/app_icons.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String)? onSearchChanged;
  final String? hintText;
  const SearchTextField({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              onChanged: onSearchChanged,
            ),
          ),

          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white10,

              shape: BoxShape.circle,
            ),
            child: Icon(AppIcons.search, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
