import 'package:flutter/foundation.dart';
import '../../core/base/i_base_view_model.dart';
import '../../core/init/cache_manager/cache_manager.dart';
import '../../core/service/i_service.dart';
import 'model/home_model.dart';

class HomeViewModel with ChangeNotifier, IBaseViewModel {
  bool isLoading;
  final IService<User> service;
  List<User> _users = <User>[];
  final List<User> _cachedUsers = <User>[];
  final Set<String> _savedUsers = <String>{};
  HomeViewModel({required this.service, required this.isLoading}) {
    setInit();
  }
  late bool isAlreadySaved;
  Set<String> get savedUsers => _savedUsers;
  List<User> get users => _users;
  List<User> get cachedUsers => _cachedUsers;

  setLoading(bool value) {
    isLoading = value;
    _savedUsers.addAll(allCacheData().map((e) => e.userMail!));
    notifyListeners();
  }

  Future<bool> addCache(User user) async {
    _savedUsers.add(user.userMail!);
    notifyListeners();
    return await CacheManager()
        .addItemToCache<User>(eId: user.userId.toString(), model: user);
  }

  User? getItem(User user) {
    return CacheManager().getItemFromCache<User>(eId: user.userId.toString());
  }

  Future<bool> removeItem(User user) async {
    _savedUsers.remove(user.userMail);
    notifyListeners();
    return await CacheManager().removeItem<User>(eId: user.userId.toString());
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
  setInit() async {
    _savedUsers.addAll(allCacheData().map((e) => e.userMail!));
    notifyListeners();
  }
}
