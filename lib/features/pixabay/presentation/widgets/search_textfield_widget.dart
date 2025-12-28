import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController searchController;

  final VoidCallback? onSearchTap;
  final String? hintText;
  const SearchTextField({
    super.key,
    required this.searchController,

    this.hintText,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
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

                onSubmitted: (_) => onSearchTap?.call(),
              ),
            ),

            IconButton(
              onPressed: onSearchTap,
              icon: Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
