import 'package:json_annotation/json_annotation.dart';
part 'credentials.g.dart';

//generate *.g.dart
//flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable(explicitToJson: true)
class Credentials {

  String email;
  String password;

  Credentials({ required this.email, required this.password });

  factory Credentials.fromJson(Map<String, dynamic> data) => _$CredentialsFromJson(data);

  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}