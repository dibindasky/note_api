import 'package:json_annotation/json_annotation.dart';

import 'item.dart';
import 'meta.dart';

part 'to_do_model.g.dart';

@JsonSerializable()
class ToDoModel {

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'timestamp')
  int? timestamp;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'items')
  List<Item>? items;

  @JsonKey(name: 'meta')
  Meta? meta;

  ToDoModel({
    this.code,
    this.success,
    this.timestamp,
    this.message,
    this.items,
    this.meta,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return _$ToDoModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ToDoModelToJson(this);
}
