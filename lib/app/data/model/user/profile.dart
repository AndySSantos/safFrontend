import 'package:json_annotation/json_annotation.dart';
part 'profile.g.dart';


@JsonSerializable(explicitToJson: true)
class Profile{
  String userId;
  String user;
  String email;
  bool emailVerified;
  String lastUpgradeFace;

  Profile({required this.userId,required this.user,required this.email,required this.emailVerified, required this.lastUpgradeFace});
  factory Profile.fromJson(Map<String,dynamic> data) => _$ProfileFromJson(data);
  Map<String,dynamic> toJson() => _$ProfileToJson(this);
}