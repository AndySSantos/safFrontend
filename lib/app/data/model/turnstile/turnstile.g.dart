// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turnstile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Turnstile _$TurnstileFromJson(Map<String, dynamic> json) => Turnstile(
      id: json['id'] as String,
      gate: json['gate'] as int,
      location: json['location'] as String,
      urlPhoto: json['urlPhoto'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$TurnstileToJson(Turnstile instance) => <String, dynamic>{
      'id': instance.id,
      'gate': instance.gate,
      'location': instance.location,
      'urlPhoto': instance.urlPhoto,
      'state': instance.state,
    };
