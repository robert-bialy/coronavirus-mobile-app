import 'package:coronavirus/bloc/app_state.dart';
import 'package:coronavirus/bloc/repository.dart';
import 'package:coronavirus/constants.dart';
import 'package:coronavirus/pages/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Constants.violet
      ),
      home: Provider<AppState>(
        create: (_) => AppState(new Repository()),
        child: HomePage(),
      ),
    );
  }
}