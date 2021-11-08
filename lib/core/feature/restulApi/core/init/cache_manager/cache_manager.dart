import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../view/home/model/home_model.dart';
import '../../base/i_base_model.dart';

class CacheManager {
  static final CacheManager _singleton = CacheManager._getInternal();
  CacheManager._getInternal();
  factory CacheManager() => _singleton;

  late final SharedPreferences _preferences;
  Future preferencesInit() async {
    _preferences = await SharedPreferences.getInstance();
    // _preferences.clear();
  }

  Future<bool> addItemToCache<T extends IBaseModel>(
      {String? eId, T? model}) async {
    return await _preferences.setString(_key<T>(eId!), json.encode(model));
  }

  Future<bool> removeItem<T extends IBaseModel>({String? eId}) async {
    if (getItemFromCache<T>(eId: eId) != null) {
      return await _preferences.remove(_key<T>(eId!));
    }
    return false;
  }

  User? getItemFromCache<T extends IBaseModel>({String? eId}) {
    var response = _preferences.getString(_key<T>(eId!));
    if (response != null) {
      return User.fromJson(json.decode(response));
    }
    return User(userId: 1, userMail: "Empty Mail");
  }

  List<T> getAllItems<T extends IBaseModel>({IBaseModel? model}) {
    final cachedData =
        _preferences.getKeys().where((key) => key.contains('$T-')).toList();
    if (cachedData.isNotEmpty) {
      return cachedData
          .map((key) => model
              ?.fromJson(json.decode(_preferences.getString(key) ?? "")) as T)
          .toList();
    }
    return [];
  }

  String _key<T>(String eId) => '$T-$eId';
  void removeAllItem<T extends IBaseModel>(IBaseModel model) {
    var response = _preferences
        .getKeys()
        .where((element) => element.contains(_key<T>('$T-')))
        .toList();
    response.map((e) => _preferences.remove(json.decode(e)) as T);
  }

  bool isCachedData<T extends IBaseModel>(String eId) {
    return _preferences.getString(_key<T>(eId)) != null ? true : false;
  }
}
