// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_handler.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorHandler _$ErrorHandlerFromJson(Map<String, dynamic> json) => ErrorHandler(
      message: json['message'] as String,
      code: json['code'] as int,
    );

Map<String, dynamic> _$ErrorHandlerToJson(ErrorHandler instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
    };
