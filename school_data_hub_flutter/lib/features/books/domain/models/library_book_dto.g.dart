// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_book_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibraryBookDTO _$BookFromJson(Map<String, dynamic> json) => LibraryBookDTO(
      available: json['available'] as bool,
      bookId: json['book_id'] as String,
      isbn: (json['isbn'] as num).toInt(),
      location: json['location'] as String,
    );

Map<String, dynamic> _$BookToJson(LibraryBookDTO instance) => <String, dynamic>{
      'available': instance.available,
      'book_id': instance.bookId,
      'isbn': instance.isbn,
      'location': instance.location,
    };
