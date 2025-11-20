import 'package:flutter/material.dart';

class EmptyImageState extends StatelessWidget {
  final TextEditingController searchController;

  const EmptyImageState({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_search, color: Colors.white54, size: 64),
          const SizedBox(height: 16),
          const Text(
            'No images found',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            searchController.text.isEmpty
                ? 'Try searching for something else'
                : 'No results for "${searchController.text}"',
            style: const TextStyle(color: Colors.white54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
