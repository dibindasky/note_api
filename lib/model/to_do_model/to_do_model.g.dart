// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoModel _$ToDoModelFromJson(Map<String, dynamic> json) => ToDoModel(
      code: json['code'] as int?,
      success: json['success'] as bool?,
      timestamp: json['timestamp'] as int?,
      message: json['message'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ToDoModelToJson(ToDoModel instance) => <String, dynamic>{
      'code': instance.code,
      'success': instance.success,
      'timestamp': instance.timestamp,
      'message': instance.message,
      'items': instance.items,
      'meta': instance.meta,
    };
