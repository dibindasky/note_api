// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      totalItems: json['total_items'] as int?,
      totalPages: json['total_pages'] as int?,
      perPageItem: json['per_page_item'] as int?,
      currentPage: json['current_page'] as int?,
      pageSize: json['page_size'] as int?,
      hasMorePage: json['has_more_page'] as bool?,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
      'per_page_item': instance.perPageItem,
      'current_page': instance.currentPage,
      'page_size': instance.pageSize,
      'has_more_page': instance.hasMorePage,
    };
