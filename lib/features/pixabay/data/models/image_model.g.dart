// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
  id: (json['id'] as num).toInt(),
  previewUrl: json['previewURL'] as String,
  largeImageUrl: json['largeImageURL'] as String,
  user: json['user'] as String,
  tags: json['tags'] as String,
);

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'previewURL': instance.previewUrl,
      'largeImageURL': instance.largeImageUrl,
      'user': instance.user,
      'tags': instance.tags,
    };
