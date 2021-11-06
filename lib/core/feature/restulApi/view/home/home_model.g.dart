// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['id'] as int?,
      userMail: json['email'] as String?,
      fName: json['first_name'] as String?,
      lName: json['last_name'] as String?,
      avatarUrl: json['avatar'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.userId,
      'email': instance.userMail,
      'first_name': instance.fName,
      'last_name': instance.lName,
      'avatar': instance.avatarUrl,
    };
