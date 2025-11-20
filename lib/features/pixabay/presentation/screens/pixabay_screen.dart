import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixabay_image_feed/core/config/themes/app_icons.dart';
import 'package:pixabay_image_feed/features/pixabay/domain/entities/image_entity.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/notifier/image_notifire.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/widgets/circle_button_notification.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/widgets/error_text_widget.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/widgets/image_details_sheet.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/widgets/image_grid.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/widgets/loading_indicator.dart';
import 'package:pixabay_image_feed/features/pixabay/presentation/widgets/search_textfield_widget.dart';

class PixabayScreen extends ConsumerStatefulWidget {
  const PixabayScreen({super.key});

  @override
  ConsumerState<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends ConsumerState<PixabayScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isLoadingNext = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _loadNextPage();
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingNext) return;

    setState(() {
      _isLoadingNext = true;
    });

    await ref.read(imageListProvider.notifier).loadNextPage();

    setState(() {
      _isLoadingNext = false;
    });
  }

  Future<void> _onRefresh() async {
    return ref.read(imageListProvider.notifier).refresh();
  }

  void _onSearchChanged(String query) {
    ref.read(imageListProvider.notifier).changeQuery(query);
  }

  void _showImageDetail(ImageEntity image) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ImageDetailSheet(image: image),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageListProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleButtonNotification(icon: AppIcons.bell, badge: true),

                  Expanded(
                    child: SearchTextField(
                      searchController: _searchController,
                      onSearchChanged: _onSearchChanged,
                      hintText: 'Search images...',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: state.when(
                  loading: () => LoadingGridIndicator(),
                  error: (error, stackTrace) => ErrorTextWidget(
                    error: 'Try Again',
                    title: 'Something went wrong',
                    onPressed: _onRefresh,
                  ),
                  data: (images) => ImageGrid(
                    images: images,
                    scrollController: _scrollController,
                    isLoadingNext: _isLoadingNext,
                    searchController: _searchController,
                    onRefresh: _onRefresh,
                    onImageTap: _showImageDetail,
                    loadNextPage: _loadNextPage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
