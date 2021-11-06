import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/core/feature/restulApi/core/base/base_model.dart';
import 'package:flutter_samples/core/feature/restulApi/core/cosntants/app_constants.dart';
import 'package:flutter_samples/core/feature/restulApi/view/home/home_model.dart';

abstract class IService<T extends IBaseModel> {
  final Dio dio;
  final baseUrl = "https://reqres.in/api";
  IService({required this.dio});
  Future<List<T>> fetchUsers();
}

class UserService extends IService<User> {
  UserService({required Dio dio}) : super(dio: dio);

  @override
  Future<List<User>> fetchUsers() async {
    final responseBody = await dio.get('$baseUrl${AppUtils.userPath}');
    if (responseBody.statusCode == HttpStatus.ok) {
      final jsonItem = responseBody.data;
      if (jsonItem is Map<String, dynamic>) {
        return Model.fromJson(jsonItem).users ?? [];
      }
     
    }
    return [];
  }
}
