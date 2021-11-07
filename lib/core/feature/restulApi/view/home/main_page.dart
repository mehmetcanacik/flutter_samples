part of '../home/home_view.dart';

Widget mainPage() {
  return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (context) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (context, ValueNotifier<bool> isLoading, _) {
          return ChangeNotifierProvider<HomeViewModel>(
            create: (context) => HomeViewModel(
              isLoading: isLoading.value,
              service: UserService(dio: Dio()),
            ),
            child: Consumer<HomeViewModel>(
              builder: (context, HomeViewModel viewModel, _) => HomeView(
                viewModel: viewModel,
              ),
            ),
          );
        },
      ),
    );
}