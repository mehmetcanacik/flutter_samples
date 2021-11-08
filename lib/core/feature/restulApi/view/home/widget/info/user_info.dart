import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/init/cache_manager/cache_manager.dart';
import 'package:flutter_samples/core/feature/restulApi/view/home/model/home_model.dart';

class UserInfoView extends StatefulWidget {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  State<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  late List<User> userList;

  @override
  void initState() {
    super.initState();
    userList = <User>[];
    fetchUser();
  }

  fetchUser() {
    userList = CacheManager().getAllItems(model: User());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: userList.isNotEmpty ? userListWidget() : noDataWidget(context));
  }

  Widget userListWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        var user = userList[index];
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: .5, color: Colors.black))),
          child: ListTile(
            leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(user.avatarUrl ?? "")),
            title: Text(user.userMail ?? "Empty User"),
            trailing: IconButton(
                onPressed: () async {
                  await CacheManager()
                      .removeItem<User>(eId: user.userId.toString());
                  setState(() {
                    fetchUser();
                  });
                },
                icon: const Icon(Icons.attach_file)),
          ),
        );
      },
      itemCount: userList.length,
    );
  }

  Widget noDataWidget(BuildContext context) {
    return SizedBox(
      width: context.pageWidth,
      height: context.pageHeight,
      child: const Center(
        child: Text("Veri Yok!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54)),
      ),
    );
  }
}
