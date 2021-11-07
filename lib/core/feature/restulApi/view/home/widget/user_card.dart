import 'package:flutter/material.dart';

import '../home_model.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black54))),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        title: Text(user.fName ?? ""),
        subtitle: Text(user.userMail ?? ""),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(user.avatarUrl ?? ""),
        ),
      ),
    );
  }
}
