import 'package:flutter/material.dart';
import 'package:flutter_samples/core/feature/restulApi/core/init/cache_manager/cache_manager.dart';
import 'core/feature/restulApi/view/home/home_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager().preferencesInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeViewProvider(),
    );
  }
}
