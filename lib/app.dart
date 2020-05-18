import 'package:flutter/material.dart';
import 'package:politics/_routing/routes.dart';
import 'package:politics/_routing/router.dart' as router;
import 'package:politics/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social',
      debugShowCheckedModeBanner: false,
      theme: buildThemeData(),
      onGenerateRoute: router.generateRoute,
      initialRoute: landingViewRoute,
    );
  }
}
