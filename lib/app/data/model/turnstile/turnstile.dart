import 'package:json_annotation/json_annotation.dart';
part 'turnstile.g.dart';


@JsonSerializable(explicitToJson: true)
class Turnstile{
  String id;
  int gate;
  String location;
  String urlPhoto;
  String state;

  Turnstile({required this.id,required this.gate,required this.location,required this.urlPhoto, required this.state});
  factory Turnstile.fromJson(Map<String,dynamic> data) => _$TurnstileFromJson(data);
  Map<String,dynamic> toJson() => _$TurnstileToJson(this);
}