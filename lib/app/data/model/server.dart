import 'package:json_annotation/json_annotation.dart';
part 'server.g.dart';

//generate *.g.dart
//flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable(explicitToJson: true)
class Server {

  String message;

  Server({ required this.message });

  factory Server.fromJson(Map<String, dynamic> data) => _$ServerFromJson(data);

  Map<String, dynamic> toJson() => _$ServerToJson(this);
}