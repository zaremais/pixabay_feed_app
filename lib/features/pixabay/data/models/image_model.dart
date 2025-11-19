import 'package:json_annotation/json_annotation.dart';
import 'package:pixabay_image_feed/core/conatants/typedefs.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  final int id;
  @JsonKey(name: 'previewURL')
  final String previewUrl;
  @JsonKey(name: 'largeImageURL')
  final String largeImageUrl;
  final String user;
  final String tags;

  ImageModel({
    required this.id,
    required this.previewUrl,
    required this.largeImageUrl,
    required this.user,
    required this.tags,
  });

  factory ImageModel.fromJson(JSON json) => _$ImageModelFromJson(json);

  JSON toJson() => _$ImageModelToJson(this);
}
