import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../core/service/i_service.dart';
import 'model/home_model.dart';

class HomeViewModel with ChangeNotifier {
  bool isLoading;
  final IService<User> service;
  late List<User> _users;
  HomeViewModel({required this.service, required this.isLoading}) {
    _users = <User>[];
   
  }

  List<User> get users => _users;
  setLoading(bool value) {
    isLoading = value;
    log("setLoading : $isLoading");
    notifyListeners();
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
}
