import 'package:flutter/material.dart';
import 'package:flutter_samples/core/feature/restulApi/core/init/cache_manager/cache_manager.dart';
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
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    userList = <User>[];
    userList = CacheManager().getAllItems(model: User());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: userList.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  var user = userList[index];
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: .5, color: Colors.black))),
                    child: Dismissible(
                      direction: DismissDirection.horizontal,
                      key: ValueKey(user.userId),
                      onDismissed: (state) async {
                        await CacheManager()
                            .removeItem(eId: user.userId.toString());
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage(user.avatarUrl ?? "")),
                        title: Text(user.userMail ?? "Empty User"),
                        trailing: IconButton(
                            onPressed: () async {
                              var response = await CacheManager()
                                  .removeItem<User>(
                                      eId: user.userId.toString());
                              debugPrint("Gelen user :$response");
                            },
                            icon: const Icon(Icons.attach_file)),
                      ),
                    ),
                  );
                },
                itemCount: userList.length,
              )
            : const Text("Veri Yok!"));
  }
}
