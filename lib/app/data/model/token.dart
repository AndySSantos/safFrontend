import 'package:json_annotation/json_annotation.dart';
part 'token.g.dart';

//generate *.g.dart
//flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable(explicitToJson: true)
class Token {

  String token;
  String userId;

  Token({ required this.token, required this.userId });

  factory Token.fromJson(Map<String, dynamic> data) => _$TokenFromJson(data);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}