import 'dart:io';
import 'package:dio/dio.dart';
import '../../view/home/model/home_model.dart';
import '../base/base_model.dart';
import '../constants/app_constants.dart';

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
