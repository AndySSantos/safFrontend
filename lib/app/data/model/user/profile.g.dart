// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      userId: json['userId'] as String,
      user: json['user'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
      lastUpgradeFace: json['lastUpgradeFace'] as String,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'userId': instance.userId,
      'user': instance.user,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'lastUpgradeFace': instance.lastUpgradeFace,
    };
