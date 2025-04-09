/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../learning_support/support_goal/support_goal.dart' as _i2;
import '../learning_support/support_category_status.dart' as _i3;

abstract class SupportCategory implements _i1.SerializableModel {
  SupportCategory._({
    this.id,
    required this.name,
    required this.categoryId,
    this.parentCategory,
    this.categoryGoals,
    this.categoryStatues,
  });

  factory SupportCategory({
    int? id,
    required String name,
    required int categoryId,
    int? parentCategory,
    List<_i2.SupportGoal>? categoryGoals,
    List<_i3.SupportCategoryStatus>? categoryStatues,
  }) = _SupportCategoryImpl;

  factory SupportCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupportCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      categoryId: jsonSerialization['categoryId'] as int,
      parentCategory: jsonSerialization['parentCategory'] as int?,
      categoryGoals: (jsonSerialization['categoryGoals'] as List?)
          ?.map((e) => _i2.SupportGoal.fromJson((e as Map<String, dynamic>)))
          .toList(),
      categoryStatues: (jsonSerialization['categoryStatues'] as List?)
          ?.map((e) =>
              _i3.SupportCategoryStatus.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  int categoryId;

  int? parentCategory;

  List<_i2.SupportGoal>? categoryGoals;

  List<_i3.SupportCategoryStatus>? categoryStatues;

  /// Returns a shallow copy of this [SupportCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportCategory copyWith({
    int? id,
    String? name,
    int? categoryId,
    int? parentCategory,
    List<_i2.SupportGoal>? categoryGoals,
    List<_i3.SupportCategoryStatus>? categoryStatues,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'categoryId': categoryId,
      if (parentCategory != null) 'parentCategory': parentCategory,
      if (categoryGoals != null)
        'categoryGoals': categoryGoals?.toJson(valueToJson: (v) => v.toJson()),
      if (categoryStatues != null)
        'categoryStatues':
            categoryStatues?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportCategoryImpl extends SupportCategory {
  _SupportCategoryImpl({
    int? id,
    required String name,
    required int categoryId,
    int? parentCategory,
    List<_i2.SupportGoal>? categoryGoals,
    List<_i3.SupportCategoryStatus>? categoryStatues,
  }) : super._(
          id: id,
          name: name,
          categoryId: categoryId,
          parentCategory: parentCategory,
          categoryGoals: categoryGoals,
          categoryStatues: categoryStatues,
        );

  /// Returns a shallow copy of this [SupportCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportCategory copyWith({
    Object? id = _Undefined,
    String? name,
    int? categoryId,
    Object? parentCategory = _Undefined,
    Object? categoryGoals = _Undefined,
    Object? categoryStatues = _Undefined,
  }) {
    return SupportCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      parentCategory:
          parentCategory is int? ? parentCategory : this.parentCategory,
      categoryGoals: categoryGoals is List<_i2.SupportGoal>?
          ? categoryGoals
          : this.categoryGoals?.map((e0) => e0.copyWith()).toList(),
      categoryStatues: categoryStatues is List<_i3.SupportCategoryStatus>?
          ? categoryStatues
          : this.categoryStatues?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
