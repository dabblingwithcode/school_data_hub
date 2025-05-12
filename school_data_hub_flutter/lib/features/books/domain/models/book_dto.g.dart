// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookTag _$BookTagFromJson(Map<String, dynamic> json) => BookTag(
      name: json['name'] as String,
    );

Map<String, dynamic> _$BookTagToJson(BookTag instance) => <String, dynamic>{
      'name': instance.name,
    };

BookDTO _$BookFromJson(Map<String, dynamic> json) => BookDTO(
      author: json['author'] as String,
      description: json['description'] as String?,
      imageId: json['image_id'] as String?,
      isbn: (json['isbn'] as num).toInt(),
      readingLevel: json['reading_level'] as String,
      title: json['title'] as String,
      bookTags: (json['book_tags'] as List<dynamic>?)
          ?.map((e) => BookTag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookToJson(BookDTO instance) => <String, dynamic>{
      'author': instance.author,
      'description': instance.description,
      'image_id': instance.imageId,
      'isbn': instance.isbn,
      'reading_level': instance.readingLevel,
      'title': instance.title,
      'book_tags': instance.bookTags,
    };
