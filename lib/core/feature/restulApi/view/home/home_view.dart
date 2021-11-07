import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/core/feature/restulApi/view/home/widget/info/user_info.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_widget.dart';
import '../../core/service/i_service.dart';
import 'home_view_model.dart';
import 'widget/loading_widget.dart';
import 'widget/user_card.dart';
part 'main_page.dart';

class HomeViewProvider extends StatelessWidget {
  const HomeViewProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mainPage();
  }
}

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeView({Key? key, required this.viewModel}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends DraftPage<HomeView> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.fetchUsers,
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                var response = await Navigator.push<bool>(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const UserInfoView(),
                  ),
                );
                if (response != null) {
                  debugPrint("Gelen cevap: $response");
                }
              },
              icon: const Icon(Icons.cached))
        ],
      ),
      body: SizedBox(
        height: pageHeight,
        width: pageWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                // primary: true,
                child: viewModel.isLoading
                    ? LoadingWidget(
                        context: context, color: Colors.red, width: 3.0)
                    : userBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get userBuilder => ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var user = viewModel.users[index];
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          title: Text(user.fName ?? ""),
          subtitle: Text(user.userMail ?? ""),
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(user.avatarUrl ?? ""),
          ),
          trailing: IconButton(
              icon: const Icon(Icons.bookmark_add, color: Colors.grey),
              onPressed: () async {
                await viewModel.addCache(user);
              }),
        );
      },
      itemCount: viewModel.users.length);
}
