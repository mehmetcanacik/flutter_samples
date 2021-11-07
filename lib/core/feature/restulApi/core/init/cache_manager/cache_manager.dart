import 'dart:convert';

import 'package:flutter_samples/core/feature/restulApi/core/base/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static final CacheManager _singleton = CacheManager._getInternal();
  CacheManager._getInternal();
  factory CacheManager() => _singleton;

  late final SharedPreferences _preferences;
  Future preferencesInit() async =>
      _preferences = await SharedPreferences.getInstance();

  Future<bool> addItemToCache<T extends IBaseModel>(
      {String? eId, T? model}) async {
    return await _preferences.setString('$T-$eId', json.encode(model));
  }
}
