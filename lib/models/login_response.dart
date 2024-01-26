import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String? token;
  final String? userName;
  final String? headerImg;
  final int? integral;
  final int? creditValue;
  final String? userId;

  const LoginResponse({
    this.token,
    this.userName,
    this.headerImg,
    this.integral,
    this.creditValue,
    this.userId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
