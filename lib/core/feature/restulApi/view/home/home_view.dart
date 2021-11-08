import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_widget.dart';
import '../../core/service/i_service.dart';
import 'home_view_model.dart';
import 'model/home_model.dart';
import 'widget/info/user_info.dart';
import 'widget/loading_widget.dart';

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
      floatingActionButton: fetcUserWidget(),
      appBar: topBarWidget(context),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SizedBox(
      height: pageHeight,
      width: pageWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: viewModel.isLoading
                  ? LoadingWidget(
                      context: context, color: Colors.red, width: 3.0)
                  : userBuilder,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget? topBarWidget(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
            onPressed: () async {
              await Navigator.push<bool>(
                context,
                CupertinoPageRoute(
                  builder: (context) => const UserInfoView(),
                ),
              );
            },
            icon: const Icon(Icons.cached))
      ],
    );
  }

  FloatingActionButton fetcUserWidget() {
    return FloatingActionButton(
        onPressed: viewModel.fetchUsers,
        child: const Icon(Icons.access_time_filled_sharp));
  }

  Widget _buildRow(User user) {
    final _isAlreadySaved = viewModel.savedUsers.contains(user.userMail);
    return ListTile(
      title: Text(user.fName ?? ""),
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(user.avatarUrl ?? ""),
      ),
      subtitle: Text(user.userMail ?? ""),
      trailing: Icon(_isAlreadySaved ? Icons.favorite : Icons.favorite_border,
          color: _isAlreadySaved ? Colors.red : null),
      onTap: () async {
        if (_isAlreadySaved) {
          await viewModel.removeItem(user);
        } else {
          await viewModel.addCache(user);
        }
        // setState(() {});
      },
    );
  }

  Widget get userBuilder => ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var user = viewModel.users[index];
        // log("List View içiçnde User : ${user.userMail}");
        return _buildRow(user);
      },
      itemCount: viewModel.users.length);
}
