import 'package:flutter_samples/core/feature/restulApi/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

class Model {
  List<User>? users;

  Model({this.users});
  Model.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      users = <User>[];
      json['data'].forEach((data) {
        users!.add(User.fromJson(data));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataList = <String, dynamic>{};
    if (users != null) {
      dataList['data'] = users!.map((user) => user.toJson()).toList();
    }
    return dataList;
  }
}

@JsonSerializable()
class User extends IBaseModel<User> {
  @JsonKey(name: 'id')
  final int? userId;
  @JsonKey(name: 'email')
  final String? userMail;
  @JsonKey(name: 'first_name')
  final String? fName;
  @JsonKey(name: 'last_name')
  final String? lName;
  @JsonKey(name: 'avatar')
  final String? avatarUrl;

  User({this.userId, this.userMail, this.fName, this.lName, this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }
}
