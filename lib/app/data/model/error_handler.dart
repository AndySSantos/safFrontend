import 'package:json_annotation/json_annotation.dart';
part 'error_handler.g.dart';

//generate *.g.dart
//flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable(explicitToJson: true)
class ErrorHandler {

  String message;
  int code;

  ErrorHandler({ required this.message, required this.code });

  factory ErrorHandler.fromJson(Map<String, dynamic> data) => _$ErrorHandlerFromJson(data);

  Map<String, dynamic> toJson() => _$ErrorHandlerToJson(this);
}