// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String?,
      userName: json['userName'] as String?,
      headerImg: json['headerImg'] as String?,
      integral: json['integral'] as int?,
      creditValue: json['creditValue'] as int?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userName': instance.userName,
      'headerImg': instance.headerImg,
      'integral': instance.integral,
      'creditValue': instance.creditValue,
      'userId': instance.userId,
    };
