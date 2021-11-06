import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/base/base_widget.dart';
import '../../core/service/i_service.dart';
import 'home_model.dart';
import 'widget/user_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends DraftPage<HomeView> {
   List<User> userList=<User>[];
  late final UserService service;

  Future fetchUser() async {
    userList = await service.fetchUsers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    service = UserService(dio: Dio());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUser,
      ),
      body: Container(
          width: pageWidth,
          height: pageHeight,
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return UserCard(
                          user: userList[index],
                        );
                      },
                      itemCount: userList.length),
                ),
              ),
            ],
          )),
    );
  }
}
