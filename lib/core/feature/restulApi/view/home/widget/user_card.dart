import 'package:flutter/material.dart';

import '../home_model.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      elevation: 5.0,
      shadowColor: Colors.black87,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
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
