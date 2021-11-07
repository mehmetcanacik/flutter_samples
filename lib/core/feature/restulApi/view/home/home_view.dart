import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
        return UserCard(
          user: viewModel.users[index],
        );
      },
      itemCount: viewModel.users.length);
}
