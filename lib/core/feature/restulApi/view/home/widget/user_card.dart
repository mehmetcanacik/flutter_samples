import 'package:flutter/material.dart';
import '../../../core/init/cache_manager/cache_manager.dart';

import '../model/home_model.dart';

class UserCard extends StatefulWidget {
  final User user;
  final VoidCallback onPressed;
  const UserCard({Key? key, required this.user, required this.onPressed})
      : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  late bool data;
  @override
  void initState() {
    super.initState();
    data = CacheManager().isCachedData<User>(widget.user.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black54))),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        title: Text(widget.user.fName ?? ""),
        subtitle: Text(widget.user.userMail ?? ""),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(widget.user.avatarUrl ?? ""),
        ),
        trailing: IconButton(
            icon: Icon(Icons.bookmark_add,
                color: data ? Colors.red : Colors.grey),
            onPressed: widget.onPressed),
      ),
    );
  }
}
