class ImageEntity {
  final int id;
  final String previewUrl;
  final String largeImageUrl;
  final String user;
  final String tags;

  ImageEntity({
    required this.id,
    required this.previewUrl,
    required this.largeImageUrl,
    required this.user,
    required this.tags,
  });
}
