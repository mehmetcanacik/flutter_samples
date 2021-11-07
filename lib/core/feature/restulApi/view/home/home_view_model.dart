
import 'package:flutter/foundation.dart';

import '../../core/base/i_base_view_model.dart';
import '../../core/init/cache_manager/cache_manager.dart';
import '../../core/service/i_service.dart';
import 'model/home_model.dart';

class HomeViewModel with ChangeNotifier, IBaseViewModel {
  bool isLoading;
  final IService<User> service;
  List<User> _users = <User>[];
  HomeViewModel({required this.service, required this.isLoading}) {
    notifyListeners();
  }

  List<User> get users => _users;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future addCache(User user) async {
    await CacheManager()
        .addItemToCache<User>(eId: user.userId.toString(), model: user);
    notifyListeners();
  }

  User? getItem(User user) {
    return CacheManager().getItemFromCache<User>(eId: user.userId.toString());
  }

  Future removeItem(User user) async {
    await CacheManager().removeItem<User>(eId: user.userId.toString());
  }

  List<User> allCacheData() {
    return CacheManager().getAllItems<User>(model: User());
  }

  Future fetchUsers() async {
    try {
      setLoading(true);
      _users = await service.fetchUsers();
      setLoading(false);
    } catch (e) {
      setLoading(false);
      throw Exception(e.toString());
    }
  }

  bool isCachedData(User user) {
    return CacheManager().isCachedData<User>(user.userId.toString());
  }

  @override
  setInit() {
    
  }
}
